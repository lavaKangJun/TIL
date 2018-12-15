//
//  MovieReviewList.swift
//  BoxOffice
//
//  Created by 강준영 on 14/12/2018.
//  Copyright © 2018 강준영. All rights reserved.
//

import Foundation

struct MovieReviewList: Codable {
    let comments: [MovieReview]
}

struct MovieReview: Codable {
  
    let rating: Double
    let timestamp: Double
    let writer: String
    let movieId: String
    let contents: String
    
    enum CodingKeys: String, CodingKey {
        case rating, timestamp, writer, contents
        case movieId = "movie_id"
    }

}
