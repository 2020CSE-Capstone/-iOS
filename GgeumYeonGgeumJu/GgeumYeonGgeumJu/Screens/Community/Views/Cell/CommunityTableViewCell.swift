//
//  CommunityTableViewCell.swift
//  GgeumYeonGgeumJu
//
//  Created by 남수김 on 2020/05/16.
//  Copyright © 2020 남수김. All rights reserved.
//

import UIKit

class CommunityTableViewCell: UITableViewCell {
    static var reuseIdentifier = "CommunityCell"
    static var nibName = "CommunityTableViewCell"
    
    @IBOutlet weak var commentNumLabel: UILabel!
    @IBOutlet weak var likeNumLabel: UILabel!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var model: CommunityListModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bind(model: CommunityListModel) {
        self.model = model
        nickNameLabel.text = model.nickName
        titleLabel.text = model.title
        dateLabel.text = model.writeDate?.communityDate()
        likeNumLabel.text = String(model.likeCount)
        commentNumLabel.text = String(model.commentCount)
    }
    
}
