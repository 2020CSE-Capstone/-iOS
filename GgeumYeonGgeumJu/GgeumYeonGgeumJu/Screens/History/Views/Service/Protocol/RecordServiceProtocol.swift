//
//  RecordServiceProtocol.swift
//  GgeumYeonGgeumJu
//
//  Created by 남수김 on 2020/06/10.
//  Copyright © 2020 남수김. All rights reserved.
//

import Foundation

protocol RecordServiceProtocol {
    func requestRecordDrinkList(completion: @escaping ([RecordDrinkModel]?) -> Void)
    func requestRecordSmokeList(completion: @escaping ([RecordSmokeModel]?) -> Void)
    func requestRecordSave(record: RecordDrinkModel, completion: @escaping (Bool) -> Void)
}
