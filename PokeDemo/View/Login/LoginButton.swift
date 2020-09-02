//
//  LoginButton.swift
//  PokeDemo
//
//  Created by Guerson on 2020-09-01.
//  Copyright © 2020 Itandehui. All rights reserved.
//

import UIKit

@IBDesignable
class LoginButton: UIView, NibLoadable {

    @IBOutlet weak var button: UIButton!
    weak var delegate: LoginButtonDelegate?
    
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
        button.tintColor = UIColor.constrast
        button.setTitle("Go", for: .normal)
        button.backgroundColor = UIColor.primary
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        button.isEnabled = false
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
    func set(toEnable: Bool) {
        button.isEnabled = toEnable
    }
    
    @objc private func buttonAction() {
        delegate?.onButtonTapped()
    }
    

    
}
