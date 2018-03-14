//
//  Genre.swift
//  arctouch-challenge-ios
//
//  Created by Pedro H J Fabrino on 10/03/18.
//  Copyright © 2018 AIS Digital. All rights reserved.
//
import Foundation
import ObjectMapper

class Genre: Mappable {
    var id: Int?
    var name: String?
    
    required init?(map: Map) {}
    init() {}
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
    }
}
