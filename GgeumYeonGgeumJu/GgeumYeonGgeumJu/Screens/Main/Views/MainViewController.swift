//
//  ViewController.swift
//  GgeumYeonGgeumJu
//
//  Created by 남수김 on 2020/05/13.
//  Copyright © 2020 남수김. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var smokeChartButton: UIButton!
    @IBOutlet weak var smokeRecordButton: UIButton!
    @IBOutlet weak var drinkNumberView: UIView!
    @IBOutlet weak var drinkMoneyView: UIView!
    @IBOutlet weak var smokeNumberView: UIView!
    @IBOutlet weak var smokeMoneyView: UIView!
    @IBOutlet weak var mainTitleLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var backImgHeightLayout: NSLayoutConstraint!
    let backImgMinOriginHeight: CGFloat = 250
    var statusStyle: UIStatusBarStyle = .lightContent

    // MARK: 타이틀텍스트
    // 죽고싶어? 응 죽고싶어
    // 담배한모금 술한모금 세금모금
    // 오늘도 힘내세요
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyCardView(views: [smokeMoneyView, smokeNumberView, drinkMoneyView, drinkNumberView, smokeChartButton, smokeRecordButton])
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
                      radius: 8,
                      scale: true)
        }
    }
    
    // TODO: 술, 담배 타입구분
    @IBAction func recordClick(_ sender: Any) {
        guard let nextVC = storyboard?.instantiateViewController(withIdentifier: ViewControllerIdentifier.recordVC.rawValue) as? RecordViewController else {
            return
        }
        
        navigationController?.pushViewController(nextVC, animated: true)
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
