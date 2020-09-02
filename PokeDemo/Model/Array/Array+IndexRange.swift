//
//  Array+IndexRange.swift
//  PokeDemo
//
//  Created by Guerson on 2020-09-01.
//  Copyright © 2020 Itandehui. All rights reserved.
//

import Foundation

extension Array {
    func isInRange(with index: Int?) -> Bool {
        guard let index = index else { return false }
        return index >= 0 && index < self.count
    }
}
