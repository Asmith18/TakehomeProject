//
//  MovieDetailsViewController.swift
//  TakeHomeProject
//
//  Created by adam smith on 4/17/22.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var moveTitleTextLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieOverviewTextView: UITextView!
    @IBOutlet weak var dateTextLAbel: UILabel!
    
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    func updateViews() {
        guard let movie = movie else { return }
        moveTitleTextLabel.text = movie.title
        movieOverviewTextView.text = movie.overview
        dateTextLAbel.text = movie.date
        
        MovieNetworkController.getImage(from: movie.posterPath) { image in
            DispatchQueue.main.async {
                self.movieImageView.image = image
            }
        }
    }
}
