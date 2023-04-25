//
//  AppDelegate.swift
//  Bankey
//
//  Created by Administrador on 19/04/23.
//

import UIKit

let appColor: UIColor = .systemTeal

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    let loginViewController = LoginViewController()
    let onboardingController = OnboardingContainerViewController()
    let dummyController = DummyViewController()
    let mainViewController = MainViewController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        loginViewController.delegate = self
        onboardingController.delegate = self
        dummyController.delegate = self
        window?.rootViewController = mainViewController
        
        return true
    }
}


//MARK: LoginViewControllerDelegate
extension AppDelegate: LoginViewControllerDelegate {
    func didLogin() {
        if LocalState.hasOnboarded {
            setRootController(dummyController)
        } else {
            setRootController(onboardingController)
        }
    }
}

//MARK: OnboardingContainerViewControllerDelegate
extension AppDelegate: OnboardingContainerViewControllerDelegate {
    func didFinishOnboarding() {
        LocalState.hasOnboarded = true
        setRootController(dummyController)
    }
}

//MARK: LogoutDelegate
extension AppDelegate: LogoutDelegate {
    func didLogout() {
        setRootController(loginViewController)
    }
}

//MARK: SET ROOT CONTROLLER
extension AppDelegate {
    func setRootController(_ vc: UIViewController, animated: Bool = true) {
        guard animated, let window = self.window else {
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
            return
        }
        
        window.rootViewController = vc
        window.makeKeyAndVisible()
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
}
