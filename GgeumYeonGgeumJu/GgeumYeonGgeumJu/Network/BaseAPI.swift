//
//  baseURL.swift
//  GgeumYeonGgeumJu
//
//  Created by 남수김 on 2020/06/03.
//  Copyright © 2020 남수김. All rights reserved.
//

import Foundation

struct BaseAPI {
    
    private init() { }
    static let shared = BaseAPI()
    private let baseURLString = "http://13.125.162.225/api"
    
    func getBaseString() -> String {
        return baseURLString
    }
}

