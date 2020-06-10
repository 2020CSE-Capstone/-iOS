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
//    let underLine = UIView()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
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
        
//        underLine.snp.makeConstraints {
//            $0.leading.trailing.equalToSuperview().offset(20)
//            $0.bottom.equalTo(self.snp.bottom)
//            $0.height.equalTo(0.3)
//        }
    }
    
    func setupUI() {
//        dateLabel.font = .systemFont(ofSize: 15)
//        dateLabel.textColor = .lightGray
        
        overAmountLabel.font = .systemFont(ofSize: 12)
        overAmountLabel.textColor = #colorLiteral(red: 0.7834629416, green: 0.237608701, blue: 0.3743506074, alpha: 1)
        
//        underLine.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    }
    
    // TODO: 모델바인딩
    func bind(model: RecordModel) {
//        dateLabel.text = model.date
        self.addSubview(amountLabel)
        self.addSubview(percentLabel)
        self.addSubview(kindImageView)
        self.addSubview(overAmountLabel)
//        self.addSubview(underLine)
        
        setupLayout()
        setupUI()
        
        amountLabel.text = "\(model.glass)잔"
        if model.figure == 0 {
            percentLabel.text = "-"
        } else {
            percentLabel.text = "\(model.figure)%"
        }
        
        overAmountLabel.text =  "1잔"
        kindImageView.image = model.kind == .drink ?
            UIImage(named: "soju") :
            UIImage(named: "smoke")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
