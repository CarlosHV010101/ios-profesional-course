//
//  ViewController.swift
//  TextField Sandbox
//
//  Created by Administrador on 14/06/23.
//

import UIKit

class ViewController: UIViewController {
    
    let textField = UITextField()
    
    let stackView = UIStackView()
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self
        
        style()
        layout()
    }
    
}

extension ViewController {
    func style() {
     
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Teclea algo "
        
    }
    
    func layout() {
        view.addSubview(textField)
        
        NSLayoutConstraint.activate([
            textField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        
    }
}

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if !string.isEmpty {
            print("El usuario tecleó \(string)")
        }
        
        return true
    }
}

