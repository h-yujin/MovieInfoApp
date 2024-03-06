//
//  NetworkService.swift
//  MovieInfo
//
//  Created by Hong yujin on 3/6/24.
//

import Foundation

public enum APIPath {
  case popular
  
  var pathString: String {
    switch self {
    case .popular:
      return "popular"
    }
  }
  
  var parameters: [String: String]? {
    switch self {
    case .popular:
      return nil
    }
  }  
}

public class NetworkService {
  static let shared: NetworkService = NetworkService()
  private let baseURL = "https://api.themoviedb.org/3/movie"
  
  
  func request(path: APIPath) async throws -> HomeResponse {
    guard let encodedURLString = "\(baseURL)/\(path.pathString)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
          let encodedURL = URL(string: encodedURLString) else {
      throw NetworkError.invalidURL
    }
    
    let data = try await fetchData(from: URLRequest(url: encodedURL))
    
    do {
      let decodeData = try JSONDecoder().decode(HomeResponse.self, from: data)
      return decodeData
    } catch {
      throw NetworkError.decodeError
    }
  }
}

extension NetworkService {
  private func fetchData(from urlRequest: URLRequest) async throws -> Data {
    var urlRequest = urlRequest
    let header = [
      "Authorization" : "Bearer \(Keys.readAcceccToken)",
      "accept" : "application/json"
    ]
    
    urlRequest.allHTTPHeaderFields = header
    urlRequest.httpMethod = HTTPMethod.get.capitalizedValue
    
    
    let (data, response) = try await URLSession.shared.data(for: urlRequest)
    if let error = NetworkError(httpResponse: response as? HTTPURLResponse) {
      throw error
    }
    
    return data
  }
}

//extension NetworkService {
//  private func handleResponseData(with data: Data?) -> Result<ResponseType, Error> {
//    guard let data = data else {
//      return .failure(NetworkError.badResponse)
//    }
//
//    do {
//      let deserializedData = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
//
//      if let jsonDic = deserializedData as? [String: Any] {
//        return .success(.jsonDic(dic: jsonDic))
//      } else if let jsonArray = deserializedData as? [Any] {
//        return .success(.jsonArray(array: jsonArray))
//      } else {
//        return .failure(NetworkError.invalidFormat)
//      }
//    } catch {
//      return .failure(NetworkError.invalidJSON)
//    }
//  }
//}
