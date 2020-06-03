//
//  CommunityServiceProtocol.swift
//  GgeumYeonGgeumJu
//
//  Created by 남수김 on 2020/06/03.
//  Copyright © 2020 남수김. All rights reserved.
//

import Foundation
protocol CommunityServiceProtocol {
    func requestCommunityList(sortString: String, completion: @escaping (CommunityListModel) -> Void)
    
}
