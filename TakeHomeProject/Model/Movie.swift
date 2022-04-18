//
//  Movie.swift
//  TakeHomeProject
//
//  Created by adam smith on 4/17/22.
//

import Foundation

struct Movie {
    var results: [MovieResults]
}

struct MovieResults {
    private enum Keys: String {
        case title = "title"
        case overview = "overview"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
    }
    
    var title: String
    var overview: String
    var releaseDate: String
    var voteAverage: Double
    var posterPath: String
}
