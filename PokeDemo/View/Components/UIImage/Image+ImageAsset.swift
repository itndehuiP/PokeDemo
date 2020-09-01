//
//  Image+ImageAsset.swift
//  PokeDemo
//
//  Created by Guerson on 2020-08-31.
//  Copyright © 2020 Itandehui. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    convenience init?(asset: ImageAsset) {
        self.init(named: asset.rawValue)
    }
}
