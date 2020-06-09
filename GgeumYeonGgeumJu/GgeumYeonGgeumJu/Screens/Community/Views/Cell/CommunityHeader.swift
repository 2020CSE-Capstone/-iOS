//
//  CommunityHeader.swift
//  GgeumYeonGgeumJu
//
//  Created by 남수김 on 2020/06/09.
//  Copyright © 2020 남수김. All rights reserved.
//

import UIKit

class CommunityHeader: UITableViewHeaderFooterView {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    func bind(model: CommunityListModel) {
        dateLabel.text = model.writeDate?.communityDate()
        titleLabel.text = model.title
        nickNameLabel.text = model.nickName
        contentLabel.text = model.content
    }
}
