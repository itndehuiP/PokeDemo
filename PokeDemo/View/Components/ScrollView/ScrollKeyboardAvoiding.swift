//
//  ScrollKeyboardAvoiding.swift
//  PokeDemo
//
//  Created by Guerson on 2020-08-31.
//  Copyright © 2020 Itandehui. All rights reserved.
//

import UIKit

class ScrollKeyboardAvoiding: UIScrollView {

    ///This function relocate the container view, it is implemented to move it when keyboard shows up.
    func relocateSubview(in view: UIView){
        if view .isKind(of: UITextField.self) || view .isKind(of: UITextView.self) {
            self.isScrollEnabled = true
            var rect = view.bounds
            rect = view.convert(rect, to: self)
            var points:CGPoint = rect.origin
            points.x = 0
            points.y -= self.frame.size.height/2 - 80   // You can change the value by appropriate your comfortable on
            self.setContentOffset(points, animated: true)
        }
    }
}
