//
//  ViewModelType.swift
//  arctouch-challenge-ios
//
//  Created by Pedro H J Fabrino on 10/03/18.
//  Copyright © 2018 AIS Digital. All rights reserved.
//

import Foundation

protocol ViewModelType: class {
    func reloadView()
    func showHUD()
    func hideHUD()
}
