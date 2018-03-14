//
//  MovieDetailViewController.swift
//  arctouch-challenge-ios
//
//  Created by Pedro H J Fabrino on 11/03/18.
//  Copyright © 2018 AIS Digital. All rights reserved.
//

import UIKit

class MovieDetailViewController: BaseViewController<MovieDetailViewModel> {
    
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var lblReleaseYear: UILabel!
    @IBOutlet weak var lblGenre: UILabel!
    @IBOutlet weak var txtViewOverview: UITextView!
    
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = MovieDetailViewModel()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchDetails()
    }
    
    func fetchDetails() {
        if let movie = movie {
            self.view.showLoading()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                self.viewModel?.loadDetails(for: movie)
            })
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    override func setupBindings() {
        viewModel?.movie.asDriver().drive(onNext: { (movie) in
            self.view.stopLoading()
            self.title = movie.title
            self.lblGenre.text = movie.genres?.first?.name
            self.txtViewOverview.text = movie.overview
            
            if let path = movie.posterFullPath() {
                self.imgPoster.loadImage(urlString: path)
            }
            if let releaseDate = movie.releaseDate {
                self.lblReleaseYear.text = releaseDate.string(with: .medium)
            }
        }).disposed(by: disposeBag)
    }

}
