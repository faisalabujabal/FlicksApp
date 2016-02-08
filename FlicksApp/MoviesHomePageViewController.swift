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
    var connectionErrors = false
    var loadedInfo = false
    var moviesList: [NSDictionary]? = nil
    var homepageMoviesRefreshController = UIRefreshControl()
    var genreList: Dictionary<Int, String> = [:]
    var movieDatabaseEndpoint: String!
    var viewControllerTitle: String!
    
    @IBAction func networkErrorButton(sender: UIButton) {
            loadTableViewContent()
    }
    
    @IBOutlet weak var networkErrorView: UIView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        networkErrorView.hidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadTableViewContent()
        
        
        self.title = viewControllerTitle
        moviesHomePageTableView.dataSource = self
        moviesHomePageTableView.delegate = self
        homepageMoviesRefreshController.addTarget(self, action: "refreshHomepageMoviesList:", forControlEvents: .ValueChanged)
        moviesHomePageTableView.addSubview(homepageMoviesRefreshController)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadTableViewContent(){
        let homepageIndicator = LoadingIndicator()
        homepageIndicator.showIndicator(parentView: moviesHomePageTableView)
        
        func getGenreNamesSuccess(){
            networkErrorView.hidden = true
            getNowPlayingMovies(){
                self.moviesHomePageTableView.reloadData()
                homepageIndicator.hideIndicator()
            }
        }
        
        func getGenreNamesFail(){
            
            networkErrorView.hidden = false
            
            homepageIndicator.hideIndicator()
        }
        
        getGenreNamesIDs(onSuccessFunction: getGenreNamesSuccess, onFailFunction: getGenreNamesFail)
    }
    
    func getNowPlayingMovies(onSuccessFunction onSuccess: () -> ()) {
        // Do any additional setup after loading the view.
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = NSURL(string: "https://api.themoviedb.org/3/movie/\(movieDatabaseEndpoint)?api_key=\(apiKey)&page=1")
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
                            self.moviesList = responseDictionary["results"] as? [NSDictionary];
                            //let delay = 1.5 * Double(NSEC_PER_SEC)
                            //let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
                            //dispatch_after(time, dispatch_get_main_queue()) {
                                dispatch_async(dispatch_get_main_queue()) {
                                    self.loadedInfo = true
                                    onSuccess()
                                }
                            //}
                    }
                }
        })
        task.resume()
    }
    
    func getGenreNamesIDs(onSuccessFunction onSuccess: () -> (), onFailFunction onFail: ()-> () ){
        var networkError: Bool = true
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = NSURL(string: "http://api.themoviedb.org/3/genre/movie/list?api_key=\(apiKey)")!
        let request = NSURLRequest(URL: url)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate: nil,
            delegateQueue: NSOperationQueue.mainQueue()
        )
        let task: NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let response = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
        
                        networkError = false;
        
                        let response = (response["genres"] as? [NSDictionary]?)!
                        
                        for genre in response! {
                            self.genreList[(genre["id"] as? Int)!] = (genre["name"] as? String)
                        }
                            
                                                
                        dispatch_async(dispatch_get_main_queue()) {
                            onSuccess()
                        }
                    }
                }
        })
        
        if(networkError){
            onFail()
        }
        task.resume()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(moviesList != nil && moviesList?.count > 0){
            connectionErrors = false
            return (moviesList?.count)!
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let movieCell = tableView.dequeueReusableCellWithIdentifier("MovieListCell", forIndexPath: indexPath) as! MovieListCell
        if(!connectionErrors){
            if(moviesList != nil){
                movieCell.titleLabel.text = moviesList![indexPath.row]["title"] as? String;
                
                let smallImageBase = "http://image.tmdb.org/t/p/w45/"
                let largeImageBase = "http://image.tmdb.org/t/p/original/"
                
                let smallImageURL = NSURL(string: smallImageBase +
                    (moviesList![indexPath.row]["poster_path"] as! String))
                let largeImageURL = NSURL(string: largeImageBase +
                    (moviesList![indexPath.row]["poster_path"] as! String))
//                    movieCell.moviePoster.setImageWithURL(imageURL)
               
                
                let smallImageRequest = NSURLRequest(URL: smallImageURL!)
                let largeImageRequest = NSURLRequest(URL: largeImageURL!)
                
                movieCell.moviePoster.setImageWithURLRequest(
                    smallImageRequest,
                    placeholderImage: nil,
                    success: { (smallImageRequest, smallImageResponse, smallImage) -> Void in
                        
                        // smallImageResponse will be nil if the smallImage is already available
                        // in cache (might want to do something smarter in that case).
                        movieCell.moviePoster.alpha = 0.0
                        movieCell.moviePoster.image = smallImage;
                        
                        UIView.animateWithDuration(0.3, animations: { () -> Void in
                            
                            movieCell.moviePoster.alpha = 1.0
                            
                            }, completion: { (sucess) -> Void in
                                
                                // The AFNetworking ImageView Category only allows one request to be sent at a time
                                // per ImageView. This code must be in the completion block.
                                movieCell.moviePoster.setImageWithURLRequest(
                                    largeImageRequest,
                                    placeholderImage: smallImage,
                                    success: { (largeImageRequest, largeImageResponse, largeImage) -> Void in
                                        
                                        movieCell.moviePoster.image = largeImage;
                                        
                                    },
                                    failure: { (request, response, error) -> Void in
                                        // do something for the failure condition of the large image request
                                        // possibly setting the ImageView's image to a default image
                                })
                        })
                    },
                    failure: { (request, response, error) -> Void in
                        // do something for the failure condition
                        // possibly try to get the large image
                })
                
                
                
                movieCell.releaseDateLabel.text = "Release date: " + (moviesList![indexPath.row]["release_date"] as? String)!
                movieCell.genreLabel.text = getGenresFromArray(indexPathRow: indexPath.row)
                let movieRating = moviesList![indexPath.row]["vote_average"] as! Int
                movieCell.ratingLabel.text = "Rating: \(movieRating)/10"
                
            } else {
                movieCell.titleLabel?.text = "Connection error"
            }
        } else {
            print("connection error")
            movieCell.titleLabel?.text = "Connection error"
        }
        return movieCell
    }
    
    func refreshHomepageMoviesList(refreshControl: UIRefreshControl) {
        dispatch_async(dispatch_get_main_queue()) {
            self.getNowPlayingMovies(){
                refreshControl.endRefreshing()
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let currCell = sender as? MovieListCell
        let currCellIndexPath = moviesHomePageTableView.indexPathForCell(currCell!)
        let currMovie = moviesList![currCellIndexPath!.row]
        
        let detailPage = segue.destinationViewController as! MovieDetailViewController
        detailPage.movieDetails = currMovie
        detailPage.genreString = getGenresFromArray(indexPathRow: (currCellIndexPath?.row)!)
    }
    
    func getGenresFromArray(indexPathRow indexPathRow: Int) -> String? {
        var genreString: String = ""
        let genreArray = moviesList![indexPathRow]["genre_ids"] as? [Int]
        
        if(genreArray != nil){
            for genreID in genreArray!{
                if(genreString != ""){
                    genreString = genreString + ", " + genreList[genreID]!
                } else {
                    genreString = genreString + genreList[genreID]!
                }
            }
        }
        return "Genres: " + genreString
    }
    
}








