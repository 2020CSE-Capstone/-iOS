//
//  Date+Extension.swift
//  GgeumYeonGgeumJu
//
//  Created by 남수김 on 2020/05/14.
//  Copyright © 2020 남수김. All rights reserved.
//

import Foundation

extension Date {
    func datePickerToString() -> String {
        let formatter = DateFormatter()
        let format = "yyyy.MM.dd"
        formatter.dateFormat = format
        let dateString = formatter.string(from: self)
        return dateString
    }
}
