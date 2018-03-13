//
//  SpokenLanguage.swift
//  arctouch-challenge-ios
//
//  Created by Pedro H J Fabrino on 10/03/18.
//  Copyright © 2018 AIS Digital. All rights reserved.
//
import Foundation
import ObjectMapper

class SpokenLanguage : Mappable{
    
    var iso6391 : String?
    var name : String?
    
    class func newInstance(map: Map) -> Mappable?{
        return SpokenLanguage()
    }
    required init?(map: Map){}
    init(){}
    
    func mapping(map: Map)
    {
        iso6391 <- map["iso_639_1"]
        name <- map["name"]
    }    
}
