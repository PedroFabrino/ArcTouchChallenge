//
//  Date+Extension.swift
//  arctouch-challenge-ios
//
//  Created by Pedro H J Fabrino on 12/03/18.
//  Copyright © 2018 AIS Digital. All rights reserved.
//

import UIKit

extension Date {
    var year: Int {
        return Calendar.current.component(.year, from: self)
    }
}
