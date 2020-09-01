//
//  Navigable.swift
//  PokeDemo
//
//  Created by Guerson on 2020-09-01.
//  Copyright © 2020 Itandehui. All rights reserved.
//

import Foundation
import UIKit

protocol Navigable {
    func push(vc: NavigateOption)
    func setRoot(vc: NavigateOption)
}

extension Navigable where Self: UINavigationController {
    func push(vc: NavigateOption) {
        if let vc = vc.getViewController() {
            self.pushViewController(vc, animated: true)
        }
    }
    
    func setRoot(vc: NavigateOption) {
        switch vc {
        case .login:
            navigationBar.isHidden = true
        default:
            navigationBar.isHidden = false
        }
        if let vc = vc.getViewController() {
            self.viewControllers = [vc]
        }
    }
}
