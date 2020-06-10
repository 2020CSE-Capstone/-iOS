//
//  RecordServiceProtocol.swift
//  GgeumYeonGgeumJu
//
//  Created by 남수김 on 2020/06/10.
//  Copyright © 2020 남수김. All rights reserved.
//

import Foundation

protocol RecordServiceProtocol {
    func requestRecordList(completion: @escaping ([RecordModel]?) -> Void)
}
