//
//  UpcomingViewModel.swift
//  arctouch-challenge-ios
//
//  Created by Pedro H J Fabrino on 11/03/18.
//  Copyright © 2018 AIS Digital. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class UpcomingViewModel: BaseViewModel {
    var upcomingMovies: BehaviorRelay<[Movie]>
    var service: MovieService
    var allMovies: [Movie] = []
    
    init(movieService: MovieService = MovieService()) {
        self.service = movieService
        self.upcomingMovies = BehaviorRelay<[Movie]>(value: [])
        super.init()
    }
    
    func fetchUpcomingMovies(for page: Int) {
        service.upcoming(for: page).subscribe({ (event) in
            switch (event) {
            case .next(let movies):
                self.allMovies.append(contentsOf: movies)
                self.upcomingMovies.accept(self.allMovies)
            case .error(let error):
                print(error.localizedDescription)
            case .completed:
                print("Completed")
            }
        }).disposed(by: disposeBag)
    }
    
    func search(with query: String, with page: Int = 1) {
        service.search(with: query, and: page).subscribe({ (event) in
            switch (event) {
            case .next(let movies):
                self.upcomingMovies.accept(movies)
            case .error(let error):
                print(error.localizedDescription)
            case .completed:
                print("Completed")
            }
        }).disposed(by: disposeBag)
    }
    
    func stopSearch() {
        fetchUpcomingMovies(for: 1)
    }
}
