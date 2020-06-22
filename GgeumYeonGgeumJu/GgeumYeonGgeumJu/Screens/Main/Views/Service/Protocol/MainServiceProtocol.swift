//
//  MainServiceProtocol.swift
//  GgeumYeonGgeumJu
//
//  Created by 남수김 on 2020/06/22.
//  Copyright © 2020 남수김. All rights reserved.
//

import Foundation
import Alamofire

protocol MainServiceProtocol {
    func requestTotalDrink(completion: @escaping (AFResult<TotalDrinkModel>) -> Void)
    func requestTotalSmoke(completion: @escaping (AFResult<TotalSmokeModel>) -> Void)
}
