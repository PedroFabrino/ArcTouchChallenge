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
    
    func upcomingMovies(for page: Int) -> Observable<[Movie]> {
        return Observable.of(upcoming(for: 1).map { $0 as AnyObject }, availableGenres().map { $0 as AnyObject })
            .merge()
            .asObservable()
            .toArray().map({ (result) -> [Movie] in
                if let movies = result[0] as? [Movie],
                    let genres = result[1] as? [Genre] {
                    let genresDict = genres.reduce(into: [Int: Genre](), { (dict, genre) in
                        if let id = genre.id{
                            dict[id] = genre
                        }
                    })
                    for movie in movies {
                        var fullGenres : [Genre] = []
                        if let genreIds = movie.genreIds {
                            for id in genreIds {
                                if let genre = genresDict[id] {
                                    fullGenres.append(genre)
                                }
                            }
                        }
                        movie.genres = fullGenres
                    }
                    return movies
                }
                return []
            }).asObservable()
    }
    
    
    func upcoming(for page: Int) -> Observable<[Movie]> {
        return provider.rx.request(.upcoming(page: page, language: Locale.preferredLanguages.first ?? "", region: "")).map { (response) -> [Movie] in
            if let json = try? response.mapJSON() as? [String: Any],
                let movieJSON = json?["results"] as? [[String: Any]]{
                return Mapper<Movie>().mapArray(JSONArray: movieJSON)
            }
            return []
        }.asObservable()
    }
    
    func details(for movieId: Int) -> Observable<Movie> {
        return provider.rx.request(.details(movieId: movieId, language: Locale.preferredLanguages.first ?? "")).mapObject(Movie.self, context: nil).asObservable()
    }

    func availableGenres() -> Observable<[Genre]> {
        return provider.rx.request(.availableGenres(language: Locale.preferredLanguages.first ?? "")).map({ (response) -> [Genre] in
            do {
                if let json = try response.mapJSON() as? [String: Any],
                let genresJson = json["genres"] as? [[String: Any]]{
                    return Mapper<Genre>().mapArray(JSONArray: genresJson)
                }
            } catch {
                
            }
            return []
        }).asObservable()
    }
    
    func search(with query: String, and page: Int) -> Observable<[Movie]> {
        return provider.rx.request(.search(query: query, page: page, language: Locale.preferredLanguages.first ?? "")).map { (response) -> [Movie] in
            if let json = try? response.mapJSON() as? [String: Any],
                let movieJSON = json?["results"] as? [[String: Any]]{
                return Mapper<Movie>().mapArray(JSONArray: movieJSON)
            }
            return []
        }.asObservable()
    }
}

