//
//  HomeResponse.swift
//  MovieInfo
//
//  Created by Hong yujin on 3/6/24.
//

import Foundation

struct HomeResponse: Decodable {
  let page: Int
  let results: [Movie]
  let total_pages: Int
  let total_results: Int
}
