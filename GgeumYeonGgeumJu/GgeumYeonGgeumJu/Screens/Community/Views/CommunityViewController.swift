//
//  CommunityViewController.swift
//  GgeumYeonGgeumJu
//
//  Created by 남수김 on 2020/05/16.
//  Copyright © 2020 남수김. All rights reserved.
//

import UIKit
import SnapKit

class CommunityViewController: UIViewController {

    
    @IBOutlet weak var tabUnderLineView: UIView!
    @IBOutlet weak var headerViewTopLayout: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: UIImageView!
    
    private let originHeaderHeight: CGFloat = 200 - 44
    var tabUnderLayout: [NSLayoutConstraint] = []
    var mockData: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchMockData()
    }
    
    // TODO: 글자수 100자제한
    
    func fetchMockData() {
        mockData = ["abcdefgabcdefgabcdefgabcdefg",
                    "제목입니다이건제목입니다이건제목입니다이건제목입니다이건제목입니다이건제목입니다이건",
                    "제목입니다이건개행\n제목입니다이건",
                    "12"
        ]
        tableView.reloadData()
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
    }
    
    @IBAction func popularOrderClick(_ sender: UIButton) {
        underBarAnimation(view: sender)
    }
    
    @IBAction func myBoardClick(_ sender: UIButton) {
        underBarAnimation(view: sender)
    }
}

extension CommunityViewController: UITableViewDataSource ,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mockData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommunityTableViewCell.reuseIdentifier, for: indexPath) as? CommunityTableViewCell else {
            return UITableViewCell(style: .default, reuseIdentifier: "")
        }
        cell.titleLabel.text = mockData[indexPath.row]
        
        return cell
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let posY = scrollView.contentOffset.y > originHeaderHeight ?
            originHeaderHeight : scrollView.contentOffset.y
        headerViewTopLayout.constant = -posY
    }
    
}
