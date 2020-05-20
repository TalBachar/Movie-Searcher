//
//  MovieTableViewCell.swift
//  Movie Searcher
//
//  Created by Tal Bachar
//  Copyright © 2020 Tal Bachar. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet var movieTitleLabel: UILabel!
    @IBOutlet var movieYearLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet var moviePosterImageView: UIImageView!
    @IBOutlet weak var watchedButton: UIButton!
    @IBOutlet weak var buttonsStack: UIStackView!
    var currentMovie: Movie?
    var table: UITableView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    static let identifier = "MovieTableViewCell"

    static func nib() -> UINib {
        return UINib(nibName: "MovieTableViewCell",
                     bundle: nil)
    }

    func configure(with model: Movie) {
        currentMovie = model
        self.movieTitleLabel.text = model.Title
        self.movieYearLabel.text = model.Year
        let url = model.Poster
        if let data = try? Data(contentsOf: URL(string: url)!) {
            self.moviePosterImageView.image = UIImage(data: data)
        }
        
        changeWatchedImage(isWatched: model.watched)
        changeFavoriteImage(isFavorite: model.favorite)
    }
    
    @IBAction func addToWatchedTapped(_ sender: Any) {
        
        if let movie = currentMovie {
            
            movie.watched = !movie.watched
            changeWatchedImage(isWatched: true)
                           MovieManager.shared.addMovieToWatched(movie: movie)
               }
        
        table?.reloadData()

    }
    @IBAction func addToFavoritesTapped(_ sender: Any) {
        
        if let movie = currentMovie {
            changeFavoriteImage(isFavorite: true)
            
            movie.favorite = !movie.favorite
                    MovieManager.shared.addMovieToFavorites(movie: movie)
        }
        table?.reloadData()
    }
    
    func changeFavoriteImage(isFavorite:Bool) -> Void {
        if isFavorite {
            if (favoriteButton != nil) {
                favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            }
        } else {
            if (favoriteButton != nil) {
                favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)

            }
        }
       
    }
    
    func changeWatchedImage(isWatched:Bool) -> Void {
        
        if isWatched {
            if (watchedButton != nil) {
                            watchedButton.setImage(UIImage(systemName:"folder.fill.badge.plus"), for: .normal)

            }
        } else {
            if (watchedButton != nil) {
                watchedButton.setImage(UIImage(systemName: "folder.badge.plus"), for: .normal)

            }
            
        }
         
       }
    
}
