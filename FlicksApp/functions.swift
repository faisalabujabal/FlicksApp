//
//  functions.swift
//  FlicksApp
//
//  Created by Faisal Abu Jabal on 2/1/16.
//  Copyright © 2016 Faisal Abu Jabal. All rights reserved.
//

func getGenresFromArray(array genreArray: [Int]?) -> String? {
    var genreString: String = ""
    
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
