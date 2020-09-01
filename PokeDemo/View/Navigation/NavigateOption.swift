//
//  NavigateOption.swift
//  PokeDemo
//
//  Created by Guerson on 2020-09-01.
//  Copyright © 2020 Itandehui. All rights reserved.
//

import Foundation
import UIKit

enum NavigateOption {
    case login
    case home
}

extension NavigateOption: StoryboardIdentifiable {
    func getStoryboardName() -> String {
        switch self {
        case .login:
            return "Login"
        case .home:
            return "Home"
        }
    }
}


extension NavigateOption: ViewControllerIdentifiable {
    func getViewController() -> UIViewController? {
        let storyBoard = UIStoryboard(name: self.getStoryboardName(), bundle: nil)
        return storyBoard.instantiateInitialViewController()
    }
}
