//
//  RecordViewController.swift
//  GgeumYeonGgeumJu
//
//  Created by 남수김 on 2020/05/14.
//  Copyright © 2020 남수김. All rights reserved.
//

import UIKit

class RecordViewController: UIViewController {
    
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
    
    let testPickerDate = ["1","2","3","4","5"]
    let drinkgData: [String: [String]] =
        ["소주": ["참이슬", "진로"],
        "맥주": ["하이트", "카스"],
        "양주": ["아그와", "앱솔"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        blinkTitleLabel()
        createDatePicker()
        setupKindPickerView()
        setupNumPickerView()
    }
    
    func blinkTitleLabel() {
        titleLabel.alpha = 0.2
//        let blink = CGAffineTransform(scaleX: 1.2, y: 1.2)
        UIView.animate(withDuration: 0.7, delay: 0, options: [.allowUserInteraction, .autoreverse, .repeat], animations: {
//            self.titleLabel.transform = blink
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
                                      action: #selector(pressKindDone))
        doneBtn.tintColor = #colorLiteral(red: 0.7834629416, green: 0.237608701, blue: 0.3743506074, alpha: 1)
        toolbar.setItems([flexible, doneBtn], animated: false)
        numTextField.inputAccessoryView = toolbar
        numTextField.inputView = numPickerView
    }
}

extension RecordViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView == kindPickerView {
            return drinkgData.count
        } else if pickerView == numPickerView {
            return 1
        } else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == kindPickerView {
            return drinkgData[co]
        } else if pickerView == numPickerView {
            return testPickerDate.count
        } else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == kindPickerView {
            if
        } else if pickerView == numPickerView {
            return testPickerDate.count
        } else {
            return 0
        }
    }
}
