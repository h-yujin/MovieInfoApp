//
//  HTTPMethod.swift
//  MovieInfo
//
//  Created by Hong yujin on 3/6/24.
//

enum HTTPMethod: String {
  case get //, post, delete, put
  
  var capitalizedValue: String {
    self.rawValue.uppercased()
  }
}
