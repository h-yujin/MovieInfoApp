//
//  Movie.swift
//  MovieInfo
//
//  Created by Hong yujin on 3/6/24.
//

import Foundation

struct Movie: Decodable, Hashable {
  let poster_path: String
  let title: String
  let release_date: String
  
  var thumbnailImagePath: String {
    "https://image.tmdb.org/t/p/w500\(poster_path)"
  }
  
  var originalImagePath: String {
    "https://image.tmdb.org/t/p/original\(poster_path)"
  }
}
