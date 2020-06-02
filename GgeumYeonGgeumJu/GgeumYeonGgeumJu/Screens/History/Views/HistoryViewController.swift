//
//  HistoryViewController.swift
//  GgeumYeonGgeumJu
//
//  Created by 남수김 on 2020/06/01.
//  Copyright © 2020 남수김. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var testData: [HistorySectionListModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMockData()
        setupTableView()
    }
    
    func setupTableView() {
        tableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: HistoryTableViewCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self

    }
    
    func fetchMockData() {
        let mock: [HistoryListModel] = [
            HistoryListModel(date: "06.01", percent: "10%", amount: "1잔", overAmount: "1잔"),
            HistoryListModel(date: "06.02", percent: "15%", amount: "2잔", overAmount: "2잔"),
            HistoryListModel(date: "06.02", percent: "20%", amount: "3잔", overAmount: "3잔"),
            HistoryListModel(date: "06.03", percent: "30%", amount: "4잔", overAmount: "4잔"),
            HistoryListModel(date: "06.03", percent: "40%", amount: "5잔", overAmount: "5잔"),
        ]
        listSortByDate(list: mock)
    }
    
    func listSortByDate(list: [HistoryListModel]) {
        if list.isEmpty {
            return
        }
        
        var tempList: [HistorySectionListModel] = []
        
        let sortList = list.sorted { $0.date < $1.date }
        
        var temp = HistorySectionListModel(sectionText: sortList[0].date)
        temp.addItem(item: sortList[0])
        for index in 1..<sortList.count {
            let title = sortList[index].date
            if temp.sectionText == title {
                temp.addItem(item: sortList[index])
            } else {
                tempList.append(temp)
                temp = HistorySectionListModel(sectionText: title)
                temp.addItem(item: sortList[index])
            }
        }
        tempList.append(temp)
        
        testData = tempList
        tableView.reloadData()
    }
    
}

extension HistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testData[section].item.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTableViewCell.reuseIdentifier, for: indexPath) as? HistoryTableViewCell else {
            return .init(style: .default, reuseIdentifier: "")
        }
        cell.bind(model: testData[indexPath.section].item[indexPath.row])
        return cell
    }
}

extension HistoryViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return testData.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView: UIView = {
            let view = UIView(frame: tableView.bounds)
            view.backgroundColor = .white
            return view
        }()
        
        let underView: UIView = {
            let view = UIView()
            view.backgroundColor = .lightGray
            return view
        }()
        
        let dateLabel: UILabel = {
            let label = UILabel()
            label.text = testData[section].sectionText
            label.font = .systemFont(ofSize: 14)
            return label
        }()
        
        headerView.addSubview(dateLabel)
        headerView.addSubview(underView)
        
        dateLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.centerY.equalToSuperview()
        }
        
        underView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
}
