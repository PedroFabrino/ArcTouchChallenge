//
//  ProductionCompany.swift
//  arctouch-challenge-ios
//
//  Created by Pedro H J Fabrino on 10/03/18.
//  Copyright © 2018 AIS Digital. All rights reserved.
//

import Foundation
import ObjectMapper

class ProductionCompany: Mappable {
    
    var id: Int?
    var logoPath: String?
    var name: String?
    var originCountry: String?
    
    required init?(map: Map) {}
    init() {}
    
    func mapping(map: Map) {
        id <- map["id"]
        logoPath <- map["logo_path"]
        name <- map["name"]
        originCountry <- map["origin_country"]
    }
}
