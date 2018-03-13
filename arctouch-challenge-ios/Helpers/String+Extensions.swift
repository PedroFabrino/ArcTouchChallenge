//
//  String+Extensions.swift
//  arctouch-challenge-ios
//
//  Created by Pedro H J Fabrino on 12/03/18.
//  Copyright © 2018 AIS Digital. All rights reserved.
//

import UIKit

extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
