//
//  UpcomingMoviesViewController.swift
//  arctouch-challenge-ios
//
//  Created by Pedro H J Fabrino on 11/03/18.
//  Copyright © 2018 AIS Digital. All rights reserved.
//

import UIKit
import RxSwift

class UpcomingMoviesViewController: BaseViewController<UpcomingViewModel>, UIViewControllerPreviewingDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var upcomingMoviesPage: Int = 0
    var upcomingMoviesSearchPage: Int = 0
    var selectedMovie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if traitCollection.forceTouchCapability == .available {
            registerForPreviewing(with: self, sourceView: view)
        }
        
        searchBar.delegate = self
        
        self.setupCollectionView()
        self.viewModel = UpcomingViewModel()
        
        fetchMovies()
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
    
    func fetchMovies() {
        upcomingMoviesPage += 1
        viewModel?.fetchUpcomingMovies(for: upcomingMoviesPage)
    }
    
    func searchMovies(with query: String) {
        collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        if query.count > 0 {
            viewModel?.search(with: query)
        } else {
            viewModel?.stopSearch()
        }
    }
    
    override func setupBindings() {
        viewModel?.upcomingMovies.bind(to: collectionView.rx.items(cellIdentifier: MovieCollectionViewCell.identifier,
                                                                   cellType: MovieCollectionViewCell.self)) {  row, model, cell in
                                                                    if let imgUrl = model.posterFullPath() {
                                                                        cell.imgPoster.loadImage(urlString: imgUrl)
                                                                    } else if let imgUrl = model.backdropFullPath() {
                                                                        cell.imgPoster.loadImage(urlString: imgUrl)
                                                                    }
                                                                    if let title = model.title {
                                                                        cell.lblName.text = title
                                                                    }
                                                                    if let releaseDate = model.prettyReleaseDate() {
                                                                        cell.lblYear.text = releaseDate
                                                                    }
                                                                    if let voteAvarage = model.voteAverage {
                                                                        cell.lblAvarageNote.text = "\(voteAvarage)"
                                                                    }
                                                                    if let genreName = model.genres?.first?.name {
                                                                        cell.lblGenre.text = genreName
                                                                    }
                                                                    
                                                                    if row == 16 * self.upcomingMoviesPage {
                                                                        self.fetchMovies()
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
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" {
            (segue.destination as? MovieDetailViewController)?.movie = selectedMovie
        }
    }

    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        guard let indexPath = collectionView.indexPathForItem(at: collectionView.convert(location, from: view)), let cell = collectionView.cellForItem(at: indexPath) else {
            return nil
        }
        
        let detailViewController = storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController

        detailViewController.preferredContentSize = CGSize(width: 0, height: 360)
        previewingContext.sourceRect = collectionView.convert(cell.frame, to: collectionView.superview!)
        return detailViewController
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        func previewingContext(previewingContext: UIViewControllerPreviewing, commitViewController viewControllerToCommit: UIViewController) {
            let navigationController = UINavigationController(rootViewController: viewControllerToCommit)
            show(navigationController, sender: self)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let query = searchBar.text {
            searchMovies(with: query)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchMovies(with: searchText)
    }
}

