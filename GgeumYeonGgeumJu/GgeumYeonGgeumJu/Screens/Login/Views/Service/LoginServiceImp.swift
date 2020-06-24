//
//  LoginServiceImp.swift
//  GgeumYeonGgeumJu
//
//  Created by 남수김 on 2020/06/24.
//  Copyright © 2020 남수김. All rights reserved.
//
import Foundation
import Alamofire

struct LoginServiceImp: LoginServiceProtocol {
    func requestCheckEmail(email: String, completion: @escaping (Bool?) -> Void) {
        var urlComponent = URLComponents(string: BaseAPI.shared.getBaseString())
        urlComponent?.path = RequestURL.checkEmail(email: email).getString
         
         guard let url = urlComponent?.url else {
             return
         }
        print(url)
         let request = AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil, interceptor: nil, requestModifier: nil)
         request
             .validate(statusCode: 200...500)
             .responseDecodable(of: SimpleResponse<Bool>.self) { response in
                 switch response.result {
                 case .success(let object):
                    completion(object.data!)
                 case .failure(let err):
                     print(err)
                     completion(nil)
                 }
         }
    }
    
    func requestCheckName(name: String, completion: @escaping (Bool?) -> Void) {
        var urlComponent = URLComponents(string: BaseAPI.shared.getBaseString())
        urlComponent?.path = RequestURL.checkName(name: name).getString
         
         guard let url = urlComponent?.url else {
             return
         }
        
         let request = AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil, interceptor: nil, requestModifier: nil)
         request
             .validate(statusCode: 200...500)
             .responseDecodable(of: SimpleResponse<Bool>.self) { response in
                 switch response.result {
                 case .success(let object):
                    completion(object.data!)
                 case .failure(let err):
                     print(err)
                     completion(nil)
                 }
         }
    }
}
