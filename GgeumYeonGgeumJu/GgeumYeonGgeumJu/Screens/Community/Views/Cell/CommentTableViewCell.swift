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
    
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func commentMargin() {
        leadingLayout.constant = 50
    }
}
