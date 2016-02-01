//
//  MovieDatabase.swift
//  FlicksApp
//
//  Created by Faisal Abu Jabal on 1/31/16.
//  Copyright © 2016 Faisal Abu Jabal. All rights reserved.
//

import UIKit

class MovieDatabase {
    static func getNowPlayingMovies(tableView tableView: UITableView, var saveTo moviesList: [NSDictionary]?, var loaded loadedInfo: Bool?, reloadData: () -> ()) {
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
                            //                            print(responseDictionary)
//                            NSLog("response: \(responseDictionary)")
                            loadedInfo = true
                            moviesList = responseDictionary["results"] as? [NSDictionary];
//                            dispatch_async(dispatch_get_main_queue()) {
////                                self.loadedInfo = true
//                                tableView.reloadData()
//                            }
                            reloadData()
                            //                            loaded = true
                    } else {
                        loadedInfo = false
                    }
                }
        })
        task.resume()
        //        return loaded
//        return (loadedInfo, moviesList)
    }
}
