//
//  ProductionCountry.swift
//  arctouch-challenge-ios
//
//  Created by Pedro H J Fabrino on 10/03/18.
//  Copyright © 2018 AIS Digital. All rights reserved.
//

import Foundation
import ObjectMapper

class ProductionCountry: Mappable {
    
    var iso31661: String?
    var name: String?
    
    required init?(map: Map) {}
    init() {}
    
    func mapping(map: Map) {
        iso31661 <- map["iso_3166_1"]
        name <- map["name"]
    }
}
