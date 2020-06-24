//
//  SignUpTwoStepViewController.swift
//  GgeumYeonGgeumJu
//
//  Created by 남수김 on 2020/06/24.
//  Copyright © 2020 남수김. All rights reserved.
//

import UIKit

class SignUpTwoStepViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var ageView: UIView!
    @IBOutlet weak var drinkView: UIView!
    @IBOutlet weak var smokeView: UIView!
    @IBOutlet weak var determineView: UIView!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var drinkTextField: UITextField!
    @IBOutlet weak var smokeTextField: UITextField!
    @IBOutlet weak var determineTextField: UITextField!
    
    var model: SignUpModel?
    
    private let duration = 0.7
    private let damping: CGFloat = 0.7
    private let velocity: CGFloat = 1
    
    private lazy var agePicker = UIPickerView()
    private lazy var drinkPicker = UIPickerView()
    private lazy var smokePicker = UIPickerView()
    
    lazy var upImage = UIImage(systemName: "chevron.up")
    lazy var downImage = UIImage(systemName: "chevron.down")
    lazy var flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                        target: self,
                                        action: nil)
    lazy var textFields = [ageTextField, drinkTextField, smokeTextField, determineTextField]
    private var ageList: [String] = []
    private var drinkList: [String] = []
    private var smokeList: [String] = []
    
    private let serivce: LoginServiceProtocol
        = DependencyContainer.shared.getDependency(key: .loginService)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ageView.alpha = 0
        drinkView.alpha = 0
        smokeView.alpha = 0
        determineView.alpha = 0
        fetchModel()
        setupTextField()
        createAgePicker()
        createDrinkPicker()
        createSmokePicker()
        
        appearAnim()
    }
    
    func fetchModel() {
        DispatchQueue.global().async {
            for i in 19...50 {
                self.ageList.append("\(i)")
            }
            for i in 1...15 {
                self.drinkList.append("\(i)")
            }
            for i in 1...50 {
                self.smokeList.append("\(i)")
            }
        }
    }
    
    func setupTextField() {
        textFields.forEach {
            $0?.delegate = self
        }
    }
    
    func appearAnim() {
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            self.ageView.transform = CGAffineTransform(translationX: 0, y: -100)
            UIView.animate(withDuration: self.duration, delay: 0, usingSpringWithDamping: self.damping, initialSpringVelocity: self.velocity, options: [.allowUserInteraction, .curveEaseIn], animations: {
                self.ageView.transform = .identity
                self.ageView.alpha = 1
            }) { _ in
                self.drinkView.transform = CGAffineTransform(translationX: 0, y: -100)
                UIView.animate(withDuration: self.duration, delay: 0, usingSpringWithDamping: self.damping, initialSpringVelocity: self.velocity, options: [.allowUserInteraction, .curveEaseIn], animations: {
                    self.drinkView.transform = .identity
                    self.drinkView.alpha = 1
                }) { _ in
                    self.smokeView.transform = CGAffineTransform(translationX: 0, y: -100)
                    UIView.animate(withDuration: self.duration, delay: 0, usingSpringWithDamping: self.damping, initialSpringVelocity: self.velocity, options: [.allowUserInteraction, .curveEaseIn], animations: {
                        self.smokeView.transform = .identity
                        self.smokeView.alpha = 1
                    }) { _ in
                        self.determineView.transform = CGAffineTransform(translationX: 0, y: -100)
                        UIView.animate(withDuration: self.duration, delay: 0, usingSpringWithDamping: self.damping, initialSpringVelocity: self.velocity, options: [.allowUserInteraction, .curveEaseIn], animations: {
                            self.determineView.transform = .identity
                            self.determineView.alpha = 1
                        })
                    }
                }
            }
        }
    }
    
    func createAgePicker() {
        agePicker.dataSource = self
        agePicker.delegate = self
        agePicker.backgroundColor = #colorLiteral(red: 0.325219363, green: 0.3228738904, blue: 0.3270186782, alpha: 0.7274702905)
        let toolbar = UIToolbar()
        toolbar.barStyle = .black
        toolbar.isTranslucent = true
        toolbar.sizeToFit()
        toolbar.isUserInteractionEnabled = true
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done,
                                      target: self,
                                      action: #selector(self.pressAgeDone))
        let upBtn = UIBarButtonItem(image: upImage,
                                    style: .done,
                                    target: self,
                                    action: #selector(self.pressUp))
        let downBtn = UIBarButtonItem(image: downImage,
                                      style: .done,
                                      target: self,
                                      action: #selector(self.pressDown))
        upBtn.tag = 1
        downBtn.tag = 1
        
        doneBtn.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        toolbar.setItems([upBtn, downBtn, flexible, doneBtn], animated: false)
        ageTextField.inputAccessoryView = toolbar
        ageTextField.inputView = agePicker
    }
    
    func createDrinkPicker() {
        drinkPicker.dataSource = self
        drinkPicker.delegate = self
        drinkPicker.backgroundColor = #colorLiteral(red: 0.325219363, green: 0.3228738904, blue: 0.3270186782, alpha: 0.7274702905)
        let toolbar = UIToolbar()
        toolbar.barStyle = .black
        toolbar.isTranslucent = true
        toolbar.sizeToFit()
        toolbar.isUserInteractionEnabled = true
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done,
                                      target: self,
                                      action: #selector(self.pressDrinkDone))
        let upBtn = UIBarButtonItem(image: upImage,
                                    style: .done,
                                    target: self,
                                    action: #selector(self.pressUp))
        let downBtn = UIBarButtonItem(image: downImage,
                                      style: .done,
                                      target: self,
                                      action: #selector(self.pressDown))
        upBtn.tag = 2
        downBtn.tag = 2
        doneBtn.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        toolbar.setItems([upBtn, downBtn, flexible, doneBtn], animated: false)
        drinkTextField.inputAccessoryView = toolbar
        drinkTextField.inputView = drinkPicker
    }
    
    func createSmokePicker() {
        smokePicker.dataSource = self
        smokePicker.delegate = self
        smokePicker.backgroundColor = #colorLiteral(red: 0.325219363, green: 0.3228738904, blue: 0.3270186782, alpha: 0.7274702905)
        let toolbar = UIToolbar()
        toolbar.barStyle = .black
        toolbar.isTranslucent = true
        toolbar.sizeToFit()
        toolbar.isUserInteractionEnabled = true
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done,
                                      target: self,
                                      action: #selector(self.pressSmokeDone))
        let upBtn = UIBarButtonItem(image: upImage,
                                    style: .done,
                                    target: self,
                                    action: #selector(self.pressUp))
        let downBtn = UIBarButtonItem(image: downImage,
                                      style: .done,
                                      target: self,
                                      action: #selector(self.pressDown))
        upBtn.tag = 3
        downBtn.tag = 3
        doneBtn.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        toolbar.setItems([upBtn, downBtn, flexible, doneBtn], animated: false)
        smokeTextField.inputAccessoryView = toolbar
        smokeTextField.inputView = smokePicker
    }
    
    @objc
    func pressAgeDone() {
        let row = agePicker.selectedRow(inComponent: 0)
        let age = ageList[row]
        ageTextField.text = "\(age)세"
        model?.age = Int(age)
        view.endEditing(true)
    }
    
    @objc
    func pressDrinkDone() {
        let row = drinkPicker.selectedRow(inComponent: 0)
        let drink = drinkList[row]
        drinkTextField.text = "\(drink)병"
        model?.drinkAmount = Int(drink)
        view.endEditing(true)
    }
    
    @objc
    func pressSmokeDone() {
        let row = smokePicker.selectedRow(inComponent: 0)
        let smoke = smokeList[row]
        smokeTextField.text = "\(smoke)개비"
        model?.smokeAmount = Int(smoke)
        view.endEditing(true)
    }
    
    @objc
    func pressUp(sender: UIBarButtonItem) {
        
        let index = sender.tag - 1
        if index < 1 {
            return
        }
        textFields.forEach {
            guard let textField = $0 else {
                return
            }
            if textField.tag == index {
                textField.becomeFirstResponder()
            }
        }
    }
    
    @objc
    func pressDown(sender: UIBarButtonItem) {
        let index = sender.tag + 1
        if index > 4 {
            return
        }
        textFields.forEach {
            guard let textField = $0 else {
                return
            }
            if textField.tag == index {
                textField.becomeFirstResponder()
            }
        }
    }
    
    @IBAction func backClick(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func completeClick(_ sender: Any) {
        
        guard ageTextField.hasText,
            drinkTextField.hasText,
            smokeTextField.hasText,
            determineTextField.hasText else {
                simpleAlert(title: "실패", message: "빈칸을 확인해주세요")
                return
        }
        
        model?.determine = determineTextField.text
        
        serivce.requestSignUp(model: model!) { isSuccess in
            guard let isSuccess = isSuccess else {
                return
            }
            DispatchQueue.main.async {
                if isSuccess {
                    self.alertWithHandler(title: "완료", message: "회원가입이 완료되었습니다") { _ in
                        self.dismiss(animated: true)
                    }
                } else {
                    self.simpleAlert(title: "실패", message: "다시 시도해주세요")
                }
            }
        }
        
        
    }
}

extension SignUpTwoStepViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == agePicker {
            return ageList.count
        } else if pickerView == drinkPicker {
            return drinkList.count
        } else if pickerView == smokePicker {
            return smokeList.count
        } else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == agePicker {
            return "\(ageList[row])세"
        } else if pickerView == drinkPicker {
            return "\(drinkList[row])병"
        } else if pickerView == smokePicker {
            return "\(smokeList[row])개비"
        } else {
            return nil
        }
    }
}
