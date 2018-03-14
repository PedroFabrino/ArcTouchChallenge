//
//  Movie.swift
//  arctouch-challenge-ios
//
//  Created by Pedro H J Fabrino on 10/03/18.
//  Copyright © 2018 AIS Digital. All rights reserved.
//

import Foundation
import ObjectMapper

class Movie: Mappable {
    
    var adult: Bool?
    var backdropPath: String?
    var belongsToCollection: Collection?
    var budget: Int?
    var genreIds: [Int]?
    var genres: [Genre]?
    var homepage: AnyObject?
    var id: Int?
    var imdbId: String?
    var originalLanguage: String?
    var originalTitle: String?
    var overview: String?
    var popularity: Float?
    var posterPath: String?
    var productionCompanies: [ProductionCompany]?
    var productionCountries: [ProductionCountry]?
    var releaseDate: Date?
    var revenue: Int?
    var runtime: Int?
    var spokenLanguages: [SpokenLanguage]?
    var status: String?
    var tagline: String?
    var title: String?
    var video: Bool?
    var voteAverage: Float?
    var voteCount: Int?
    
    init() {}
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        adult <- map["adult"]
        backdropPath <- map["backdrop_path"]
        belongsToCollection <- map["belongs_to_collection"]
        budget <- map["budget"]
        genreIds <- map["genre_ids"]
        genres <- map["genres"]
        homepage <- map["homepage"]
        id <- map["id"]
        imdbId <- map["imdb_id"]
        originalLanguage <- map["original_language"]
        originalTitle <- map["original_title"]
        overview <- map["overview"]
        popularity <- map["popularity"]
        posterPath <- map["poster_path"]
        productionCompanies <- map["production_companies"]
        productionCountries <- map["production_countries"]
        releaseDate <- (map["release_date"], DateFormatterTransform(dateFormatter: dateFormatter))
        revenue <- map["revenue"]
        runtime <- map["runtime"]
        spokenLanguages <- map["spoken_languages"]
        status <- map["status"]
        tagline <- map["tagline"]
        title <- map["title"]
        video <- map["video"]
        voteAverage <- map["vote_average"]
        voteCount <- map["vote_count"]
    }
    
    func posterFullPath(for width: Int = 500) -> String? {
        if let path = self.posterPath {
            return "https://image.tmdb.org/t/p/w\(width)" + path
        }
        return nil
    }
    
    func backdropFullPath(for width: Int = 500) -> String? {
        if let path = self.backdropPath {
            return "https://image.tmdb.org/t/p/w\(width)" + path
        }
        return nil
    }
}
