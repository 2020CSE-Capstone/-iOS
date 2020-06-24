//
//  UITextField+Extension.swift
//  GgeumYeonGgeumJu
//
//  Created by 남수김 on 2020/06/23.
//  Copyright © 2020 남수김. All rights reserved.
//

import UIKit

extension UITextField {
    func addLeftPadding(num: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: num, height: self.frame.height))
           self.leftView = paddingView
           self.leftViewMode = ViewMode.always
    }
}

