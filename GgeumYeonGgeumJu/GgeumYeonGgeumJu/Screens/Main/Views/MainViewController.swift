//
//  ViewController.swift
//  GgeumYeonGgeumJu
//
//  Created by 남수김 on 2020/05/13.
//  Copyright © 2020 남수김. All rights reserved.
//

import UIKit
import Alamofire
import Charts

enum RecordType {
    case smoke, drink
}

class MainViewController: UIViewController {
    @IBOutlet weak var drinkMoneyLabel: UILabel!
    @IBOutlet weak var drinkAmountLabel: UILabel!
    @IBOutlet weak var smokeMoneyLabel: UILabel!
    @IBOutlet weak var smokeAmountLabel: UILabel!
    @IBOutlet weak var smokeChartEmbedView: UIView!
    @IBOutlet weak var drinkChartEmbedView: UIView!
    @IBOutlet weak var smokeChartView: LineChartView!
    @IBOutlet weak var drinkChartView: LineChartView!
    @IBOutlet weak var drinkRecordButton: UIButton!
    @IBOutlet weak var smokeRecordButton: UIButton!
    @IBOutlet weak var drinkNumberView: UIView!
    @IBOutlet weak var drinkMoneyView: UIView!
    @IBOutlet weak var smokeNumberView: UIView!
    @IBOutlet weak var smokeMoneyView: UIView!
    @IBOutlet weak var mainTitleLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var backImgHeightLayout: NSLayoutConstraint!
    
    let backImgMinOriginHeight: CGFloat = 250
    var statusStyle: UIStatusBarStyle = .lightContent
    private var smokeDataList: [ChartDataEntry] = []
    private var drinkDataList: [ChartDataEntry] = []
    
    private let service: MainServiceProtocol = DependencyContainer.shared.getDependency(key: .mainService)
    private var smokeTotalData: TotalSmokeModel? {
        willSet {
            if let newValue = newValue {
                convertMoneyImg(money: newValue.total_price, label: smokeMoneyLabel)
                convertAmountImg(amonut: newValue.total_piece, label: smokeAmountLabel)
                
            }
        }
    }
    
    private var drinkTotalData: TotalDrinkModel? {
        willSet {
            if let newValue = newValue {
                convertMoneyImg(money: newValue.total_price, label: drinkMoneyLabel)
                convertAmountImg(amonut: newValue.total_glass, label: drinkAmountLabel)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestMainInfo()
        applyCardView(views: [smokeMoneyView,
                              smokeNumberView,
                              smokeRecordButton,
                              smokeChartEmbedView,
                              drinkRecordButton,
                              drinkMoneyView,
                              drinkNumberView,
                              drinkChartEmbedView])
        scrollView.delegate = self
        setupChartView(type: .smoke, chart: smokeChartView)
        setupChartView(type: .drink, chart: drinkChartView)
     
    }
    
    func requestMainInfo() {
        service.requestTotalSmoke { result in
            switch result {
            case .success(let data):
                self.smokeTotalData = data
            case .failure(let err):
                print(err)
            }
        }
        
        service.requestTotalDrink { result in
            switch result {
            case .success(let data):
                self.drinkTotalData = data
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func convertMoneyImg(money: Int, label: UILabel) {
        let tempImg = ["☕️","☕️☕️","🍔","🍔🍔","🍝","🍝🍝","🪒","🍣","🍣🍣","👕","👖","👟","✈️","📱","🖥","🤢",]
        var index = money/4000
        if index >= tempImg.count - 1 {
            index = tempImg.count - 1
        }
        label.text = tempImg[index]
    }
    
    func convertAmountImg(amonut: Int, label: UILabel) {
        let tempImg = ["✏️","✏️✏️","✂️","📕","📕📕","📦","🗑","🛒","🛀","🚗","⛺️","🏡","🚃","⛰","🇰🇷","🗺"]
        var index = amonut
        if index >= tempImg.count - 1 {
            index = tempImg.count - 1
        }
        label.text = tempImg[index]
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusStyle
    }

    func applyCardView(views: [UIView]) {
        let offset = CGSize(width: 1, height: 6)
        let radius: CGFloat = 8
        views.forEach {
        $0.dropShadow(color: .lightGray,
                      opacity: 0.4,
                      offSet: offset,
                      radius: radius,
                      scale: true)
        }
        smokeMoneyView.setGradientBackGround(radius: radius, colorOne: .softPink, colorTwo: .softPink, colorThree: .white)
        smokeNumberView.setGradientBackGround(radius: radius, colorOne: .softPink, colorTwo: .softPink, colorThree: .white)
        drinkMoneyView.setGradientBackGround(radius: radius, colorOne: .softSky, colorTwo: .softSky, colorThree: .white)
        drinkNumberView.setGradientBackGround(radius: radius, colorOne: .softSky, colorTwo: .softSky, colorThree: .white)
    }
    
    func fetchMockData() -> [Double] {
        var mockData: [Double] = []
        for _ in 0..<31 {
            let randomValue = Double.random(in: 0..<10)
            mockData.append(randomValue)
        }
        return mockData
    }
    
    func setupChartView(type: RecordType, chart: LineChartView) {
        let mockData = fetchMockData()
        var tempArray: [ChartDataEntry] = []
        for i in 0..<mockData.count {
            let value = ChartDataEntry(x: Double(i), y: mockData[i])
            tempArray.append(value)
        }
        if type == .smoke {
            smokeDataList = tempArray
        } else {
            drinkDataList = tempArray
        }
        
        
        let lableText = type == .smoke ? "흡연" : "음주"
        let pointColor: NSUIColor = type == .smoke ? .softPink : .softSky
        let line = LineChartDataSet(entries: smokeDataList, label: lableText)
        line.setColor(pointColor)
        line.mode = .linear
//        line.fill = Fill(color: .softPink)
//        line.drawFilledEnabled = true
        line.setCircleColor(pointColor)
        line.circleRadius = 3
        
        let data = LineChartData()
        data.addDataSet(line)
        data.setDrawValues(false)
        
        chart.data = data
//        chart.chartDescription?.text = "by 끔연끔주"
        chart.xAxis.labelPosition = .bottom
        chart.xAxis.axisMinimum = 1
        chart.xAxis.axisMaximum = 31
        chart.xAxis.drawGridLinesEnabled = false
        chart.scaleXEnabled = false
        chart.scaleYEnabled = false
        chart.pinchZoomEnabled = false
        chart.doubleTapToZoomEnabled = false
        chart.isUserInteractionEnabled = false
//        chart.animate(xAxisDuration: 1.0)
    }
    
    // TODO: 술, 담배 타입구분
    // 흡연: 1, 음주: 2
    @IBAction func recordClick(_ sender: UIButton) {
        guard let nextVC = storyboard?.instantiateViewController(withIdentifier: ViewControllerIdentifier.recordVC.rawValue) as? RecordViewController else {
            return
        }
        
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
}

extension MainViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y

        var height = backImgMinOriginHeight - offsetY
        height = height < backImgMinOriginHeight ? backImgMinOriginHeight : height
        backImgHeightLayout.constant = height
        
        if offsetY > backImgMinOriginHeight - 44 {
            statusStyle = .darkContent
            setNeedsStatusBarAppearanceUpdate()
        } else {
            statusStyle = .lightContent
            setNeedsStatusBarAppearanceUpdate()
        }
        mainTitleLabel.alpha = 1.0 - offsetY/backImgMinOriginHeight
    }
}
