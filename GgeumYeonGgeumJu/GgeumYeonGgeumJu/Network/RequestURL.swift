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
    case comment(boardIdx: Int)
    case commentWrite
    case communityWrite
    case communityModify(boardIdx: Int)
    case communityDelete(boardIdx: Int)
    case record(userId: Int)
    case recordSave
    case totalDrink(userId: Int)
    case totalSmoke(userId: Int)
    case monthDrinkTotal
    case monthSmokeTotal
    case checkEmail(email: String)
    case checkName(name: String)
    case signUp
    case login
    
    
    var getString: String {
        switch self {
        case .community(let sort):
            return "/api/community/\(sort)"
        case .comment(let boardIdx):
            return "/api/comment/\(boardIdx)"
        case .commentWrite:
            return "/api/comment"
        case .communityWrite:
            return "/api/community"
        case .communityModify(let boardIdx),
             .communityDelete(let boardIdx):
            return "/api/community/\(boardIdx)"
        case .record(let userId):
            return "/api/record/\(userId)"
        case .recordSave:
            return "/api/record"
        case .totalDrink(let userId):
            return "/api/record/drink/total/\(userId)"
        case .totalSmoke(let userId):
            return "/api/record/smoke/total/\(userId)"
        case .monthDrinkTotal:
            return "/api/record/drink/month"
        case .monthSmokeTotal:
            return "/api/record/smoke/month"
        case .checkEmail(let email):
            return "/api/user/email/\(email)"
        case .checkName(let nickname):
            return "/api/user/nickname/\(nickname)"
        case .signUp:
            return "/api/user/signup"
        case .login:
            return "/api/user/login"
        }
    }
}
