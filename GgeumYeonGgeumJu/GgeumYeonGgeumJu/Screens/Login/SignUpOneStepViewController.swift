//
//  SignUpOneStepViewController.swift
//  GgeumYeonGgeumJu
//
//  Created by 남수김 on 2020/06/24.
//  Copyright © 2020 남수김. All rights reserved.
//

import UIKit

class SignUpOneStepViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var pwView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var emailCheckButton: UIButton!
    @IBOutlet weak var nameCheckButton: UIButton!
    
    private let duration = 1.0
    private let damping: CGFloat = 0.7
    private let velocity: CGFloat = 1
    
    private var isCheckEmail = false {
        willSet {
            DispatchQueue.main.async {
                if newValue {
                    self.emailCheckButton.isEnabled = false
                    self.emailCheckButton.backgroundColor = .lightGray
                } else {
                    self.emailCheckButton.isEnabled = true
                    self.emailCheckButton.backgroundColor = #colorLiteral(red: 1, green: 0.8185527325, blue: 0.8639569879, alpha: 1)
                }
                self.isNextEnable = newValue && self.isCheckName
            }
            
        }
    }
    
    private var isCheckName = false {
        willSet {
            DispatchQueue.main.async {
                if newValue {
                    self.nameCheckButton.isEnabled = false
                    self.nameCheckButton.backgroundColor = .lightGray
                } else {
                    self.nameCheckButton.isEnabled = true
                    self.nameCheckButton.backgroundColor = #colorLiteral(red: 1, green: 0.8185527325, blue: 0.8639569879, alpha: 1)
                }
                self.isNextEnable = newValue && self.isCheckEmail
            }
        }
    }
    
    private var isNextEnable = false {
        willSet {
            DispatchQueue.main.async {
                if newValue {
                    self.nextButton.isEnabled = true
                    self.nextButton.backgroundColor = #colorLiteral(red: 1, green: 0.8185527325, blue: 0.8639569879, alpha: 1)
                } else {
                    self.nextButton.isEnabled = false
                    self.nextButton.backgroundColor = .lightGray
                }
            }
        }
    }
    
    private let service: LoginServiceProtocol
        = DependencyContainer.shared.getDependency(key: .loginService)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameView.alpha = 0
        pwView.alpha = 0
        emailView.alpha = 0
        textFieldObserve()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        appearAnim()
    }
    
    func textFieldObserve() {
        emailTextField.delegate = self
        nameTextField.delegate = self
        pwTextField.delegate = self
        
        emailTextField.addTarget(self, action: #selector(self.resetEmailButton), for: .editingChanged)
        nameTextField.addTarget(self, action: #selector(self.resetNameButton), for: .editingChanged)
    }
    
    @objc
    func resetEmailButton() {
        isCheckEmail = false
    }
    
    @objc
    func resetNameButton() {
        isCheckName = false
    }
    
    func appearAnim() {
        DispatchQueue.main.async {
            self.emailView.transform = CGAffineTransform(translationX: 0, y: -100)
            UIView.animate(withDuration: self.duration, delay: 0, usingSpringWithDamping: self.damping, initialSpringVelocity: self.velocity, options: [.allowUserInteraction, .curveEaseIn], animations: {
                self.emailView.transform = .identity
                self.emailView.alpha = 1
            }) { _ in
                self.pwView.transform = CGAffineTransform(translationX: 0, y: -100)
                UIView.animate(withDuration: self.duration, delay: 0, usingSpringWithDamping: self.damping, initialSpringVelocity: self.velocity, options: [.allowUserInteraction, .curveEaseIn], animations: {
                    self.pwView.transform = .identity
                    self.pwView.alpha = 1
                }) { _ in
                    self.nameView.transform = CGAffineTransform(translationX: 0, y: -100)
                    UIView.animate(withDuration: self.duration, delay: 0, usingSpringWithDamping: self.damping, initialSpringVelocity: self.velocity, options: [.allowUserInteraction, .curveEaseIn], animations: {
                        self.nameView.transform = .identity
                        self.nameView.alpha = 1
                    })
                }
            }
        }
    }
    
    @IBAction func emailCheckClick(_ sender: Any) {
        guard emailTextField.hasText,
            let email = emailTextField.text else {
            return
        }
        
        service.requestCheckEmail(email: email) { isSuccess in
            guard let isSuccess = isSuccess else {
                self.isCheckEmail = false
                return
            }
            self.isCheckEmail = isSuccess
        }
    }
    
    @IBAction func nameCheckClick(_ sender: Any) {
        guard nameTextField.hasText,
            let name = nameTextField.text else {
            return
        }
        service.requestCheckName(name: name) { isSuccess in
            guard let isSuccess = isSuccess else {
                self.isCheckName = false
                return
            }
            self.isCheckName = isSuccess
        }
    }
    
    @IBAction func nextClick(_ sender: Any) {
        guard let nextVC = storyboard?.instantiateViewController(withIdentifier: ViewControllerIdentifier.signUpTwoStepVC.rawValue) as? SignUpTwoStepViewController else {
            return
        }
        let model = SignUpModel()
        model.email = emailTextField.text
        model.pw = pwTextField.text
        model.nickName = nameTextField.text
        
        nextVC.model = model
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}

