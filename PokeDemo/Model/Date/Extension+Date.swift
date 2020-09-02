//
//  Extension+Date.swift
//  PokeDemo
//
//  Created by Guerson on 2020-09-02.
//  Copyright © 2020 Itandehui. All rights reserved.
//

import Foundation

extension Date {
    func secondsInterval(from date: Date?) -> Int? {
        guard let date = date else { return nil }
        let calendar = Calendar.current
        let components = calendar.dateComponents([.second], from: self, to: date)
        return components.second
    }
}
