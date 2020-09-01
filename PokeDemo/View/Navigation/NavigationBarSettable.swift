//
//  NavigationBarSettable.swift
//  PokeDemo
//
//  Created by Guerson on 2020-09-01.
//  Copyright © 2020 Itandehui. All rights reserved.
//

import Foundation
import UIKit

protocol NavigationBarSettable: NSObjectProtocol {
    func setNavigationBar(with items: [NavigationBarItem]?)
}

extension NavigationBarSettable where Self: UINavigationController {
    func setNavigationBar(with items: [NavigationBarItem]?){
        guard let items = getItemsBySide(with: items), let vc = self.viewControllers.last else { return }
        
        var leftButtons: [UIBarButtonItem] = []
        for item in items.left ?? [] {
            leftButtons.append(getBarButton(with: item, vc: vc))
        }
    
        var rightButtons: [UIBarButtonItem] = []
        for item in items.right ?? [] {
            rightButtons.append(getBarButton(with: item, vc: vc))
        }
        
        vc.navigationItem.leftBarButtonItems = leftButtons
        vc.navigationItem.rightBarButtonItems = rightButtons
    }
    
    private func getBarButton(with item: NavigationBarItem, vc: UIViewController) -> UIBarButtonItem {
        let button = getDefaultButton()
        switch item {
        case .logout(let selector):
            button.setImage(UIImage(asset: .user), for: .normal)
            button.tintColor = UIColor.primary
            button.addTarget(vc, action: selector, for: .touchUpInside)
            return UIBarButtonItem(customView: button)
        }
    }

    private func getItemsBySide(with items: [NavigationBarItem]?) -> (left: [NavigationBarItem]?, right: [NavigationBarItem]?)? {
        guard let items = items else { return nil }
        var leftItems: [NavigationBarItem] = []
        var rightItems: [NavigationBarItem] = []
        
        for item in items {
            if item.isLeftButton {
                leftItems.append(item)
            } else {
                rightItems.append(item)
            }
        }
        return (!leftItems.isEmpty ? leftItems : nil, !rightItems.isEmpty ? rightItems : nil)
    }
    
    private func getDefaultButton() -> UIButton {
        let size = CGSize(width: 30, height: 30)
        return UIButton(frame: CGRect(origin: CGPoint.zero, size: size))
    }
}
