//
//  MoviesHomePageViewController.swift
//  FlicksApp
//
//  Created by Faisal Abu Jabal on 1/22/16.
//  Copyright © 2016 Faisal Abu Jabal. All rights reserved.
//

import UIKit
import AFNetworking

class MoviesHomePageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var moviesHomePageTableView: UITableView!
    
    var moviesList: [NSDictionary]? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moviesHomePageTableView.dataSource = self
        moviesHomePageTableView.delegate = self
        // Do any additional setup after loading the view.
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = NSURL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate: nil,
            delegateQueue: NSOperationQueue.mainQueue()
        )
        let task: NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                            self.moviesList = (responseDictionary["results"] as? [NSDictionary])
                            self.moviesHomePageTableView.reloadData()
                    }
                }
        })
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    internal func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(moviesList != nil && moviesList?.count > 0){
            return (moviesList?.count)!
        } else {
            return 0
        }
    }
    
    internal func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let movieCell = tableView.dequeueReusableCellWithIdentifier("MovieListCell", forIndexPath: indexPath) as! MovieListCell
        if(moviesList != nil){
            movieCell.titleLabel.text = moviesList![indexPath.row]["title"] as? String;
            movieCell.overviewLabel.text = moviesList![indexPath.row]["overview"] as? String
            let imageBaseURL = "http://image.tmdb.org/t/p/w500/"
            let imageURL = NSURL(string: imageBaseURL +
                (moviesList![indexPath.row]["poster_path"] as! String))
            movieCell.moviePoster.setImageWithURL(imageURL!)
            print(imageBaseURL +
                (moviesList![indexPath.row]["poster_path"] as! String))
        }
        return movieCell
    }


}