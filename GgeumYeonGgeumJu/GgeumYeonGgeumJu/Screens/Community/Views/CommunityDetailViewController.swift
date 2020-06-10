//
//  CommunityDetailViewController.swift
//  GgeumYeonGgeumJu
//
//  Created by 남수김 on 2020/05/27.
//  Copyright © 2020 남수김. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class CommunityDetailViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var optionButton: UIButton!
    @IBOutlet weak var textViewBotLayout: NSLayoutConstraint!
    
    var model: CommunityListModel?
    var commentModelList: [CommentModel] = [] {
        willSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private let service: CommunityServiceProtocol
    = DependencyContainer.shared.getDependency(key: .communityService)
    private var isLoading = false
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestComment()
        setupCommentTextView()
        setupTableView()
        
        let userId = 1
        if userId == model?.userId {
            optionButton.isHidden = false
        }
        bind()
    }
    
    func bind() {
        keyboardHeight()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] height, duration in
                self?.textViewBotLayout.constant = height
                UIView.animate(withDuration: duration) {
                    self?.view.layoutIfNeeded()
                }
            })
            .disposed(by: disposeBag)
    }
    
    func requestComment() {
        guard let boardIdx = model?.boardIdx else {
            return
        }
        service.requestComment(boardIdx: boardIdx) { list in
            guard let list = list else {
                return
            }
            self.commentModelList = list
        }
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        let headerNib = UINib(nibName: "CommunityHeader", bundle: .main)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "CommunityHeader")
        let commentNib = UINib(nibName: CommentTableViewCell.nibName, bundle: nil)
        
        tableView.register(commentNib,
                           forCellReuseIdentifier: CommentTableViewCell.reuseIdentifier)
        tableView.estimatedRowHeight = 500
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 500
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        
    }
    
    func setupCommentTextView() {
        commentTextView.delegate = self
        resizeTextView()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(resizeTextView),
                                               name: UITextView.textDidChangeNotification,
                                               object: nil)
    }
    
    @objc
    func resizeTextView() {
        let estimateSize = CGSize(width: commentTextView.frame.width, height: .greatestFiniteMagnitude)
        let size = commentTextView.sizeThatFits(estimateSize)
        
        if size.height > 200 {
            return
        }
        commentTextView.constraints.forEach {
            if $0.firstAttribute == .height {
                $0.constant = size.height
            }
        }
    }
    
    @IBAction func writeComment(_ sender: Any) {
        guard let boardIdx = model?.boardIdx, !isLoading else {
            return
        }
        guard commentTextView.hasText else {
            return
        }
        isLoading = true
        service.requestWriteComment(boardIdx: boardIdx, content: commentTextView.text) { [weak self] isSuccess in
            guard let self = self else {
                return
            }
            if isSuccess {
                self.commentTextView.text = ""
                self.alertWithHandler(title: "작성완료", message: "작성되었습니다.") { _ in
                    self.requestComment()
                }
            }
            self.isLoading = false
        }
    }
    
    func boardOption() {
        guard let model = self.model else {
            return
        }
        let modify = UIAlertAction(title: "수정", style: .default) { _ in
            guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: ViewControllerIdentifier.communityWriteVC.rawValue) as? CommunityWriteViewController else {
                return
            }
            nextVC.titleText = model.title
            nextVC.contentText = model.content
            nextVC.isModify = true
            nextVC.boardIdx = model.boardIdx
            
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
        
        let delete = UIAlertAction(title: "삭제", style: .destructive) { _ in
           
            self.service.requestDeleteCommunity(boardIdx: model.boardIdx) { isSuccess in
                if isSuccess {
                    self.alertWithHandler(title: "삭제완료", message: "삭제되었습니다.") { _ in
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        simpleActionSheet(title: "실행할 옵션을 선택해주세요", actions: [modify, delete, cancel])
    }
    
    @IBAction func moreButton(_ sender: Any) {
        boardOption()
    }
    
    @IBAction func backClick(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension CommunityDetailViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentModelList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommentTableViewCell.reuseIdentifier,
                                                       for: indexPath) as? CommentTableViewCell else {
            return .init(style: .default, reuseIdentifier: "")
        }
        
        cell.bind(model: commentModelList[indexPath.row])
        
        return cell
    }
}

extension CommunityDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CommunityHeader") as? CommunityHeader,
            let model = model else {
            return nil
        }

        header.contentView.backgroundColor = .clear
        header.bind(model: model)
        return header
    }
    
}
