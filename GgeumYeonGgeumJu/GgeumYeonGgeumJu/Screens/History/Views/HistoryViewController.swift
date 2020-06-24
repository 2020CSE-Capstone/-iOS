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
    @IBOutlet weak var tabUnderView: UIView!
    
    var recordList: [RecordSectionListModel] = [] {
        willSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    private let service: RecordServiceProtocol
        = DependencyContainer.shared.getDependency(key: .recordService)
    private var type: RecordType = .smoke
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestRecordList()
        setupTableView()
    }
    
    func setupTableView() {
        tableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: HistoryTableViewCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)

    }
    
    func requestRecordList() {
        service.requestRecordSmokeList { [weak self] list in
            guard let list = list,
                let self = self else {
                return
            }
            self.listSortByDate(list: list)
        }
    }
    
    
    func listSortByDate(list: [RecordModel]) {
        if list.isEmpty {
            return
        }
        
        var tempList: [RecordSectionListModel] = []
        
        let sortList = list.sorted { $0.getDate() < $1.getDate() }
        
        var temp = RecordSectionListModel(sectionText: sortList[0].getDate())
        temp.addItem(item: sortList[0])
        for index in 1..<sortList.count {
            let title = sortList[index].getDate()
            if temp.sectionText == title {
                temp.addItem(item: sortList[index])
            } else {
                tempList.append(temp)
                temp = RecordSectionListModel(sectionText: title)
                temp.addItem(item: sortList[index])
            }
        }
        tempList.append(temp)
        
        recordList = tempList
    }
    
    func moveUnderView(view: UIButton, color: UIColor) {
        DispatchQueue.main.async {
            self.tabUnderView.snp.removeConstraints()
            self.tabUnderView.snp.makeConstraints {
                $0.leading.equalTo(view.snp.leading)
                $0.trailing.equalTo(view.snp.trailing)
            }
            
            UIView.animate(withDuration: 0.4) {
                self.view.layoutIfNeeded()
                self.tabUnderView.backgroundColor = color
            }
        }
        
    }
    
    @IBAction func tabTypeClick(_ sender: UIButton) {
        let buttonType: RecordType = sender.tag == 1 ? .smoke : .drink
        self.recordList.removeAll()
        switch buttonType {
        case .smoke:
            type = .smoke
            moveUnderView(view: sender, color: .softPink)
            service.requestRecordSmokeList { [weak self] list in
                guard let list = list,
                    let self = self else {
                        return
                }
                self.listSortByDate(list: list)
            }
        case .drink:
            type = .drink
            moveUnderView(view: sender, color: .softSky)
            service.requestRecordDrinkList { [weak self] list in
                guard let list = list,
                    let self = self else {
                        return
                }
                self.listSortByDate(list: list)
            }
        }
    }
}

extension HistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recordList[section].item.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTableViewCell.reuseIdentifier, for: indexPath) as? HistoryTableViewCell else {
            return .init(style: .default, reuseIdentifier: "")
        }
        cell.bind(type: type, model: recordList[indexPath.section].item[indexPath.row])
        return cell
    }
}

extension HistoryViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return recordList.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView: UIView = {
            let view = UIView(frame: tableView.bounds)
            view.backgroundColor = .white
            return view
        }()
        
        let underView: UIView = {
            let view = UIView()
            view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            return view
        }()
        
        let topView: UIView = {
            let view = UIView()
            view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            return view
        }()
        
        let dateLabel: UILabel = {
            let label = UILabel()
            label.text = recordList[section].sectionText
            label.font = .systemFont(ofSize: 14)
            return label
        }()
        
        headerView.addSubview(dateLabel)
        headerView.addSubview(underView)
        headerView.addSubview(topView)
        
        dateLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.centerY.equalToSuperview()
        }
        
        underView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(0.3)
        }
        
        topView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.height.equalTo(0.3)
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
}
