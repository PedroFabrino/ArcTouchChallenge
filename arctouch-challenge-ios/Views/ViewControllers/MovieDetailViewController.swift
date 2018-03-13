//
//  MovieDetailViewController.swift
//  arctouch-challenge-ios
//
//  Created by Pedro H J Fabrino on 11/03/18.
//  Copyright © 2018 AIS Digital. All rights reserved.
//

import UIKit
import SkeletonView

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
    
    func showSkeleton() {
        let gradient = SkeletonGradient(baseColor: UIColor.asbestos)
        let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .leftRight)
        view.showAnimatedGradientSkeleton(usingGradient: gradient, animation: animation)
    }
    
    func fetchDetails() {
        if let movie = movie {
            showSkeleton()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                self.viewModel?.loadDetails(for: movie)
            })
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    override func setupBindings() {
        viewModel?.movie.asDriver().drive(onNext: { (movie) in
            self.view.hideSkeleton()
            
            self.title = movie.title
            
            if let releaseYear = movie.prettyReleaseDate() {
                self.lblReleaseYear.text = releaseYear
            }
            if let genreName = movie.genres?.first?.name {
                self.lblGenre.text = genreName
            }
            if let overview = movie.overview {
                self.txtViewOverview.text = overview
            }
            if let path = movie.posterFullPath() {
                self.imgPoster.loadImage(urlString: path)
            }
        }).disposed(by: disposeBag)
    }

}
