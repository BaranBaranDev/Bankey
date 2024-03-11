//
//  AppDelegate.swift
//  Bankey
//
//  Created by Baran Baran on 2.03.2024.
//

import UIKit
let appColor : UIColor = .systemTeal

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    private let loginVC = LoginViewController()
    private let onboardingContainerVC = OnboardingContainerViewController()
    private let dummyVC = DummyViewController()
    private let mainVC = MainViewController(
    )
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        loginVC.delegate = self
        onboardingContainerVC.delegate = self
        dummyVC.delegate = self
        window?.rootViewController = AccountSummaryViewController()
        
        return true
    }
    
    
}



// MARK: - AppDelegate Ext

extension AppDelegate{
    private func setRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard animated, let window = self.window else {
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
            return
        }
        
        window.rootViewController = vc
        window.makeKeyAndVisible()
        UIView.transition(with: window,
                          duration: 0.4,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: nil)
    }
}


// MARK: - LoginViewDelegate
extension AppDelegate: LoginViewDelegate{
    func didLogin() {
        print("foo: didLogin")
        if LocalState.hasOnboarded {
            setRootViewController(dummyVC)
        }else{
            setRootViewController(onboardingContainerVC)
        }
        
    }
    
    
}

// MARK: - OnboardingContainerViewControllerDelegate

extension AppDelegate: OnboardingContainerViewControllerDelegate{
    func didFininshOnboarding() {
        LocalState.hasOnboarded = true
        setRootViewController(dummyVC)
        print("foo: didFininshOnboarding")
    }
}



// MARK: - dummyVCDelegate

extension AppDelegate: DummyViewControllerDelegate{
    func didlogOut() {
        setRootViewController(loginVC)
    }
    
    
}


