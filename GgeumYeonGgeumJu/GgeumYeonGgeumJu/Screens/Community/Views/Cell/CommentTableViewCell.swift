//
//  CommentTableViewCell.swift
//  GgeumYeonGgeumJu
//
//  Created by 남수김 on 2020/06/03.
//  Copyright © 2020 남수김. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    static let reuseIdentifier = "CommentCell"
    static let nibName = "CommentTableViewCell"
    @IBOutlet weak var leadingLayout: NSLayoutConstraint!
    
    @IBOutlet weak var commentImg: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nickNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func bind(model: CommentModel) {
        nickNameLabel.text = model.nickname
        dateLabel.text = model.commentDate.communityDate()
        contentLabel.text = model.content
        
        if model.seq != 1 {
            self.commentMargin()
            self.commentImg.isHidden = false
        }
    }
    
    func commentMargin() {
        leadingLayout.constant = 50
    }
}
