//
//  MovieServiceTEsts.swift
//  arctouch-challenge-iosTests
//
//  Created by Pedro H J Fabrino on 14/03/18.
//  Copyright © 2018 AIS Digital. All rights reserved.
//

import XCTest
@testable import arctouch_challenge_ios
import Moya
import RxSwift
import RxCocoa

class MovieServiceTests: XCTestCase {
    
    var service: MovieService?
    var disposeBag: DisposeBag = DisposeBag()
    
    override func setUp() {
        super.setUp()
        service = MovieService(MoyaProvider<MovieProvider>(stubClosure: MoyaProvider.immediatelyStub))
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testListUpcomingMoviesWithGenres() {
        let expectation = XCTestExpectation(description: "expect to load upcoming movies list")
        service?.upcomingMovies(for: 1).subscribe({ (event) in
            switch event {
            case .next(let movies):
                XCTAssert(!movies.isEmpty, "movies are empty")
                XCTAssert(!(movies.first?.genres?.isEmpty)!, "genres are empty")
            case .error(let error):
                XCTFail("movies service list error \(error)")
            case .completed:
                expectation.fulfill()
            }
        }).disposed(by: disposeBag)
        wait(for: [expectation], timeout: 3)
    }
    
    func testUpcomingMovies() {
        let expectation = XCTestExpectation(description: "expect to load upcoming movies list")
        service?.upcoming(for: 1).subscribe({ (event) in
            switch event {
            case .next(let movies):
                XCTAssert(!movies.isEmpty, "movies are empty")
                XCTAssert(movies.first?.genres == nil, "genres are not empty")
            case .error(let error):
                XCTFail("movies service list error \(error)")
            case .completed:
                expectation.fulfill()
            }
        }).disposed(by: disposeBag)
        wait(for: [expectation], timeout: 3)
    }
    
    func testAvailableGenres() {
        let expectation = XCTestExpectation(description: "expect to load upcoming movies list")
        service?.availableGenres().subscribe({ (event) in
            switch event {
            case .next(let genres):
                XCTAssert(!genres.isEmpty, "genres are empty")
            case .error(let error):
                XCTFail("genre list service error \(error)")
            case .completed:
                expectation.fulfill()
            }
        }).disposed(by: disposeBag)
        wait(for: [expectation], timeout: 3)
    }
    
    func testMovieDetails() {
        let expectation = XCTestExpectation(description: "expect to load movie details")
        
        service?.upcomingMovies(for: 1).subscribe({ (event) in
            switch event {
            case .next(let movies):
                if let id = movies.first?.id {
                    _ = self.service?.details(for: id).subscribe({ (event) in
                        switch event {
                        case .next(let detailedMovie):
                            XCTAssert(detailedMovie.id != nil, "movie.id is empty")
                            XCTAssert(detailedMovie.overview != nil, "movie.overview is empty")
                            XCTAssert(detailedMovie.title != nil, "movie.title is empty")
                        case .error(let error):
                            XCTFail("movies details service error \(error)")
                        case .completed:
                            expectation.fulfill()
                        }
                    })
                } else {
                    XCTAssert(movies.first?.id != nil, "movie.id is empty")
                }
            case .error(let error):
                XCTFail("movies details service error \(error)")
            case .completed:
                expectation.fulfill()
            }
        }).disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 3)
    }
    
    func testMoviesSearch() {
        let expectation = XCTestExpectation(description: "expect to load upcoming movies list")
        
        let query = "Star Wars"
        
        service?.search(with: query, and: 1).subscribe({ (event) in
            switch event {
            case .next(let movies):
                if let movieTitle = movies.first?.title {
                    XCTAssert(movieTitle.contains(query))
                }
            case .error(let error):
                XCTFail("movies details service error \(error)")
            case .completed:
                expectation.fulfill()
            }
        }).disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 3)
    }
}

