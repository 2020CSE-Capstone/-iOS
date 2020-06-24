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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextField()
    }
    
    func setupTextField() {
        emailTextField.addLeftPadding(num: 10)
        pwTextField.addLeftPadding(num: 10)
    }
    
    @IBAction func signUpClick(_ sender: Any) {
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: ViewControllerIdentifier.signUpOneStepVC.rawValue) else {
            return
        }
        nextVC.modalPresentationStyle = .fullScreen
        present(nextVC, animated: true)
    }
    
    @IBAction func loginClick(_ sender: Any) {
    }
}
