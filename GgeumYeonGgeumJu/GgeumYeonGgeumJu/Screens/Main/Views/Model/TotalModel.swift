//
//  TotalDrink.swift
//  GgeumYeonGgeumJu
//
//  Created by 남수김 on 2020/06/22.
//  Copyright © 2020 남수김. All rights reserved.
//

import Foundation

struct TotalDrinkModel: Codable {
    let total_glass, total_price: Int
}

struct TotalSmokeModel: Codable {
    let total_piece, total_price: Int
}

struct MonthTotalModel: Codable {
    let date: String
    let total_amount: Int
}
