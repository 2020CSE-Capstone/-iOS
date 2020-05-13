//
//  ViewController.swift
//  GgeumYeonGgeumJu
//
//  Created by 남수김 on 2020/05/13.
//  Copyright © 2020 남수김. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    
    @IBOutlet weak var smokeNumberView: UIView!
    @IBOutlet weak var smokeMoneyView: UIView!
    @IBOutlet weak var mainTitleLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var backImgHeightLayout: NSLayoutConstraint!
    let backImgMinOriginHeight: CGFloat = 250
    var statusStyle: UIStatusBarStyle = .lightContent
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyCardView(views: [smokeMoneyView,smokeNumberView])
        scrollView.delegate = self
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusStyle
    }

    func applyCardView(views: [UIView]) {
        let offset = CGSize(width: 1, height: 6)
        views.forEach {
        $0.dropShadow(color: .lightGray,
                      opacity: 0.4,
                      offSet: offset,
                      radius: 10,
                      scale: true)
        }
    }
}

extension MainViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y

        var height = backImgMinOriginHeight - offsetY
        height = height < backImgMinOriginHeight ? backImgMinOriginHeight : height
        backImgHeightLayout.constant = height
        
        if offsetY > backImgMinOriginHeight - 44 {
            statusStyle = .darkContent
            setNeedsStatusBarAppearanceUpdate()
        } else {
            statusStyle = .lightContent
            setNeedsStatusBarAppearanceUpdate()
        }
        mainTitleLabel.alpha = 1.0 - offsetY/backImgMinOriginHeight
    }
}
