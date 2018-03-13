//
//  Collection.swift
//  arctouch-challenge-ios
//
//  Created by Pedro H J Fabrino on 10/03/18.
//  Copyright © 2018 AIS Digital. All rights reserved.
//

import UIKit
import ObjectMapper

class Collection : Mappable {
    var backdropPath : String?
    var id : Int?
    var name : String?
    var posterPath : String?
    
    class func newInstance(map: Map) -> Mappable?{
        return Collection()
    }
    required init?(map: Map){}
    init(){}
    
    func mapping(map: Map)
    {
        backdropPath <- map["backdrop_path"]
        id <- map["id"]
        name <- map["name"]
        posterPath <- map["poster_path"]
    }
}
