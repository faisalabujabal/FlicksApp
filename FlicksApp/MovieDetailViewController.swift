//
//  MovieDetailViewController.swift
//  FlicksApp
//
//  Created by Faisal Abu Jabal on 2/1/16.
//  Copyright © 2016 Faisal Abu Jabal. All rights reserved.
//

import UIKit
import AFNetworking

class MovieDetailViewController: UIViewController {
    
    
    @IBOutlet weak var navigationBar: UINavigationItem!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var backdropImage: UIImageView!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    var movieDetails: NSDictionary? = nil
    var genreString: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        let movieTitle = movieDetails!["title"] as? String
        
        titleLabel.text = movieTitle
        genreLabel.text = genreString
        overviewLabel.text = movieDetails!["overview"] as? String
        
        navigationBar.title = movieTitle
        
        releaseDateLabel.text = "Release date: " + (movieDetails!["release_date"] as? String)!
        
        let imageBaseURL = "http://image.tmdb.org/t/p/w500/"
        if let imageURL = NSURL(string: imageBaseURL +
            (movieDetails!["backdrop_path"] as! String)){
                backdropImage.setImageWithURL(imageURL)
        }
        
    }
    
    
}
