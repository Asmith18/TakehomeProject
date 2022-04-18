//
//  MovieSearchNetworkController.swift
//  TakeHomeProject
//
//  Created by adam smith on 4/17/22.
//

import Foundation
import UIKit.UIImage

class MovieNetworkController {
    
    enum baseURLString: String {
        case search = "https://api.themoviedb.org/3/"
        case image = "https://image.tmdb.org"
    }
    
    static func fetchMoviesWith(name searchTerm: String, completion: @escaping ([Movie]?) -> Void) {
        
        guard let url = URL(string: baseURLString.search.rawValue) else {
            print("filed to get url from: \(self.baseURLString)")
            completion(nil)
            return
        }
        var urlComponent = URLComponents(url: url, resolvingAgainstBaseURL: true)
        urlComponent?.path = "/3/search/movie"
        
        let apiKey = URLQueryItem(name: "api_key", value: "be35af15dc34f6c18ecb1b03e2fd3559")
        let searchTerm = URLQueryItem(name: "query", value: searchTerm)
        
        urlComponent?.queryItems = [apiKey, searchTerm]
        
        guard let finalURL = urlComponent?.url else {
            print("failed to get final URL from: \(urlComponent?.description)")
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: finalURL) { data, _, error in
            
            if let error = error {
                print(error)
            }
            
            guard let data = data else {
                print("unalble to get data from: \(data)")
                completion(nil)
                return
            }
            
            do {
                
                guard let data = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: Any],
                      let movieArray = data["results"] as? [[String: Any]]
                else {
                    
                    print("Unable to deserialize Data from \(data)")
                    completion(nil)
                    return
                }
                
                var movieHolder: [Movie] = []
                for movie in movieArray {
                    if let newMovie = Movie(fromDictionary: movie) {
                        movieHolder.append(newMovie)
                    } else {
                        print("failed to decode Movie: \(movie)")
                    }
                }
                completion(movieHolder)
                
            } catch let error {
                print(error)
                
                completion(nil)
            }
        }.resume()
    }
    
    static func getImage(from imagePath: String, completion: @escaping (UIImage?) -> Void) {
        guard let baseURL = URL(string: baseURLString.image.rawValue) else { completion(nil); return }
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.path = "/t/p/original\(imagePath)"
        
        guard let finalURL = urlComponents?.url else { completion(nil); return }
        URLSession.shared.dataTask(with: finalURL) { data, _, error in
            
            if let error = error {
                print(error)
                
            }
            
            guard let data = data,
                  let image = UIImage(data: data)
            else { completion(nil); return }
            
            completion(image)
            
        }.resume()
    }
}
