//
//  MovieCollectionViewCell.swift
//  arctouch-challenge-ios
//
//  Created by Pedro H J Fabrino on 11/03/18.
//  Copyright © 2018 AIS Digital. All rights reserved.
//

import UIKit

protocol MovieCellPresenter {
    var imgPath: String { get }
    var title: String? { get }
    var releaseDate: Date? { get }
    var genre: String? { get }
    var avarageNote: String? { get }
}

class MovieCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "MovieCollectionViewCell"
    
    var presenter: MoviePresenter? {
        didSet {
            customize()
        }
    }
    
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblYear: UILabel!
    @IBOutlet weak var lblGenre: UILabel!
    @IBOutlet weak var lblAvarageNote: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func customize() {
        guard let presenter = presenter else {
            return
        }
        imgPoster.loadImage(urlString: presenter.imgPath, placeholder: #imageLiteral(resourceName: "posterBlank"), showActivityIndicator: true)
        lblName.text = presenter.title
        if let date = presenter.releaseDate {
            lblYear.text = date.string(with: .medium)
        }
        lblGenre.text = presenter.genre
        lblAvarageNote.text = presenter.avarageNote
    }

}
