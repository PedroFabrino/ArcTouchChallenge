//
//  String+Extensions.swift
//  BMWChallenge
//
//  Created by Pedro H J Fabrino on 07/02/18.
//  Copyright © 2018 Pedro H J Fabrino. All rights reserved.
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
