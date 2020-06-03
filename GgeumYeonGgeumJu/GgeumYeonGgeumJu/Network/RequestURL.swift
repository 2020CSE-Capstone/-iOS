//
//  RequestURL.swift
//  GgeumYeonGgeumJu
//
//  Created by 남수김 on 2020/06/03.
//  Copyright © 2020 남수김. All rights reserved.
//

import Foundation
enum RequestURL {
    case community(sortString: String)
    case myCommunity(userId: String)
    
    var getString: String {
        switch self {
        case .community(let sort):
            return "/community/\(sort)"
        case .myCommunity(let userId):
            return "/community/mypage/\(userId)"
        default:
            return ""
        }
    }
}
