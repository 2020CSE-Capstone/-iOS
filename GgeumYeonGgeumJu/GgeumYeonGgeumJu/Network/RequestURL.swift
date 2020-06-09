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
    
    var getString: String {
        switch self {
        case .community(let sort):
            return "/api/community/\(sort)"
        case .comment(let boardIdx):
            return "/api/comment/\(boardIdx)"
        case .commentWrite:
            return "/api/comment"
        }
    }
}
