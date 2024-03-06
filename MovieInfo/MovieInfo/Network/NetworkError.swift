//
//  NetworkError.swift
//  MovieInfo
//
//  Created by Hong yujin on 3/6/24.
//

import Foundation

public enum NetworkError: Error {
  case invalidURL
  case badResponse
  case requestError
  case responesError
  case decodeError
  case unowneError
}

extension NetworkError {
  init?(httpResponse: HTTPURLResponse?) {
    guard let httpResponse else {
      self = NetworkError.responesError
      return
    }
    
    switch httpResponse.statusCode {
    case 200..<300:
      return nil
    case 400..<500:
      self = NetworkError.requestError
    case 500..<600:
      self = NetworkError.responesError
    default:
      self = NetworkError.unowneError
    }
  }
}
