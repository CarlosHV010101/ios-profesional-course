//
//  AppDelegate.swift
//  Password
//
//  Created by Administrador on 07/06/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        let window = UIApplication.shared.windows.first
        window?.backgroundColor = .systemBackground
        
        // Crea una instancia de tu controlador de vista personalizado
        let viewController = ViewController()
        
        // Establece el controlador de vista personalizado como el controlador de vista raíz
        window?.rootViewController = viewController
        
        return true
    }

}

