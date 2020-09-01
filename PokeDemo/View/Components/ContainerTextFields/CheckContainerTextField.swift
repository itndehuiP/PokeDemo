//
//  CheckContainerTextField.swift
//  PokeDemo
//
//  Created by Guerson on 2020-08-31.
//  Copyright © 2020 Itandehui. All rights reserved.
//

import UIKit

@IBDesignable
class CheckContainerTextField: UIView, NibLoadable {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var checkImage: UIImageView!

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
        containerView.layer.cornerRadius = 5.0
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.primary?.cgColor
    }
}



extension CheckContainerTextField: UITextFieldDelegate {
    
}
