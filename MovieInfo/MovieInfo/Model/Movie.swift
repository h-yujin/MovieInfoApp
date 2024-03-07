//
//  Movie.swift
//  MovieInfo
//
//  Created by Hong yujin on 3/6/24.
//

import Foundation

struct Movie: Decodable, Hashable {
  let identifier: UUID
  let poster_path: String?
  let title: String?
  let release_date: String?
  let overview: String?
  
  var thumbnailImagePath: String {
    "https://image.tmdb.org/t/p/w500\(poster_path ?? "")"
  }
  
  var originalImagePath: String {
    "https://image.tmdb.org/t/p/original\(poster_path ?? "")"
  }
  
  enum CodingKeys: String, CodingKey {
    case identifier, poster_path, title, release_date, overview
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    identifier = UUID()
    poster_path = try? container.decode(String.self, forKey: .poster_path)
    title = try? container.decode(String.self, forKey: .title)
    release_date = try? container.decode(String.self, forKey: .release_date)
    overview = try? container.decode(String.self, forKey: .overview)
  }
}
