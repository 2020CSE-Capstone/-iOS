//
//  LoginViewController.swift
//  GgeumYeonGgeumJu
//
//  Created by 남수김 on 2020/06/22.
//  Copyright © 2020 남수김. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    
    private let service: LoginServiceProtocol
        = DependencyContainer.shared.getDependency(key: .loginService)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
    }
    
    func setupTextField() {
        emailTextField.addLeftPadding(num: 10)
        pwTextField.addLeftPadding(num: 10)
    }
    
    @IBAction func signUpClick(_ sender: Any) {
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: ViewControllerIdentifier.signUpNC.rawValue) else {
            return
        }
        nextVC.modalPresentationStyle = .fullScreen
        present(nextVC, animated: true)
    }
    
    @IBAction func loginClick(_ sender: Any) {
        guard let email = emailTextField.text,
            let pw = pwTextField.text else {
                return
        }
        service.requestLogin(email: email, pw: pw) { isSuccess in
            DispatchQueue.main.async {
                guard let isSuccess = isSuccess else {
                    return
                }
                
                if isSuccess {
                    let sb = UIStoryboard(name: StoryBoardName.tabBar.rawValue, bundle: nil)
                    let nextVC = sb.instantiateViewController(withIdentifier: ViewControllerIdentifier.mainTBC.rawValue)
                    nextVC.modalPresentationStyle = .fullScreen
                    self.present(nextVC, animated: true)
                } else {
                    self.simpleAlert(title: "로그인 실패", message: "다시한번 확인해주세요")
                }
            }
        }
    }
}
