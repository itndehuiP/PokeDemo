//
//  NavigationCoordinator.swift
//  PokeDemo
//
//  Created by Guerson on 2020-09-01.
//  Copyright © 2020 Itandehui. All rights reserved.
//

import UIKit

class NavigationCoordinator: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setInitial()
        navigationBar.tintColor = UIColor.primary
        self.interactivePopGestureRecognizer?.delegate = nil

    }
    
    private func setInitial() {
        if KeychainWrapper.standard.string(forKey: SystemConstant.sessionToken.rawValue) != nil {
            self.setRoot(vc: .home)
        } else {
            self.setRoot(vc: .login)
        }
    }

}
