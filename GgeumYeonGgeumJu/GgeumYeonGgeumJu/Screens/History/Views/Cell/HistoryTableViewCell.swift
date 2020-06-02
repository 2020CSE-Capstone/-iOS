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
    
//    let dateLabel = UILabel()
    let amountLabel = UILabel()
    let percentLabel = UILabel()
    let overAmountLabel = UILabel()
    let kindImageView = UIImageView()
    let underLine = UIView()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
//        self.addSubview(dateLabel)
        self.addSubview(amountLabel)
        self.addSubview(percentLabel)
        self.addSubview(kindImageView)
        self.addSubview(overAmountLabel)
        self.addSubview(underLine)
        
        setupLayout()
        setupUI()
    }
    
    func setupLayout() {
//        dateLabel.snp.makeConstraints {
//            $0.leading.equalToSuperview().offset(20)
//            $0.centerY.equalToSuperview()
//        }
        
        kindImageView.snp.makeConstraints {
//            $0.leading.equalTo(dateLabel.snp.trailing).offset(22)
//            $0.centerY.equalTo(dateLabel.snp.centerY)
            $0.leading.equalToSuperview().offset(20)
            $0.centerY.equalToSuperview()
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
        
        underLine.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
    
    func setupUI() {
//        dateLabel.font = .systemFont(ofSize: 15)
//        dateLabel.textColor = .lightGray
        
        overAmountLabel.font = .systemFont(ofSize: 12)
        overAmountLabel.textColor = #colorLiteral(red: 0.7834629416, green: 0.237608701, blue: 0.3743506074, alpha: 1)
        
        underLine.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    }
    
    // TODO: 모델바인딩
    func bind(model: HistoryListModel) {
//        dateLabel.text = model.date
        amountLabel.text = model.amount
        percentLabel.text = model.percent
        overAmountLabel.text =  model.overAmount
        kindImageView.image = model.kind == .drink ?
            UIImage(named: "soju") :
            UIImage(named: "smoke")
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
