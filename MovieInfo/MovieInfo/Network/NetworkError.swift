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
  
  var errorString: String {
    switch self {
    case .invalidURL,
        .badResponse,
        .requestError,
        .responesError,
        .decodeError:
      "네트워크에 문제가 발생했습니다!\n잠시 후 다시 시도해주세요."
    case .unowneError:
      "알 수 없는 오류가 발생했습니다."
    }
  }
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
