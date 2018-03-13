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
    private(set) var upcomingMovies: BehaviorRelay<[Movie]>
    private(set) var searchText: BehaviorRelay<String?>
    
    var service: MovieService
    
    var allMovies: [Movie] = []
    
    init(movieService: MovieService = MovieService()) {
        self.service = movieService
        self.upcomingMovies = BehaviorRelay<[Movie]>(value: [])
        self.searchText = BehaviorRelay<String?>(value: nil)
        super.init()
        
        self.setupSearchEvent()
    }
    
    func fetchUpcomingMovies(for page: Int) {
        print("Fetching page: \(page)")
        service.upcoming(for: page).subscribe({ (event) in
            switch (event) {
            case .next(let movies):
                self.allMovies.append(contentsOf: movies)
                self.upcomingMovies.accept(self.allMovies)
            case .error(let error):
                Log.error("Error: \(error.localizedDescription)")
            case .completed:
                Log.verbose("Completed")
            }
        }).disposed(by: disposeBag)
    }
    
    func search(with query: String, with page: Int = 1) {
        service.search(with: query, and: page).subscribe({ (event) in
            switch (event) {
            case .next(let movies):
                if movies.count > 0 {
                    self.upcomingMovies.accept(movies)
                }
            case .error(let error):
                Log.error("Error: \(error.localizedDescription)")
            case .completed:
                Log.verbose("Completed")
            }
        }).disposed(by: disposeBag)
    }
    
    func setupSearchEvent() {
        searchText.subscribe { (event) in
            switch (event) {
            case .next(let query):
                if let query = query,
                    query.count > 0{
                    self.search(with: query)
                }
            case .error(let error):
                Log.error("Error: \(error.localizedDescription)")
            case .completed:
                Log.verbose("Completed")
            }
        }.disposed(by: disposeBag)
    }
}
