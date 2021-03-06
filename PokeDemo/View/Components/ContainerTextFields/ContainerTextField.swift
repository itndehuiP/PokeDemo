//
//  CheckContainerTextField.swift
//  PokeDemo
//
//  Created by Guerson on 2020-08-31.
//  Copyright © 2020 Itandehui. All rights reserved.
//

import UIKit

@IBDesignable
class ContainerTextField: UIView, NibLoadable {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var textField: UITextField!
    @IBOutlet weak var leftButton: UIButton!
    
    private var returnAction: action = nil
    private var viewModel = ContainerTextFieldViewModel()
    
    weak var delegate: ContainerTextFieldDelegate?
    
    override init(frame: CGRect) { //For integration by code
    super.init(frame: frame)
        setupFromNib()
        specifiInit()
    }

    required init?(coder: NSCoder) { //For integration by IBOutlet
        super.init(coder: coder)
        setupFromNib()
        specifiInit()
    }

    private func specifiInit(){
        containerView.layer.cornerRadius = 10.0
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.primary?.cgColor
        textField.font = UIFont.preferredFont(forTextStyle: .body)

    }
    
    func set(with style: TextFieldStyle, action: action) {
        viewModel.textFieldStyle = style
        textField.placeholder = viewModel.textFieldStyle.placeholder
        leftButton.tintColor = UIColor.secondary
        leftButton.setImage(UIImage(asset: viewModel.textFieldStyle.selectedImageButton), for: .normal)
        leftButton.isUserInteractionEnabled = viewModel.textFieldStyle.buttonEnabled
        textField.isSecureTextEntry = viewModel.textFieldStyle.isSecure
        textField.keyboardType = viewModel.textFieldStyle.keyBoardType
        setButtonInteraction()
        leftButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        textField.returnKeyType = viewModel.textFieldStyle.returnKeyType
        self.returnAction = action
    }

    @IBAction func textFieldDidChange(_ sender: Any) {
        let text = textField.text
        let isValid = viewModel.checkValidation(with: text)
        
        switch viewModel.textFieldStyle {
        case .email:
            leftButton.tintColor = isValid ? UIColor.primary : .gray
        default:
            break
        }
        
        delegate?.textFieldValidate(type: viewModel.textFieldStyle, text: text, valid: isValid)
    }
    
    private func setButtonInteraction() {
        switch viewModel.textFieldStyle {
        case .email:
            leftButton.isUserInteractionEnabled = false
            leftButton.tintColor = .gray
        case .password:
            return
        }
    }
    
    @objc private func buttonAction() {
        switch viewModel.textFieldStyle {
        case .password:
            toogleSecurityText()
        default:
            return
        }
    }

    private func toogleSecurityText(){
        let isSecure = textField.isSecureTextEntry
        textField.isSecureTextEntry = !isSecure
        let image = !isSecure ? viewModel.textFieldStyle.selectedImageButton : ImageAsset.eyeClose
        leftButton.setImage(UIImage(asset: image), for: .normal)
    }
    
    func callBecomeFirstResponder() {
        textField.becomeFirstResponder()
    }
    
    func callResignFirstResponder() {
        textField.resignFirstResponder()
    }
    
}



extension ContainerTextField: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let action = returnAction {
            action()
        }
        return true
    }
}

