//
//  MovieTableViewCell.swift
//  TakeHomeProject
//
//  Created by adam smith on 4/17/22.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
//MARK: - Outlets
    @IBOutlet weak var movieNameTextLabel: UILabel!
    @IBOutlet weak var ratingTextLabel: UILabel!
    
    
    func updateViews(movie: Movie) {
        self.movieNameTextLabel.text = movie.title
        ratingTextLabel.text = "\(movie.rating)"
    }
}
