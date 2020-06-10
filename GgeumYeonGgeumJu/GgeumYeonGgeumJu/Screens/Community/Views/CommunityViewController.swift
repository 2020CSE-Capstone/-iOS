//
//  CommunityViewController.swift
//  GgeumYeonGgeumJu
//
//  Created by 남수김 on 2020/05/16.
//  Copyright © 2020 남수김. All rights reserved.
//

import UIKit
import SnapKit

enum CommunityListType {
    case recent
    case popular
    case myBoard
}

class CommunityViewController: UIViewController {

    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var tabUnderLineView: UIView!
    @IBOutlet weak var headerViewTopLayout: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: UIImageView!
    private let service: CommunityServiceProtocol
        = DependencyContainer.shared.getDependency(key: .communityService)
    private let originHeaderHeight: CGFloat = 200 - 44
    private var isLoading = false {
        willSet {
            if newValue {
                DispatchQueue.main.async {
                    self.indicator.startAnimating()
                }
            } else {
                DispatchQueue.main.async {
                    self.indicator.stopAnimating()
                }
            }
        }
    }
    private var type: CommunityListType = .recent
    
    private var tabUnderLayout: [NSLayoutConstraint] = []
    private var communityList: [CommunityListModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        requestList(type: type)
    }
    
    func requestList(type: CommunityListType) {
        isLoading = true
        service.requestCommunityList(type: type) { [weak self] list in
            guard let list = list else {
                return
            }
            self?.communityList = list
            self?.isLoading = false
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    func underBarAnimation(view: UIButton) {
        tabUnderLineView.snp.removeConstraints()
        tabUnderLineView.snp.makeConstraints {
            $0.leading.equalTo(view.snp.leading)
            $0.trailing.equalTo(view.snp.trailing)
        }
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: CommunityTableViewCell.nibName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: CommunityTableViewCell.reuseIdentifier)
        tableView.estimatedRowHeight = 1000
        tableView.rowHeight = UITableView.automaticDimension
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: originHeaderHeight, right: 0)
    }
    
    @IBAction func recentOrderClick(_ sender: UIButton) {
        underBarAnimation(view: sender)
        type = .recent
        requestList(type: .recent)
    }
    
    @IBAction func popularOrderClick(_ sender: UIButton) {
        underBarAnimation(view: sender)
        type = .popular
        requestList(type: .popular)
    }
    
    @IBAction func myBoardClick(_ sender: UIButton) {
        underBarAnimation(view: sender)
        type = .myBoard
        requestList(type: .myBoard)
    }
    
    @IBAction func writeClick(_ sender: Any) {
        guard let nextVC = storyboard?.instantiateViewController(withIdentifier: ViewControllerIdentifier.communityWriteVC.rawValue) as? CommunityWriteViewController else {
            return
        }
        
        navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension CommunityViewController: UITableViewDataSource ,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return communityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommunityTableViewCell.reuseIdentifier, for: indexPath) as? CommunityTableViewCell else {
            return UITableViewCell(style: .default, reuseIdentifier: "")
        }
        cell.bind(model: communityList[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let cell = tableView.cellForRow(at: indexPath) as? CommunityTableViewCell else {
            return
        }
        let boardIdx = cell.model.boardIdx
        
        guard let nextVC = storyboard?.instantiateViewController(withIdentifier: ViewControllerIdentifier.communityDetailVC.rawValue) as? CommunityDetailViewController else {
            return
        }
        nextVC.hidesBottomBarWhenPushed = true
        isLoading = true
        DispatchQueue.global().async {

            self.service.requestCommunityWithBoardIdx(boardIdx: boardIdx) { [weak self] data in
                guard let data = data,
                    let self = self else {
                        return
                }
                nextVC.model = data
                self.isLoading = false
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(nextVC, animated: true)
                    
                }
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let posY = scrollView.contentOffset.y > originHeaderHeight ?
            originHeaderHeight : scrollView.contentOffset.y
        headerViewTopLayout.constant = -posY
    }
    
}
