//
//  BaseProvider.swift
//  arctouch-challenge-ios
//
//  Created by Pedro H J Fabrino on 10/03/18.
//  Copyright © 2018 AIS Digital. All rights reserved.
//

import UIKit

class KeyProvider: NSObject {
    static func get(_ variable: String) -> [String : String] {
        if let url = Bundle.main.url(forResource: "Variables", withExtension: "plist"),
            let values = NSDictionary(contentsOf: url) as? [String : [String:String]] {
            return values[variable] ?? [:]
        }
        return [:]
    }
    static func getTMDb(_ variable: String) -> String {
        return get("TMDb")[variable] ?? ""
    }
}
