//
//  CheckContainerTextField.swift
//  PokeDemo
//
//  Created by Guerson on 2020-08-31.
//  Copyright © 2020 Itandehui. All rights reserved.
//

import UIKit

class CheckContainerTextField: UIView {

    @IBOutlet private var textField: UITextField!
    @IBOutlet private var checkImage: UIImageView!
    
    override init(frame: CGRect) { //For integration by code
         super.init(frame: frame)
         specifiInit()
     }
     
     required init?(coder: NSCoder) { //For integration by IBOutlet
         super.init(coder: coder)
         specifiInit()
     }

     private func specifiInit(){
        //init the view's elements
     }
    
}


extension CheckContainerTextField: UITextFieldDelegate {
    
}
