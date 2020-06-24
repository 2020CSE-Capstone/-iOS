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
         let request = AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil, interceptor: nil, requestModifier: nil)
         request
             .validate(statusCode: 200...500)
             .responseDecodable(of: SimpleResponse<Bool>.self) { response in
                 switch response.result {
                 case .success(let object):
                    completion(object.data)
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
                    completion(object.data)
                 case .failure(let err):
                     print(err)
                     completion(nil)
                 }
         }
    }
    
    func requestSignUp(model: SignUpModel, completion: @escaping (Bool?) -> Void) {
        var urlComponent = URLComponents(string: BaseAPI.shared.getBaseString())
        urlComponent?.path = RequestURL.signUp.getString
         
         guard let url = urlComponent?.url else {
             return
         }
        
        let body: Parameters = [
            "email": model.email!,
            "nickname": model.nickName!,
            "age": model.age!,
            "drink_average": model.drinkAmount!,
            "smoke_average": model.smokeAmount!,
            "password": model.pw!,
            "determination": model.determine!
        ]
    
         let request = AF.request(url, method: .post, parameters: body, encoding: JSONEncoding.default, headers: nil, interceptor: nil, requestModifier: nil)
         request
             .validate(statusCode: 200...500)
             .responseDecodable(of: SimpleResponse<Bool>.self) { response in
                 switch response.result {
                 case .success(let object):
                    completion(object.data)
                 case .failure(let err):
                     print(err)
                     completion(nil)
                 }
         }
    }
    
    func requestLogin(email: String, pw: String, completion: @escaping (Bool?) -> Void) {
        var urlComponent = URLComponents(string: BaseAPI.shared.getBaseString())
        urlComponent?.path = RequestURL.login.getString
         
         guard let url = urlComponent?.url else {
             return
         }
        
        let body: Parameters = [
            "email": email,
            "password": pw
        ]
    
         let request = AF.request(url, method: .post, parameters: body, encoding: JSONEncoding.default, headers: nil, interceptor: nil, requestModifier: nil)
         request
             .validate(statusCode: 200...500)
             .responseDecodable(of: SimpleResponse<String>.self) { response in
                 switch response.result {
                 case .success(let object):
                    guard let token = object.data else {
                        completion(false)
                        return
                    }
                    UserInfo.shared.token = token
                    
                    completion(true)
                 case .failure(let err):
                     print(err)
                     completion(nil)
                 }
         }
    }
    
}
