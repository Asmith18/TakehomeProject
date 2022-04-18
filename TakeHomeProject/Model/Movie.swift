//
//  Movie.swift
//  TakeHomeProject
//
//  Created by adam smith on 4/17/22.
//

import Foundation

class Movie {
//MARK: - Keys
    enum Keys: String {
        case title = "title"
        case overview = "overview"
        case rating = "vote_average"
        case posterPath = "poster_path"
        
    
    }
    
    let title: String
    let overview: String
    let rating: Double
    let posterPath: String
    
    init?(fromDictionary dictionary: [String: Any]) {
        guard let title = dictionary[Keys.title.rawValue] as? String,
              let overview = dictionary[Keys.overview.rawValue] as? String,
              let rating = dictionary[Keys.rating.rawValue] as? Double,
              let posterPath = dictionary[Keys.posterPath.rawValue] as? String
        else { return nil }
        
        self.title = title
        self.overview = overview
        self.rating = rating
        self.posterPath = (dictionary[Keys.posterPath.rawValue] as? String) ?? ""
    }
}

