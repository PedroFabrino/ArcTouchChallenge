//
//  MovieCollectionViewCell.swift
//  arctouch-challenge-ios
//
//  Created by Pedro H J Fabrino on 11/03/18.
//  Copyright © 2018 AIS Digital. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "MovieCollectionViewCell"
    
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblYear: UILabel!
    @IBOutlet weak var lblGenre: UILabel!
    @IBOutlet weak var lblAvarageNote: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
