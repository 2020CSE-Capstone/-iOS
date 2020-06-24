//
//  UserInfo.swift
//  GgeumYeonGgeumJu
//
//  Created by 남수김 on 2020/06/24.
//  Copyright © 2020 남수김. All rights reserved.
//

import Foundation

class UserInfo {
    private init() {}
    static let shared = UserInfo()
    
    var token = "token" {
        willSet {
            print(newValue)
        }
    }
}
