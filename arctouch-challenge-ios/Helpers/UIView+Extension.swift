//
//  UIView+Extension.swift
//  arctouch-challenge-ios
//
//  Created by Pedro H J Fabrino on 14/03/18.
//  Copyright © 2018 AIS Digital. All rights reserved.
//

import UIKit
import RSLoadingView

extension UIView {
    func showLoading() {
        RSLoadingView(effectType: .spinAlone).show(on: self)
    }
    
    func stopLoading() {
        RSLoadingView.hide(from: self)
    }
}
