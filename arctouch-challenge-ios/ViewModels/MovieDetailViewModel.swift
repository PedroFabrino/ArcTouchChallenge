//
//  MovieDetailViewModel.swift
//  arctouch-challenge-ios
//
//  Created by Pedro H J Fabrino on 11/03/18.
//  Copyright © 2018 AIS Digital. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MovieDetailViewModel: BaseViewModel {
    
    var movie: BehaviorRelay<Movie>
    var service: MovieService
    
    init(movieService: MovieService = MovieService()) {
        self.service = movieService
        self.movie = BehaviorRelay<Movie>(value: Movie())
        super.init()
    }
    
    func loadDetails(for movie: Movie) {
        guard let id = movie.id else {
            return
        }
        _ = service.details(for: id).subscribe({ (event) in
            switch (event) {
            case .next(let detailedMovie):
                self.movie.accept(detailedMovie)
            case .error(let error):
                print(error)
            case .completed:
                print("Completed")
            }
        })
    }
}
