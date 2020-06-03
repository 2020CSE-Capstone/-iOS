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
    func requestCommunityList(sortString: String, completion: @escaping (CommunityListModel) -> Void) {
        var urlComponent = URLComponents(string: BaseAPI.shared.getBaseString())
        urlComponent?.path = RequestURL.community(sortString: sortString).getString
        
        guard let url = urlComponent?.url else {
            return
        }
        
        let request = AF.request(url)
        request
            .validate(statusCode: 200...500)
            .responseDecodable(of: SimpleResponse<CommunityListModel>.self) { response in
                switch response.result {
                case .success:
                    print(response.value)
                    print(response.value?.message)
                case .failure(let err):
                    print(err)
                }
        }
    }
    
    func requestMyCommunityList(completion: @escaping ()->()) {
        var urlComponent = URLComponents(string: BaseAPI.shared.getBaseString())
        let userId = "test"
        urlComponent?.path = RequestURL.myCommunity(userId: userId).getString
        
    }
}
