//
//  NavigationBarItem.swift
//  PokeDemo
//
//  Created by Guerson on 2020-09-01.
//  Copyright © 2020 Itandehui. All rights reserved.
//

import Foundation

enum NavigationBarItem {
    case logout(Selector)
    
    var isLeftButton: Bool {
        switch self {
        case .logout:
            return true
        }
    }
    
}
