//
//  CommunityWriteViewController.swift
//  GgeumYeonGgeumJu
//
//  Created by 남수김 on 2020/06/09.
//  Copyright © 2020 남수김. All rights reserved.
//

import UIKit

class CommunityWriteViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var titleTextView: UITextView!
    
    private let service: CommunityServiceProtocol
    = DependencyContainer.shared.getDependency(key: .communityService)
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
    var isModify = false
    var boardIdx = -1
    var titleText: String? = ""
    var contentText: String? = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTextView()
    }
    
    func setupTextView() {
        titleTextView.delegate = self
        contentTextView.delegate = self
        titleTextView.text = titleText
        contentTextView.text = contentText
        
        resizeTitleTextView()
        resizeContentTextView()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(resizeTitleTextView),
                                               name: UITextView.textDidChangeNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(resizeContentTextView),
                                               name: UITextView.textDidChangeNotification,
                                               object: nil)
    }
    
    @objc
    func resizeTitleTextView() {
        let estimateSize = CGSize(width: titleTextView.frame.width, height: .greatestFiniteMagnitude)
        let size = titleTextView.sizeThatFits(estimateSize)
        
        titleTextView.constraints.forEach {
            if $0.firstAttribute == .height {
                $0.constant = size.height
            }
        }
    }
    
    @objc
    func resizeContentTextView() {
        let estimateSize = CGSize(width: contentTextView.frame.width, height: .greatestFiniteMagnitude)
        let size = contentTextView.sizeThatFits(estimateSize)
        
        contentTextView.constraints.forEach {
            if $0.firstAttribute == .height {
                $0.constant = size.height
            }
        }
    }
    
    @IBAction func writeClick(_ sender: Any) {
        guard titleTextView.hasText && contentTextView.hasText && !isLoading else {
            return
        }
        let title = titleTextView.text!
        let content = contentTextView.text!
        
        if isModify {
            isLoading = true
            service.requestModifyCommunity(boardIdx: boardIdx,title: title, content: content) { [weak self] isSuccess in
                guard let self = self else {
                    return
                }
                DispatchQueue.main.async {
                    if isSuccess {
                        self.alertWithHandler(title: "수정완료", message: "수정되었습니다.") { _ in
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                }
                self.isLoading = false
            }
        } else {
            isLoading = true
            service.requestWriteCommunity(title: title, content: content) { [weak self] isSuccess in
                guard let self = self else {
                    return
                }
                DispatchQueue.main.async {
                    if isSuccess {
                        self.alertWithHandler(title: "작성완료", message: "작성되었습니다.") { _ in
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                }
                self.isLoading = false
            }
        }
    }
    
    @IBAction func backClick(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
