//
//  UpcomingMoviesViewController.swift
//  arctouch-challenge-ios
//
//  Created by Pedro H J Fabrino on 11/03/18.
//  Copyright © 2018 AIS Digital. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MoviePresenter: MovieCellPresenter {
    var movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    var imgPath: String {
        if let imgUrl = movie.posterFullPath() {
            return imgUrl
        } else if let imgUrl = movie.backdropFullPath() {
            return imgUrl
        }
        return ""
    }
    
    var title: String? {
        return movie.title
    }
    
    var releaseDate: Date? {
        return movie.releaseDate
    }
    
    var genre: String? {
        return movie.genres?.first?.name
    }
    
    var avarageNote: String? {
        if let voteAvarage = movie.voteAverage {
            return "\(voteAvarage)"
        }
        return "\(0.0)"
    }
    
}

class UpcomingMoviesViewController: BaseViewController<UpcomingViewModel>, UISearchBarDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var upcomingMoviesPage: Int = 1
    var selectedMovie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchBar.delegate = self
        self.setupCollectionView()
        self.viewModel = UpcomingViewModel()
    }
    
    private func setupCollectionView() {
        collectionView.delegate = nil
        collectionView.dataSource = nil
        collectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil),
                                forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.hidesBarsOnSwipe = true
    }
    
    func fetchMovies(for page: Int) {
        viewModel?.fetchUpcomingMovies(for: upcomingMoviesPage)
    }
    
    override func setupBindings() {
        viewModel?.upcomingMovies.bind(to: collectionView.rx.items(cellIdentifier: MovieCollectionViewCell.identifier,
                                                                   cellType: MovieCollectionViewCell.self)) {  row, model, cell in
                                                                    cell.presenter = MoviePresenter(movie: model)
                                                                    
                                                                    if row == 16 * self.upcomingMoviesPage {
                                                                        self.upcomingMoviesPage += 1
                                                                        self.fetchMovies(for: self.upcomingMoviesPage)
                                                                    }
            }
            .disposed(by: disposeBag)
        
        collectionView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            guard let selectedMovie = self?.viewModel?.upcomingMovies.value[indexPath.row] else {
                return
            }
            self?.selectedMovie = selectedMovie
            self?.performSegue(withIdentifier: "showDetails", sender: self)
        }).disposed(by: disposeBag)
        
        searchBar.rx.text
            .orEmpty
            .debounce(0.5, scheduler: MainScheduler.instance)
            .asDriver(onErrorJustReturn: "")
            .drive((viewModel?.searchText)!)
            .disposed(by: disposeBag)
        
        searchBar.rx.text.subscribe(onNext: { [unowned self](query) in
            if (query?.count)! > 0 {
                let firstIndex = IndexPath(row: 0, section: 0)
                if let _ = self.collectionView.cellForItem(at: firstIndex) {
                    self.collectionView.scrollToItem(at: firstIndex, at: .top, animated: true)
                }
            } else {
                self.upcomingMoviesPage = 1
                self.fetchMovies(for: self.upcomingMoviesPage)
            }
        }).disposed(by: disposeBag)
        
        searchBar.rx.searchButtonClicked.subscribe { (event) in
            switch (event){
            case .next(_):
                self.searchBar.resignFirstResponder()
            default:
                break
            }
        }.disposed(by: disposeBag)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" {
            (segue.destination as? MovieDetailViewController)?.movie = selectedMovie
        }
    }
}

