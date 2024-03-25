//
//  ViewController.swift
//  RefV-1
//
//  Created by АХМЕДОВ НИКОЛАЙ on 20/06/2023.
//  Copyright © 2023 Ahmedov Nikolay. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Log In"
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        return label
    }()
    private let emailField: UITextField = {
        let emailField = UITextField()
        emailField.placeholder = "Email Address"
        emailField.layer.borderWidth = 1
        emailField.autocapitalizationType = .none
        emailField.layer.borderColor = UIColor.black.cgColor
        emailField.backgroundColor = .white
        emailField.leftViewMode = .always
        emailField.leftView = UIView(frame: CGRect (x: 0, y: 0, width: 5, height: 0))
        return emailField
    }()
    private let passwordField: UITextField = {
        let passField = UITextField()
        passField.placeholder = "Password"
        passField.layer.borderWidth = 1
        passField.isSecureTextEntry = true
        passField.layer.borderColor = UIColor.black.cgColor
        passField.backgroundColor = .white
        passField.leftViewMode = .always
        passField.leftView = UIView(frame: CGRect (x: 0, y: 0, width: 5, height: 0))
        return passField
    }()
    private let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGray
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Continue", for: .normal)
        return button
    }()
    private let signOutbutton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGray
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Log Out", for: .normal)
        return button
    }()
    public let skipButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Skip", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(didTapSkip), for: .touchUpInside)
        return button
    }()

    
    
    @objc func didTapSkip() {
     let vc = AdviceViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    
    var skipButtonTopAnchor: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(button)
        view.addSubview(skipButton)
        view.backgroundColor = .systemGray3
        
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        if FirebaseAuth.Auth.auth().currentUser != nil {
            label.isHidden = true
            button.isHidden = true
            emailField.isHidden = true
            passwordField.isHidden = true
            skipButton.isHidden = true
            
            view.addSubview(signOutbutton)
            signOutbutton.frame = CGRect(x: 20, y: 150, width: view.frame.size.width-40, height: 54)
            signOutbutton.addTarget(self, action: #selector(logOutTapped), for: .touchUpInside)

        }
    }
    
    @objc private func logOutTapped() {
        do {
            try FirebaseAuth.Auth.auth().signOut()
            
            label.isHidden = false
            button.isHidden = false
            emailField.isHidden = false
            passwordField.isHidden = false
            
            signOutbutton.removeFromSuperview()
            
        } catch  {
            print("An error occured")
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        label.frame = CGRect(x: 0, y: 100, width: view.frame.size.width, height: 80)
        emailField.frame = CGRect(x: 20,
                                  y: label.frame.origin.y + label.frame.size.height + 10,
                                  width: view.frame.size.width - 40 ,
                                  height: 50)
        passwordField.frame = CGRect(x: 20,
                                     y: emailField.frame.origin.y + emailField.frame.size.height + 10,
                                     width: view.frame.size.width - 40,
                                     height: 50)
        button.frame = CGRect(x: 20,
                              y: passwordField.frame.origin.y + passwordField.frame.size.height + 50,
                              width: view.frame.size.width - 40,
                              height: 54)
        skipButton.frame = CGRect(x: 20,
                              y: 40 ,
                              width: 50,
                              height: 50)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if FirebaseAuth.Auth.auth().currentUser == nil {
            emailField.becomeFirstResponder()
        }
        
    }

    @objc private func didTapButton() {
        print("Continue button tapped")
        guard let email = emailField.text, !email.isEmpty,
            let password = passwordField.text, !password.isEmpty else {
                print("Missing field data")
                return
                
        }
      
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: { [weak self]result, error in
            guard let strongSelf = self  else {
                return
            }
            
            guard error == nil else {
    //account creation
                strongSelf.showCreateAccount(email: email, password: password)
                return
            }
            print ("You have signed in")
            strongSelf.label.isHidden = true
            strongSelf.emailField.isHidden = true
            strongSelf.passwordField.isHidden = true
            strongSelf.button.isHidden = true
            
            strongSelf.emailField.resignFirstResponder()
            strongSelf.passwordField.resignFirstResponder()
        })
}
    func showCreateAccount(email: String, password: String) {
        let alert = UIAlertController(title: "Create Account",
                                      message: "Would you like to create an account",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Continue",
                                      style: .default,
                                      handler: { _ in
                                        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: {result , error in
                                            
                                        })
        }))
        alert.addAction(UIAlertAction(title: "Cancel",
                                      style: .cancel,
                                      handler: { _ in
                                         FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: { [weak self]result, error in
                                                   guard let strongSelf = self  else {
                                                       return
                                                   }
                                                   
                                                   guard error == nil else {
                                           //account creation
                                                       //strongSelf.showCreateAccount(email: email, password: password)
                                                    print ("Account creation failed")
                                                       return
                                                   }
                                                   print ("You have signed in")
                                                   strongSelf.label.isHidden = true
                                                   strongSelf.emailField.isHidden = true
                                                   strongSelf.passwordField.isHidden = true
                                                   strongSelf.button.isHidden = true
                                            
                                                   strongSelf.emailField.resignFirstResponder()
                                                   strongSelf.passwordField.resignFirstResponder()
                                               })
        }))
        present (alert, animated: true)
    }
}
