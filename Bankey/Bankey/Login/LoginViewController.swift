//
//  ViewController.swift
//  Bankey
//
//  Created by Baran Baran on 2.03.2024.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    
    private let loginView = LoginView()
    
    // Butona tıklama işlemi için kontroller olacağından butonu view yerine controller da oluşturmayı uygun gördüm.
    private let sigInButton = UIButton(type: .system)
    private let errorMessageLabel = UILabel()
    
    //computer property
    private var username : String? {
        return loginView.usernameTextField.text
    }
    
    private var password: String? {
        return loginView.passwordTextField.text
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

// MARK: - Helpers

extension LoginViewController{
    private func style(){
        //loginView.translatesAutoresizingMaskIntoConstraints = false
        
        //sigInButton
        sigInButton.setTitle("Sig In", for: .normal)
        sigInButton.configuration = .filled()
        sigInButton.configuration?.imagePadding = 8
        sigInButton.addTarget(self, action: #selector(sigInTapped), for: .touchUpInside)
        sigInButton.layer.cornerRadius = 15
        
        //errorMessageLabel
        errorMessageLabel.text = "Error failure"
        errorMessageLabel.textColor = .systemRed
        errorMessageLabel.textAlignment = .center
        errorMessageLabel.numberOfLines = 0
        errorMessageLabel.isHidden = true
        
        
    }
    
    private func layout(){
        //view.addSubview(loginView)
        view.addSubviews(loginView,sigInButton,errorMessageLabel)
        
        // loginView
        NSLayoutConstraint.activate([
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1),
        ])
        
        
        // sigInButton
        NSLayoutConstraint.activate([
            sigInButton.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 3),
            sigInButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: sigInButton.trailingAnchor, multiplier: 1),
        ])
        
        
        //errorMessageLabel
        NSLayoutConstraint.activate([
            errorMessageLabel.topAnchor.constraint(equalToSystemSpacingBelow: sigInButton.bottomAnchor, multiplier: 2),
            errorMessageLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            errorMessageLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
        ])
        
    }
}




// MARK: - Actions

extension LoginViewController{
    @objc func sigInTapped(){
        errorMessageLabel.isHidden = true
        login()
        
    }
    
    private func login(){
        guard let username = username, let password = password else {
            assertionFailure("Username/Password nil!")
            return
        }
        
        if username.isEmpty || password.isEmpty {
            configurationMessage(withMessage: "Username/Password cannot blank")
            return
        }
        
        if username == "Baran" && password == "123456" {
            sigInButton.configuration?.showsActivityIndicator = true
        }else{
            configurationMessage(withMessage: "Incorrect Username/Password")
            return
        }
    }
    
    private func configurationMessage(withMessage message: String){
        errorMessageLabel.isHidden = false
        errorMessageLabel.text = message
        
    }
}
