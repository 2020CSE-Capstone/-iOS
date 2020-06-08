//
//  SimpleResponse.swift
//  GgeumYeonGgeumJu
//
//  Created by 남수김 on 2020/06/03.
//  Copyright © 2020 남수김. All rights reserved.
//

import Foundation

struct SimpleResponse<T: Codable>: Codable {
    let status: String?
    let message: String?
    let data: T?
    
    enum CodingKeys: CodingKey {
        case status, message, data
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = (try? values.decode(String.self, forKey: .status)) ?? nil
        message = (try? values.decode(String.self, forKey: .message)) ?? nil
        data = (try? values.decode(T.self, forKey: .data)) ?? nil
    }
}

struct ArrayResponse<T: Codable>: Codable {
    let status: String?
    let message: String?
    let data: [T]?
    
    enum CodingKeys: CodingKey {
        case status, message, data
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = (try? values.decode(String.self, forKey: .status)) ?? nil
        message = (try? values.decode(String.self, forKey: .message)) ?? nil
        data = (try? values.decode([T].self, forKey: .data)) ?? nil
    }
}
