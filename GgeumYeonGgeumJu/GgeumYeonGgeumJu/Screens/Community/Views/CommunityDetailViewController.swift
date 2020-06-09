//
//  CommunityDetailViewController.swift
//  GgeumYeonGgeumJu
//
//  Created by 남수김 on 2020/05/27.
//  Copyright © 2020 남수김. All rights reserved.
//

import UIKit

class CommunityDetailViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var tableView: UITableView!
    
    var model: CommunityListModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCommentTextView()
        setupTableView()
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
    @IBAction func backClick(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension CommunityDetailViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommentTableViewCell.reuseIdentifier,
                                                       for: indexPath) as? CommentTableViewCell else {
            return .init(style: .default, reuseIdentifier: "")
        }
        
        cell.commentMargin()
        
        return cell
    }
}

extension CommunityDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CommunityHeader") as? CommunityHeader,
            let model = model else {
            return nil
        }
        header.bind(model: model)
        return header
    }
    
}

