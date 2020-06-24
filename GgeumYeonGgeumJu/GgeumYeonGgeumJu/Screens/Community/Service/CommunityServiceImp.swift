//
//  CommunityServiceImp.swift
//  GgeumYeonGgeumJu
//
//  Created by 남수김 on 2020/06/03.
//  Copyright © 2020 남수김. All rights reserved.
//

import Foundation
import Alamofire

struct CommunityServiceImp: CommunityServiceProtocol {
    func requestCommunityList(type: CommunityListType, completion: @escaping ([CommunityListModel]?) -> Void) {
        var urlComponent = URLComponents(string: BaseAPI.shared.getBaseString())
        
        let userId = "1"
        let sortString: String
        switch type {
        case .recent:
            sortString = "recent"
        case .popular:
            sortString = "popular"
        case .myBoard:
            sortString = "mypage/\(userId)"
        }
        
        urlComponent?.path = RequestURL.community(sortString: sortString).getString
        
        guard let url = urlComponent?.url else {
            return
        }
        let header: HTTPHeaders = [
            "Authorization": UserInfo.shared.token
        ]
        let request = AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header, interceptor: nil, requestModifier: nil)
        request
            .validate(statusCode: 200...500)
            .responseDecodable(of: ArrayResponse<CommunityListModel>.self) { response in
                switch response.result {
                case .success(let object):
                    completion(object.data)
                case .failure(let err):
                    print(err)
                }
        }
    }
    
    func requestCommunityWithBoardIdx(boardIdx: Int, completion: @escaping (CommunityListModel?) -> Void) {
        var urlComponent = URLComponents(string: BaseAPI.shared.getBaseString())
        urlComponent?.path = RequestURL.community(sortString: String(boardIdx)).getString
        
        guard let url = urlComponent?.url else {
            return
        }
        
        let header: HTTPHeaders = [
            "Authorization": UserInfo.shared.token
        ]
        let request = AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header, interceptor: nil, requestModifier: nil)
        request
            .validate(statusCode: 200...500)
            .responseDecodable(of: SimpleResponse<CommunityListModel>.self) { response in
                switch response.result {
                case .success(let object):
                    completion(object.data)
                case .failure(let err):
                    print(err)
                }
        }
    }
    // MARK: 댓글리스트
    func requestComment(boardIdx: Int, completion: @escaping ([CommentModel]?) -> Void) {
        var urlComponent = URLComponents(string: BaseAPI.shared.getBaseString())
        
        urlComponent?.path = RequestURL.comment(boardIdx: boardIdx).getString
        
        guard let url = urlComponent?.url else {
            return
        }
        let header: HTTPHeaders = [
            "Authorization": UserInfo.shared.token
        ]
        let request = AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header, interceptor: nil, requestModifier: nil)
        request
            .validate(statusCode: 200...500)
            .responseDecodable(of: ArrayResponse<CommentModel>.self) { response in
                switch response.result {
                case .success(let object):
                    completion(object.data)
                case .failure(let err):
                    print(err)
                }
        }
    }
    // MARK: 댓글작성
    func requestWriteComment(boardIdx: Int, content: String, completion: @escaping (Bool) -> Void) {
        var urlComponent = URLComponents(string: BaseAPI.shared.getBaseString())
        urlComponent?.path = RequestURL.commentWrite.getString
        
        guard let url = urlComponent?.url else {
            return
        }
        let userId = 1
        let body: Parameters = [
            "content" : content,
            "user_id" : userId,
            "community_board_no" : boardIdx
        ]
        let header: HTTPHeaders = [
            "Authorization": UserInfo.shared.token
        ]
        let request = AF.request(url, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header, interceptor: nil, requestModifier: nil)
        request
            .validate(statusCode: 200...500)
            .responseDecodable(of: SimpleResponse<Bool>.self) { response in
                switch response.result {
                case .success:
                    completion(true)
                case .failure(let err):
                    print(err)
                    completion(false)
                }
        }
    }
    
    // MARK: 커뮤니티 글작성
    func requestWriteCommunity(title: String, content: String, completion: @escaping (Bool) -> Void) {
        var urlComponent = URLComponents(string: BaseAPI.shared.getBaseString())
        urlComponent?.path = RequestURL.communityWrite.getString
        
        guard let url = urlComponent?.url else {
            return
        }
        let userId = 1
        let body: Parameters = [
            "title" : title,
            "content" : content,
            "user_id" : userId
        ]
        let header: HTTPHeaders = [
            "Authorization": UserInfo.shared.token
        ]
        let request = AF.request(url, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header, interceptor: nil, requestModifier: nil)
        request
            .validate(statusCode: 200...500)
            .responseDecodable(of: SimpleResponse<Bool>.self) { response in
                switch response.result {
                case .success:
                    completion(true)
                case .failure(let err):
                    print(err)
                    completion(false)
                }
        }
    }
    
    // MARK: 커뮤니티 글수정
    func requestModifyCommunity(boardIdx: Int, title: String, content: String, completion: @escaping (Bool) -> Void) {
        var urlComponent = URLComponents(string: BaseAPI.shared.getBaseString())
        urlComponent?.path = RequestURL.communityModify(boardIdx: boardIdx).getString
        
        guard let url = urlComponent?.url else {
            return
        }
        
        let body: Parameters = [
            "title" : title,
            "content" : content
        ]
        let header: HTTPHeaders = [
            "Authorization": UserInfo.shared.token
        ]
        
        let request = AF.request(url, method: .put, parameters: body, encoding: JSONEncoding.default, headers: header, interceptor: nil, requestModifier: nil)
        request
            .validate(statusCode: 200...500)
            .responseDecodable(of: SimpleResponse<Bool>.self) { response in
                switch response.result {
                case .success:
                    completion(true)
                case .failure(let err):
                    print(err)
                    completion(false)
                }
        }
    }
    
    // MARK: 커뮤니티 글삭제
    func requestDeleteCommunity(boardIdx: Int, completion: @escaping (Bool) -> Void) {
        var urlComponent = URLComponents(string: BaseAPI.shared.getBaseString())
        urlComponent?.path = RequestURL.communityDelete(boardIdx: boardIdx).getString
        
        guard let url = urlComponent?.url else {
            return
        }
        let header: HTTPHeaders = [
            "Authorization": UserInfo.shared.token
        ]
        let request = AF.request(url, method: .delete, parameters: nil, encoding: JSONEncoding.default, headers: header, interceptor: nil, requestModifier: nil)
        request
            .validate(statusCode: 200...500)
            .responseDecodable(of: SimpleResponse<Bool>.self) { response in
                switch response.result {
                case .success:
                    completion(true)
                case .failure(let err):
                    print(err)
                    completion(false)
                }
        }
    }
}
