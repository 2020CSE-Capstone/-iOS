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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
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
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell(style: .default, reuseIdentifier: "")
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let posY = scrollView.contentOffset.y > originHeaderHeight ?
            originHeaderHeight : scrollView.contentOffset.y
        headerViewTopLayout.constant = -posY
    }
    
}
