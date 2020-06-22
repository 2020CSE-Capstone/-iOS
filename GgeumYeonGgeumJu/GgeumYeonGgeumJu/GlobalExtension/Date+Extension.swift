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
    
    func getMonth() -> Int {
        let calendar = Calendar.current.dateComponents([.month], from: self)
        guard let month = calendar.month else {
            return 1
        }
        return month
    }
}
