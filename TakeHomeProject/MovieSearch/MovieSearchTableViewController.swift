//
//  MovieSearchTableViewController.swift
//  TakeHomeProject
//
//  Created by adam smith on 4/17/22.
//

import UIKit

class MovieSearchTableViewController: UITableViewController {
    
//MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var movies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return movies.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell else { return UITableViewCell() }

        let movie = movies[indexPath.row]
        cell.updateViews(movie: movie)
        return cell
    }


    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "todetail",
            let destination = segue.destination as? MovieDetailsViewController {
                if let indexPath = tableView.indexPathForSelectedRow {
                    let movieToSend = self.movies[indexPath.row]
                    destination.movie = movieToSend
            }
        }
    }
}

extension MovieSearchTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        guard let searchTerm = searchBar.text,
              !searchTerm.isEmpty
        else { return }
        
        MovieNetworkController.fetchMoviesWith(name: searchTerm) { movies in
            guard let movies = movies else { return }
            self.movies = movies
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

