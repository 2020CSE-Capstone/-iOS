//
//  CommunityServiceProtocol.swift
//  GgeumYeonGgeumJu
//
//  Created by 남수김 on 2020/06/03.
//  Copyright © 2020 남수김. All rights reserved.
//

import Foundation
protocol CommunityServiceProtocol {
    func requestCommunityList(type: CommunityListType, completion: @escaping ([CommunityListModel]?) -> Void)
    func requestCommunityWithBoardIdx(boardIdx: Int, completion: @escaping (CommunityListModel?) -> Void)
    func requestComment(boardIdx: Int, completion: @escaping ([CommentModel]?) -> Void)
    func requestWriteComment(boardIdx: Int, content: String, completion: @escaping (Bool) -> Void)
    func requestWriteCommunity(title: String, content: String, completion: @escaping (Bool) -> Void)
    func requestModifyCommunity(boardIdx: Int, title: String, content: String, completion: @escaping (Bool) -> Void)
    func requestDeleteCommunity(boardIdx: Int, completion: @escaping (Bool) -> Void)
}
