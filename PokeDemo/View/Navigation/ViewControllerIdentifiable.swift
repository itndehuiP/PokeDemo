//
//  ViewControllerIdentifiable.swift
//  PokeDemo
//
//  Created by Guerson on 2020-09-01.
//  Copyright © 2020 Itandehui. All rights reserved.
//

import Foundation
import UIKit

protocol ViewControllerIdentifiable {
    func getViewController() -> UIViewController?
}
