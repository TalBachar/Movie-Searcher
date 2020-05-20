//
//  MovieManager.swift
//  Movie Searcher
//
//  Created by Tal Bachar on 5/16/20.
//  Copyright © 2020 Tal Bachar. All rights reserved.
//

import UIKit

class MovieManager: NSObject {

    static let shared = MovieManager()
    var favoritesArray : [Movie] = [Movie]()
    var watchedArray : [Movie]  = [Movie]()
    let movieCell = MovieTableViewCell()
    
    private override init()
       {
           // Set up MovieManager instance
        
       }
    
    func addMovieToFavorites(movie:Movie) -> Void {
        if favoritesArray.isEmpty { //if array is empty, append
            MovieManager.shared.favoritesArray.append(movie)
            return
        }
        for var curMovie: Movie in favoritesArray { //check if movie is already in array
            guard let index = favoritesArray.firstIndex(of: curMovie) else { return }
            
            if movie.imdbID == curMovie.imdbID {    //check for matching movies
                curMovie.favorite = false
                favoritesArray.remove(at: index)
                movieCell.changeFavoriteImage(isFavorite: false)
                return
                //MovieTableViewCell.changeFavoriteImage(false)
            }
        }//for-loop
        MovieManager.shared.favoritesArray.append(movie)
        
    }//addMovieToFavorits()
    
    func addMovieToWatched(movie:Movie) -> Void {
        if watchedArray.isEmpty {
            MovieManager.shared.watchedArray.append(movie)
            return
        }
        for curMovie: Movie in watchedArray {
            guard let index = watchedArray.firstIndex(of: curMovie) else { return }
            if movie.imdbID == curMovie.imdbID {
                curMovie.watched = false
                watchedArray.remove(at: index)
                movieCell.changeWatchedImage(isWatched: false)
                
                return
            }

        }//for-loop
        MovieManager.shared.watchedArray.append(movie)

    }//addMovieToWatched()
}
