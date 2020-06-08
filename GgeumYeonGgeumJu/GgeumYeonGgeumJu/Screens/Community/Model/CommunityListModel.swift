//
//  CommunityListModel.swift
//  GgeumYeonGgeumJu
//
//  Created by 남수김 on 2020/06/03.
//  Copyright © 2020 남수김. All rights reserved.
//

import Foundation

struct CommunityListModel: Codable {
    let boardIdx: Int
    let title, content, writeDate: String?
    let likeCount, userId: Int
    let nickName: String
    let commentCount: Int
    
    enum CodingKeys: String, CodingKey {
        case boardIdx = "board_no"
        case title, content
        case writeDate = "write_date"
        case likeCount = "like_count"
        case userId = "user_id"
        case nickName = "nickname"
        case commentCount = "comment_count"
    }
}
