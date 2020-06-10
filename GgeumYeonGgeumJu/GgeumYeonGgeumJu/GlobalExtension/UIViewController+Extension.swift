//
//  UIViewController+Extension.swift
//  GgeumYeonGgeumJu
//
//  Created by 남수김 on 2020/05/25.
//  Copyright © 2020 남수김. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

extension UIViewController {
    func simpleActionSheet(title: String?, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
        actions.forEach{ alert.addAction($0) }
        present(alert, animated: true)
    }
    
    //확인 팝업
    func simpleAlert(title: String?, message: String?) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인",style: .default)
        alert.addAction(okAction)
        alert.modalPresentationStyle = .fullScreen
        present(alert, animated: true)
    }
    
    //확인 Handler팝업
    func alertWithHandler(title: String?,
                                message: String?,
                                okHandler : ((UIAlertAction) -> Void)?){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: okHandler)
        alert.addAction(okAction)
        alert.modalPresentationStyle = .fullScreen
        present(alert, animated: false, completion: nil)
    }
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func keyboardHeight() -> Observable<(CGFloat, Double)> {
        return Observable
            .from([
                NotificationCenter
                    .default
                    .rx
                    .notification(UIResponder.keyboardWillShowNotification)
                    .map { notification -> (CGFloat, Double) in
                        ((notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height ?? 0,
                         (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double) ?? 0)
                },
                NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification)
                    .map { notification -> (CGFloat, Double) in
                        let hideHeight: CGFloat = 0
                        let duration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double) ?? 0
                        return (hideHeight, duration)
                }
            ])
            .merge()
    }
}
