//
//  LoginServiceProtocol.swift
//  GgeumYeonGgeumJu
//
//  Created by 남수김 on 2020/06/24.
//  Copyright © 2020 남수김. All rights reserved.
//

import Foundation
protocol LoginServiceProtocol {
    func requestCheckEmail(email: String, completion: @escaping (Bool?) -> Void)
    func requestCheckName(name: String, completion: @escaping (Bool?) -> Void)
}
