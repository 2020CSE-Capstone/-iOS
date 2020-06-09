//
//  CommentModel.swift
//  GgeumYeonGgeumJu
//
//  Created by 남수김 on 2020/06/09.
//  Copyright © 2020 남수김. All rights reserved.
//

import Foundation

struct CommentModel: Codable {
    let commentIdx: Int
    let content: String
    let parentCommentIdx, seq: Int
    let commentDate: String
    let userId, communityBoardIdx: Int
    let nickname: String
    
    enum CodingKeys: String, CodingKey {
        case commentIdx = "comment_no"
        case content
        case parentCommentIdx = "parent_comment_no"
        case seq
        case commentDate = "comment_date"
        case userId = "user_id"
        case communityBoardIdx = "community_board_no"
        case nickname
    }
    
}
