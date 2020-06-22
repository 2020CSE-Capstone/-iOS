//
//  RecordViewController.swift
//  GgeumYeonGgeumJu
//
//  Created by 남수김 on 2020/05/14.
//  Copyright © 2020 남수김. All rights reserved.
//

import UIKit

class RecordViewController: UIViewController {
    
    @IBOutlet weak var figureLabel: UILabel!
    @IBOutlet weak var numUnderView: UIView!
    @IBOutlet weak var kindUnderView: UIView!
    @IBOutlet weak var numTextField: UITextField!
    @IBOutlet weak var kindTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    lazy var datePicker = UIDatePicker()
    lazy var kindPickerView = UIPickerView()
    lazy var numPickerView = UIPickerView()
    lazy var flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                        target: self,
                                        action: nil)
    
    let testDrinkNum = ["1","2","3","4","5"]
    var pickKindDrinkIndex = 0
    var dummyData: [GoodsList] = []

    private let service: RecordServiceProtocol
        = DependencyContainer.shared.getDependency(key: .recordService)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        blinkTitleLabel()
        createDatePicker()
        setupKindPickerView()
        setupNumPickerView()
        fetchTestData()
        
    }
    
    func fetchTestData() {
        let 참이슬 = Drink(title: "참이슬", price: 400)
        let 진로 = Drink(title: "진로", price: 450)
        let 처음처럼 = Drink(title: "처음처럼", price: 500)
        let 카스 = Drink(title: "카스", price: 400)
        let 클라우드 = Drink(title: "클라우드", price: 450)
        let 테라 = Drink(title: "테라", price: 500)
        let 앱솔 = Drink(title: "앱솔", price: 400)
        let 스미노프 = Drink(title: "스미노프", price: 450)
        let 아그와 = Drink(title: "아그와", price: 500)
        let soju = [참이슬, 진로, 처음처럼]
        let beer = [카스, 클라우드, 테라]
        let liquor = [앱솔, 스미노프, 아그와]
        
        let sojuList = GoodsList(title: "소주", list: soju)
        let beerList = GoodsList(title: "맥주", list: beer)
        let liquorList = GoodsList(title: "양주", list: liquor)
        
        dummyData = [sojuList, beerList, liquorList]
    }
    
    func blinkTitleLabel() {
        titleLabel.alpha = 0.2
        UIView.animate(withDuration: 0.7, delay: 0, options: [.allowUserInteraction, .autoreverse, .repeat], animations: {
            self.titleLabel.alpha = 1
        })
    }
    
    // MARK: 날짜 PickerView
    func createDatePicker() {
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = #colorLiteral(red: 0.325219363, green: 0.3228738904, blue: 0.3270186782, alpha: 0.7274702905)
        datePicker.locale = Locale(identifier: "ko")
        let toolbar = UIToolbar()
        toolbar.barStyle = .black
        toolbar.isTranslucent = true
        toolbar.sizeToFit()
        toolbar.isUserInteractionEnabled = true
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done,
                                      target: self,
                                      action: #selector(pressDateDone))
        doneBtn.tintColor = #colorLiteral(red: 0.7834629416, green: 0.237608701, blue: 0.3743506074, alpha: 1)
        toolbar.setItems([flexible, doneBtn], animated: false)
        
        dateTextField.inputAccessoryView = toolbar
        dateTextField.inputView = datePicker
        dateTextField.text = Date().datePickerToString()
    }
    
    @objc func pressDateDone() {
        let date = datePicker.date.datePickerToString()
        dateTextField.text = date
        view.endEditing(true)
    }
    
    // MARK: 주종 PickerView
    func setupKindPickerView() {
        kindPickerView.dataSource = self
        kindPickerView.delegate = self
        kindPickerView.backgroundColor = #colorLiteral(red: 0.325219363, green: 0.3228738904, blue: 0.3270186782, alpha: 0.7274702905)
        let toolbar = UIToolbar()
        toolbar.barStyle = .black
        toolbar.isTranslucent = true
        toolbar.sizeToFit()
        toolbar.isUserInteractionEnabled = true
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done,
                                      target: self,
                                      action: #selector(pressKindDone))
        doneBtn.tintColor = #colorLiteral(red: 0.7834629416, green: 0.237608701, blue: 0.3743506074, alpha: 1)
        toolbar.setItems([flexible, doneBtn], animated: false)
        kindTextField.inputAccessoryView = toolbar
        kindTextField.inputView = kindPickerView
    }
    
    @objc func pressKindDone() {
        let selectKind = kindPickerView.selectedRow(inComponent: 0)
        let selectBrand = kindPickerView.selectedRow(inComponent: 1)
        let drink = dummyData[selectKind].getDrink(index: selectBrand)
        kindTextField.text = drink.title
        kindUnderView.backgroundColor = .softSky
        view.endEditing(true)
    }
    
    // MARK: 잔수 PickerView
    func setupNumPickerView() {
        numPickerView.dataSource = self
        numPickerView.delegate = self
        numPickerView.backgroundColor = #colorLiteral(red: 0.325219363, green: 0.3228738904, blue: 0.3270186782, alpha: 0.7274702905)
        let toolbar = UIToolbar()
        toolbar.barStyle = .black
        toolbar.isTranslucent = true
        toolbar.sizeToFit()
        toolbar.isUserInteractionEnabled = true
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done,
                                      target: self,
                                      action: #selector(pressNumDone))
        doneBtn.tintColor = #colorLiteral(red: 0.7834629416, green: 0.237608701, blue: 0.3743506074, alpha: 1)
        toolbar.setItems([flexible, doneBtn], animated: false)
        numTextField.inputAccessoryView = toolbar
        numTextField.inputView = numPickerView
    }
    
    @objc func pressNumDone() {
        let selectRow = numPickerView.selectedRow(inComponent: 0)
        let num = testDrinkNum[selectRow]
        numTextField.text = "\(num)"
        numUnderView.backgroundColor = .softSky
        view.endEditing(true)
    }
    
    @IBAction func saveClick(_ sender: Any) {
        guard kindTextField.hasText && numTextField.hasText else {
            simpleAlert(title: "모두 작성해주세요", message: "빈칸을 확인하세요")
            return
        }
        var figure: Double = 0
        if var tempFigure = figureLabel.text {
            tempFigure.removeLast()
            figure = Double(tempFigure)!
        }
        var glass = 0
        if let tempGlass = numTextField.text {
            glass = Int(tempGlass)!
        }
        let record = RecordModel(id: -1, figure: figure, glass: glass, drinkDate: dateTextField.text!, drinkName: kindTextField.text!)

        service.requestRecordSave(record: record) { isSuccess in
            // TODO: 서버응답
        }
    }
    
    @IBAction func backClick(_ sender: Any) {
           navigationController?.popViewController(animated: true)
       }
}

