//
//  HistoryTableViewCell.swift
//  GgeumYeonGgeumJu
//
//  Created by 남수김 on 2020/06/01.
//  Copyright © 2020 남수김. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    static let reuseIdentifier = "HistoryCell"
    
    let dateLabel = UILabel()
    let amountLabel = UILabel()
    let percentLabel = UILabel()
    let overAmountLabel = UILabel()
    let kindImageView = UIImageView()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(dateLabel)
        self.addSubview(amountLabel)
        self.addSubview(percentLabel)
        self.addSubview(kindImageView)
        self.addSubview(overAmountLabel)
        
        setupLayout()
        setupUI()
    }
    
    func setupLayout() {
        dateLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.centerY.equalToSuperview()
        }
        
        kindImageView.snp.makeConstraints {
            $0.leading.equalTo(dateLabel.snp.trailing).offset(22)
            $0.centerY.equalTo(dateLabel.snp.centerY)
            $0.width.height.equalTo(40)
        }
        
        percentLabel.snp.makeConstraints {
            $0.leading.equalTo(kindImageView.snp.trailing).offset(12)
            $0.centerY.equalTo(kindImageView)
        }
        
        amountLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-40)
            $0.centerY.equalTo(kindImageView)
        }
        
        overAmountLabel.snp.makeConstraints {
            $0.trailing.equalTo(amountLabel.snp.trailing)
            $0.top.equalTo(amountLabel.snp.bottom).offset(2)
        }
    }
    
    func setupUI() {
        dateLabel.font = .systemFont(ofSize: 15)
        dateLabel.textColor = .lightGray
        
        overAmountLabel.font = .systemFont(ofSize: 12)
        overAmountLabel.textColor = #colorLiteral(red: 0.7834629416, green: 0.237608701, blue: 0.3743506074, alpha: 1)
    }
    
    // TODO: 모델바인딩
    func bind() {
        dateLabel.text = "06.01"
        amountLabel.text = "3잔"
        percentLabel.text = "10%"
        overAmountLabel.text = "1잔"
        kindImageView.image = UIImage(named: "soju")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
