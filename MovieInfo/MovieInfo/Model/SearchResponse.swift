//
//  SearchResponse.swift
//  MovieInfo
//
//  Created by Hong yujin on 3/7/24.
//

import Foundation

struct SearchResponse: Decodable {
  let page: Int
  let results: [Movie]
  let total_pages: Int
  let total_results: Int
  
}
