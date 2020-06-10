//
//  RecordModel.swift
//  GgeumYeonGgeumJu
//
//  Created by 남수김 on 2020/06/10.
//  Copyright © 2020 남수김. All rights reserved.
//

import Foundation
struct RecordModel: Codable {
    let id: Int
    let figure: Double
    let glass: Int
    let drinkDate: String
    let drinkName: String
    var kind: RecordType = .drink
    
    enum CodingKeys: String, CodingKey {
        case id, figure, glass
        case drinkDate = "drink_date"
        case drinkName = "drink_name"
    }
    
    func getDate() -> String {
        return drinkDate.recordDate()
    }
}

struct RecordSectionListModel {
    let sectionText: String
    var item: [RecordModel] = []
    
    mutating func addItem(item: RecordModel) {
        self.item.append(item)
    }
}
