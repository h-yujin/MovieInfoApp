//
//  Movie.swift
//  MovieInfo
//
//  Created by Hong yujin on 3/6/24.
//

import Foundation

struct Movie: Decodable {  
  let adult: Bool
  let backdrop_path: String
  let id: Int
  let original_language: String
  let original_title: String
  let overview: String
  let popularity: Double
  let poster_path: String
  let release_date: String
  let title: String
  let video: Bool
  let vote_average: Double
  let vote_count: Int
}
