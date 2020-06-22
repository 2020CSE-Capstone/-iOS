//
//  RecordService.swift
//  GgeumYeonGgeumJu
//
//  Created by 남수김 on 2020/06/10.
//  Copyright © 2020 남수김. All rights reserved.
//

import Foundation
import Alamofire

struct RecordServiceImp: RecordServiceProtocol {
    // MARK: 측정 기록리스트
    func requestRecordList(completion: @escaping ([RecordModel]?) -> Void) {
        var urlComponent = URLComponents(string: BaseAPI.shared.getBaseString())
        let userId = 1
        urlComponent?.path = RequestURL.record(userId: userId).getString
        
        guard let url = urlComponent?.url else {
            return
        }
       
        let request = AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil, interceptor: nil, requestModifier: nil)
        request
            .validate(statusCode: 200...500)
            .responseDecodable(of: SimpleResponse<[RecordModel]>.self) { response in
                switch response.result {
                case .success(let object):
                    completion(object.data)
                case .failure(let err):
                    print(err)
                    completion(nil)
                }
        }
    }
    
    // MARK: 측정 저장
    func requestRecordSave(record: RecordModel, completion: @escaping (Bool) -> Void) {
        var urlComponent = URLComponents(string: BaseAPI.shared.getBaseString())
        let userId = 1
        urlComponent?.path = RequestURL.recordSave.getString
        
        guard let url = urlComponent?.url else {
            return
        }
        let body: Parameters = [
            "figure" : record.figure,
            "glass" : record.glass,
            "drink_date" : record.drinkDate,
            "drink_name" : record.drinkName,
            "user_id" : userId
        ]
        print(body)
        print(url)
        let request = AF.request(url, method: .post, parameters: body, encoding: JSONEncoding.default, headers: nil, interceptor: nil, requestModifier: nil)
        request
            .validate(statusCode: 200...500)
            .responseDecodable(of: SimpleResponse<Bool>.self) { response in
                switch response.result {
                case .success(let object):
                    print(object)
                    completion(true)
                case .failure(let err):
                    print(err)
                    completion(false)
                }
        }
    }
}