extension RecordViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView == kindPickerView {
            // 술종류, 브랜드종류
            return 2
        } else if pickerView == numPickerView {
            return 1
        } else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == kindPickerView {
            return dummyData[component].getList().count
        } else if pickerView == numPickerView {
            return testDrinkNum.count
        } else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == kindPickerView {
            // 0: 술종류, 1: 브랜드종류
            switch component {
            case 0:
                return dummyData[row].title
            case 1:
                return dummyData[pickKindDrinkIndex].getList()[row]
            default:
                return nil
            }
        } else if pickerView == numPickerView {
            return "\(testDrinkNum[row]) 잔"
        } else {
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == kindPickerView {
            switch component {
            case 0:
                pickKindDrinkIndex = row
                pickerView.reloadComponent(1)
            default:
                return
            }
        } else if pickerView == numPickerView {
            
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        if component == 0 {
            return 100
        }
        return 200
    }
}


protocol GoodsListProtocol {
    var title: String { get }
    var list: [Drink] { set get }
}

extension GoodsListProtocol {
    mutating func addGoods(goods: Drink) {
        self.list.append(goods)
    }
    
    func getList() -> [String] {
        return list.map{$0.title}
    }
    
    func getDrink(index: Int) -> Drink {
        return self.list[index]
    }
}

struct GoodsList: GoodsListProtocol {
    var title: String
    var list: [Drink]
}

struct Drink {
    let title: String
    let price: Int
}
