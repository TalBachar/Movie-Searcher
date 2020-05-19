//
//  ViewController.swift
//  Movie Searcher
//
//  Created by Tal Bachar
//  Copyright © 2020 Tal Bachar. All rights reserved.
//

import UIKit
import SafariServices

class ViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, SignUpViewControllerDelegate {
    
    @IBOutlet var table: UITableView!
    @IBOutlet var field: UITextField!

    var movies = [Movie]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set(false, forKey: "signedUp")  //SET TO FALSE BEFORE SHOW
        table.register(MovieTableViewCell.nib(), forCellReuseIdentifier: MovieTableViewCell.identifier)
        table.delegate = self
        table.dataSource = self
        field.delegate = self

        
        
        
        let favoritesItem = UIBarButtonItem(title: "Favorites", style: .plain, target: self, action: #selector(favoriteMoviesTapped))
        let watchedItem = UIBarButtonItem(title: "Watched", style: .plain, target: self, action: #selector(watchedMoviesTapped))
        
        navigationItem.rightBarButtonItem = favoritesItem
        navigationItem.leftBarButtonItem = watchedItem
        
        navigationItem.title = "Movie Searcher"

    }
    
    @IBAction func accountTapped(_ sender: Any) {
        
        if (UserDefaults.standard.bool(forKey: "signedUp")) {
            performSegue(withIdentifier: "loggedIn", sender: self)
        }
        else {
            performSegue(withIdentifier: "signUp", sender: self)
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "signUp" {
            if let nextViewController = segue.destination as? SignUpViewController {
                nextViewController.delegate = self
            }
        }
    }
    
    func signUpTapped() {
        performSegue(withIdentifier: "loggedIn", sender: self)
    }
    

    
    
    @objc func favoriteMoviesTapped() {
        let favoritesVC:FavoriteMoviesTableViewController = FavoriteMoviesTableViewController()
        
        navigationController?.pushViewController(favoritesVC, animated: true)
        
    }
    
    @objc func watchedMoviesTapped() {
        let watchedVC:WatchedMoviesTableViewController = WatchedMoviesTableViewController()
        
        navigationController?.pushViewController(watchedVC, animated: true)
        
    }

    // Field
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchMovies()
        return true
    }

    func searchMovies() {
        field.resignFirstResponder()

        guard let text = field.text, !text.isEmpty else {
            return
        }

        let query = text.replacingOccurrences(of: " ", with: "%20")

        movies.removeAll()

        URLSession.shared.dataTask(with: URL(string: "https://www.omdbapi.com/?apikey=3aea79ac&s=\(query)&type=movie")!,
                                   completionHandler: { data, response, error in

                                    guard let data = data, error == nil else {
                                        return
                                    }

                                    // Convert
                                    var result: MovieResult?
                                    do {
                                        result = try JSONDecoder().decode(MovieResult.self, from: data)
                                    }
                                    catch {
                                        print("error")
                                    }

                                    guard let finalResult = result else {
                                        return
                                    }

                                    // Update our movies array
                                    let newMovies = finalResult.Search
                                    self.movies.append(contentsOf: newMovies)

                                    // Refresh our table
                                    DispatchQueue.main.async {
                                        self.table.reloadData()
                                    }

        }).resume()

    }

    // Table

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as! MovieTableViewCell
        cell.configure(with: movies[indexPath.row])
        cell.table = tableView
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Show movie details
        let url = "https://www.imdb.com/title/\(movies[indexPath.row].imdbID)/"
        let vc = SFSafariViewController(url: URL(string: url)!)
        present(vc, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

}

struct MovieResult: Codable {
    let Search: [Movie]
}

struct Movie: Codable, Equatable {
    let Title: String
    let Year: String
    let imdbID: String
    let _Type: String
    let Poster: String
    var favorite: Bool = false;
    var watched: Bool = false;
    private enum CodingKeys: String, CodingKey {
        case Title, Year, imdbID, _Type = "Type", Poster
    }
}
