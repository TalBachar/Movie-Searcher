//
//  AccountViewController.swift
//  Movie Searcher
//
//  Created by Tal Bachar
//  Copyright © 2020 Tal Bachar. All rights reserved.
//

import UIKit



class AccountViewController: UIViewController {

    @IBOutlet weak var numOfMoviesWatched: UILabel!
    
    @IBOutlet weak var numOfMoviesFavorited: UILabel!
    
    @IBOutlet weak var rank: UILabel!
    
    
    func updateRankOfUser () {
        if Int(MovieManager.shared.watchedArray.count) < 5 && Int(MovieManager.shared.watchedArray.count) > 0 {
            rank.text = "Beginner"
        }
        else if Int(MovieManager.shared.watchedArray.count) < 10 && Int(MovieManager.shared.watchedArray.count) >= 5 {
            rank.text = "Advanced Beginner"
        }
        else if Int(MovieManager.shared.watchedArray.count) < 20 && Int(MovieManager.shared.watchedArray.count) >= 10 {
            rank.text = "Regular Movie-Watcher"
        }
        else if Int(MovieManager.shared.watchedArray.count) < 40 && Int(MovieManager.shared.watchedArray.count) >= 20 {
            rank.text = "Movie Buff"
        }
        else if Int(MovieManager.shared.watchedArray.count) < 80 && Int(MovieManager.shared.watchedArray.count) >= 40 {
                   rank.text = "Film Specialist"
               }
        else if Int(MovieManager.shared.watchedArray.count) > 80 {
            rank.text = "Quentin Tarantino"
        }
    }
    
    func updateStats() {
        numOfMoviesFavorited.text = String(MovieManager.shared.watchedArray.count)
        numOfMoviesWatched.text = String(MovieManager.shared.watchedArray.count)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateStats()
        updateRankOfUser()
    }

}
