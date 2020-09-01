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
    
    func set(with style: TextFieldStyle) {
        viewModel.textFieldStyle = style
        textField.placeholder = viewModel.textFieldStyle.placeholder
        leftButton.tintColor = UIColor.constrast
        leftButton.setImage(UIImage(asset: viewModel.textFieldStyle.selectedImageButton), for: .selected)
        textField.isSecureTextEntry = style.isSecure
        textField.keyboardType = style.keyBoardType
    }

    @IBAction func textFieldDidChange(_ sender: Any) {
        let text = textField.text
        delegate?.textFieldValidate(type: viewModel.textFieldStyle, text: text, valid: viewModel.checkValidation(with: text))
    }
    
}



extension ContainerTextField: UITextFieldDelegate {
    
}

