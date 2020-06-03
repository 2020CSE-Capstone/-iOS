//
//  UIViewController+Extension.swift
//  GgeumYeonGgeumJu
//
//  Created by 남수김 on 2020/05/25.
//  Copyright © 2020 남수김. All rights reserved.
//

import Foundation
import UIKit

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
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
