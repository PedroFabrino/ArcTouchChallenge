//
//  MoviesService.swift
//  arctouch-challenge-ios
//
//  Created by Pedro H J Fabrino on 10/03/18.
//  Copyright © 2018 AIS Digital. All rights reserved.
//

import Moya
import ObjectMapper
import Moya_ObjectMapper
import RxSwift

class MovieService {
    let provider: MoyaProvider<MovieProvider>
    
    init(_ provider: MoyaProvider<MovieProvider> = MoyaProvider<MovieProvider>()) {
        self.provider = provider
    }
    
    func upcoming(for page: Int) -> Observable<[Movie]> {
        return provider.rx.request(.upcoming(page: page, language: Locale.preferredLanguages.first ?? "", region: "")).map { (response) -> [Movie] in
            if let json = try? response.mapJSON() as? [String: Any],
                let movieJSON = json?["results"] as? [[String: Any]]{
                return Mapper<Movie>().mapArray(JSONArray: movieJSON)
            }
            print("Failed to MAP json")
            return []
        }.asObservable()
    }
    
    func details(for movieId: Int) -> Observable<Movie> {
        return provider.rx.request(.details(movieId: movieId, language: Locale.preferredLanguages.first ?? "")).mapObject(Movie.self, context: nil).asObservable()
    }

    func availableGenres() -> Observable<[Genre]> {
        return provider.rx.request(.availableGenres(language: Locale.preferredLanguages.first ?? "")).map(Array<Genre>.self).asObservable()
    }
    
    func search(with query: String, and page: Int) -> Observable<[Movie]> {
        return provider.rx.request(.search(query: query, page: page, language: Locale.preferredLanguages.first ?? "")).map { (response) -> [Movie] in
            if let json = try? response.mapJSON() as? [String: Any],
                let movieJSON = json?["results"] as? [[String: Any]]{
                return Mapper<Movie>().mapArray(JSONArray: movieJSON)
            }
            print("Failed to MAP json")
            return []
        }.asObservable()
    }
}

