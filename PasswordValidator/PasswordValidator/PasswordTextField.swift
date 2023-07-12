//
//  PasswordTextField.swift
//  PasswordValidator
//
//  Created by Administrador on 12/06/23.
//

import Foundation
import UIKit

protocol PasswordTextFieldDelegate: AnyObject {
    func editingChanged(_ sender: PasswordTextField)
    func editingDidEnd(_ sender: PasswordTextField)
}

class PasswordTextField: UIView {
    
    typealias CustomValidation = (_ textValue: String?) -> (Bool, String)?
    
    let lockImageView = UIImageView(image: UIImage(systemName: "lock.fill"))
    let textField = UITextField()
    let eyeButton = UIButton(type: .custom)
    let dividerView = UIView()
    let errorMessageLabel = UILabel()
    
    let placeHolderText: String
    var customValidation: CustomValidation?
    weak var delegate: PasswordTextFieldDelegate?
    
    var text: String? {
        get { return textField.text }
        set { textField.text = newValue }
    }
    
    init(placeHolderText: String) {
        self.placeHolderText = placeHolderText
        
        super.init(frame: .zero)
        
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 60)
    }
}

extension PasswordTextField {
    
    func style() {
        translatesAutoresizingMaskIntoConstraints = false
        
        lockImageView.translatesAutoresizingMaskIntoConstraints = false
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isSecureTextEntry = false //true
        textField.placeholder = placeHolderText
        textField.delegate = self
        textField.keyboardType = .asciiCapable
        textField.attributedPlaceholder = NSAttributedString(
            string: placeHolderText,
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel
            ]
        )
        textField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        
        eyeButton.translatesAutoresizingMaskIntoConstraints = false
        eyeButton.setImage(UIImage(systemName: "eye.circle"), for: .normal)
        eyeButton.setImage(UIImage(systemName: "eye.slash.circle"), for: .selected)
        eyeButton.addTarget(self, action: #selector(togglePasswordView), for: .touchUpInside)
        
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        dividerView.backgroundColor = UIColor.separator
        
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMessageLabel.textColor = UIColor.systemRed
        errorMessageLabel.font = .preferredFont(forTextStyle: .footnote)
        errorMessageLabel.text = "Your password must meet the requirements below"
        //errorMessageLabel.adjustsFontSizeToFitWidth = true
        //errorMessageLabel.minimumScaleFactor = 0.8
        
        errorMessageLabel.numberOfLines = 0
        errorMessageLabel.lineBreakMode = .byWordWrapping
        
        errorMessageLabel.text = "Your password must meet the requirements"
        errorMessageLabel.isHidden = true
    }
    
    func layout() {
        addSubview(lockImageView)
        addSubview(textField)
        addSubview(eyeButton)
        addSubview(dividerView)
        addSubview(errorMessageLabel)
        
        //Lock
        NSLayoutConstraint.activate([
            lockImageView.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            lockImageView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
        
        //Text field
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.leadingAnchor.constraint(equalToSystemSpacingAfter: lockImageView.trailingAnchor, multiplier: 1),
            
        ])
        
        //Eye button
        NSLayoutConstraint.activate([
            eyeButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            eyeButton.leadingAnchor.constraint(equalToSystemSpacingAfter: textField.trailingAnchor, multiplier: 1),
            eyeButton.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        
        //Divider
        NSLayoutConstraint.activate([
            dividerView.heightAnchor.constraint(equalToConstant: 1),
            dividerView.topAnchor.constraint(equalToSystemSpacingBelow: textField.bottomAnchor, multiplier: 1),
            dividerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            dividerView.trailingAnchor.constraint(equalTo: trailingAnchor)

        ])
        
        //Error message label
        NSLayoutConstraint.activate([
            errorMessageLabel.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: 4),
            errorMessageLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            errorMessageLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
                
        //CHCR
        lockImageView.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
        textField.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .horizontal)
        eyeButton.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
        
    }
}

//MARK: UITextFieldDelegate
extension PasswordTextField: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.delegate?.editingDidEnd(self)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}

extension PasswordTextField {
    @objc func togglePasswordView(_ sender: Any) {
        textField.isSecureTextEntry.toggle()
        eyeButton.isSelected.toggle()
    }
    
    @objc func textFieldEditingChanged(_ sender: UITextField) {
        delegate?.editingChanged(self)
    }
}

// MARK: - Validation
extension PasswordTextField {
    func validate() -> Bool {
        if let customValidation = customValidation,
            let customValidationResult = customValidation(text),
            customValidationResult.0 == false {
            showError(customValidationResult.1)
            return false
        }
        clearError()
        return true
    }
    
    private func showError(_ errorMessage: String) {
        errorMessageLabel.isHidden = false
        errorMessageLabel.text = errorMessage
    }

    private func clearError() {
        errorMessageLabel.isHidden = true
        errorMessageLabel.text = ""
    }
}
