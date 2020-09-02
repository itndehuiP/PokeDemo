//
//  HomeFetchingDelegate.swift
//  PokeDemo
//
//  Created by Guerson on 2020-09-02.
//  Copyright © 2020 Itandehui. All rights reserved.
//

import Foundation

protocol HomeFetchingDelegate: class {
      func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?)
      func onFetchFailed(with reason: String)
}
