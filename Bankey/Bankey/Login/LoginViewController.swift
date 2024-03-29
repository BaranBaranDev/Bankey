//
//  ViewController.swift
//  Bankey
//
//  Created by Baran Baran on 2.03.2024.
//

import UIKit

// DummyViewControllerDelegate
protocol LogoutDelegate: AnyObject {
    func didlogOut()
}


//LoginViewDelegate
protocol LoginViewControllerDelegate: AnyObject {
    func didLogin()
}



class LoginViewController: UIViewController {
    
    // MARK: - Properties
    
    
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    
    
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
    
    // animation
    private var leadingEdgeOnScreen: CGFloat = 16
    private var leadingEdgeOffScreen: CGFloat = -1000
    private var titleLeadingAnchor: NSLayoutConstraint?
    private var subtitleLeadingAnchor : NSLayoutConstraint?
    
    // delegate
    weak var delegate : LoginViewControllerDelegate?
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        sigInButton.configuration?.showsActivityIndicator = false
        animate()
    }
    
 
}

// MARK: - Helpers

extension LoginViewController{
    private func style(){
        //loginView.translatesAutoresizingMaskIntoConstraints = false
        
        // title
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        titleLabel.font = .preferredFont(forTextStyle: .extraLargeTitle)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.text = "Bankey"
        titleLabel.alpha = 1
        
        //subtitle
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.textAlignment = .center
        subtitleLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        subtitleLabel.adjustsFontForContentSizeCategory = true
        subtitleLabel.numberOfLines = 0
        subtitleLabel.text = "Your premium source for all things banking!"
        subtitleLabel.alpha = 0.4
       
        
        
        
        //sigInButton
        sigInButton.setTitle("Sig In", for: .normal)
        sigInButton.setTitleColor(.white, for: .normal)
        //sigInButton.backgroundColor = UIColor.brown
        sigInButton.configuration = .filled()
        sigInButton.configuration?.baseBackgroundColor = .systemBrown
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
        view.addSubviews(titleLabel,subtitleLabel,loginView,sigInButton,errorMessageLabel)
        
        // Title && Subtitle
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: subtitleLabel.topAnchor, constant: -50),
            titleLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            loginView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            subtitleLabel.bottomAnchor.constraint(equalTo: loginView.topAnchor, constant: -50),
            subtitleLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            loginView.trailingAnchor.constraint(equalTo: subtitleLabel.trailingAnchor),
            
        ])
        // Animated Title && Subtitle
        titleLeadingAnchor = titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingEdgeOffScreen)
        titleLeadingAnchor?.isActive = true
        subtitleLeadingAnchor = subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingEdgeOffScreen)
        subtitleLeadingAnchor?.isActive = true
        
        
        
        
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
            delegate?.didLogin()
        }else{
            configurationMessage(withMessage: "Incorrect Username/Password")
            return
        }
    }
    
    private func configurationMessage(withMessage message: String){
        errorMessageLabel.isHidden = false
        errorMessageLabel.text = message
        shakeButton()
        
    }
    
    private func shakeButton() {
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position.x"
        animation.values = [0, 10, -10, 10, 0]
        animation.keyTimes = [0, 0.16, 0.5, 0.83, 1]
        animation.duration = 0.4

        animation.isAdditive = true
        sigInButton.layer.add(animation, forKey: "shake")
    }
}




// MARK: - Animations
extension LoginViewController {
    private func animate() {
        let animator1 = UIViewPropertyAnimator(duration: 1, curve: .easeInOut) {
            self.titleLeadingAnchor?.constant = self.leadingEdgeOnScreen
            self.view.layoutIfNeeded()
        }
        
        let animator2 = UIViewPropertyAnimator(duration: 1, curve: .easeInOut){
            self.subtitleLeadingAnchor?.constant = self.leadingEdgeOnScreen
            self.view.layoutIfNeeded()
        }
        
        let animator3 = UIViewPropertyAnimator(duration: 2, curve: .easeInOut){
            self.subtitleLabel.alpha = 1
        }
        animator1.startAnimation()
        animator2.startAnimation(afterDelay: 1)
        animator3.startAnimation(afterDelay: 2)
    }
}
