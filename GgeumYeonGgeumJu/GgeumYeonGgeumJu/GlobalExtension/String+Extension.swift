//
//  String+Extension.swift
//  GgeumYeonGgeumJu
//
//  Created by 남수김 on 2020/05/14.
//  Copyright © 2020 남수김. All rights reserved.
//

import Foundation

extension String {
    func communityDate() -> String {
        var format = "yyyy-MM-dd HH:mm:ss"
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "ko")
        
        guard let writeDate = formatter.date(from: self) else {
            return ""
        }
      
        let compareCalendar = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: writeDate)
        let curCalendar = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: Date())
        
        if compareCalendar.year == curCalendar.year {
            if compareCalendar.month == curCalendar.month {
                if compareCalendar.day == curCalendar.day {
                    if compareCalendar.hour == curCalendar.hour {
                        if compareCalendar.minute == curCalendar.minute {
                            if let writeS = compareCalendar.second {
                                let second = curCalendar.second! - writeS
                                if second < 10 {
                                    return "몇 초전"
                                } else {
                                    return "\(second)초 전"
                                }
                            }
                        } else {
                            if let writeM = compareCalendar.minute,
                                let curM = curCalendar.minute {
                                let min = curM - writeM
                                return "\(min)분 전"
                            } else {
                                return "몇 분전"
                            }
                        }
                    } else {
                        if let writeH = compareCalendar.hour,
                            let curH = curCalendar.hour {
                            let hour = curH - writeH
                            return "\(hour)시간 전"
                        } else {
                            return "몇시간 전"
                        }
                    }
                }
                
            }
        }
        format = "yyyy.MM.dd"
        formatter.dateFormat = format
        
        return formatter.string(from: writeDate)
    }
    
    func recordDate() -> String {
        var format = "yyyy-MM-dd HH:mm:ss"
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale(identifier: "ko")
        guard let tempDate = formatter.date(from: self) else {
            return ""
        }
        format = "yyyy.MM.dd"
        formatter.dateFormat = format
        return formatter.string(from: tempDate)
    }
}
