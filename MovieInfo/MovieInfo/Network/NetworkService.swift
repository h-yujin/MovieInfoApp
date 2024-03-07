//
//  NetworkService.swift
//  MovieInfo
//
//  Created by Hong yujin on 3/6/24.
//

import Foundation

public enum APIPath {
  case popular
  case topRate
  case upcoming
  case search
  
  var pathString: String {
    switch self {
    case .popular:
      return "movie/popular"
    case .topRate:
      return "movie/top_rated"
    case .upcoming:
      return "movie/upcoming"
    case .search:
      return "search/movie"
    }
  }
  
  var parameters: [String: String]? {
    switch self {
    case .popular:
      return nil
    case .topRate:
      return nil
    case .upcoming:
      return nil
    case .search:
      return nil
    }
  }  
}

public class NetworkService {
  static let shared: NetworkService = NetworkService()
  private let baseURL = "https://api.themoviedb.org/3/"
  
  
  
  func getHomeData(path: APIPath) async throws -> HomeResponse {
    let data = try await fetchData(from: "\(baseURL)/\(path.pathString)", parameters: nil)
    do {
      return try JSONDecoder().decode(HomeResponse.self, from: data)
    } catch {
      throw NetworkError.decodeError
    }
  }
  
  func getSearchData(path: APIPath, parameters: [String: String]? = nil) async throws -> SearchResponse {
    
    let data = try await fetchData(from: "\(baseURL)/\(path.pathString)", parameters: parameters)
    
    do {
      return try JSONDecoder().decode(SearchResponse.self, from: data)
    } catch let error {
      throw NetworkError.decodeError
    }
  }
  
}

extension NetworkService {
  private func fetchData(from urlString: String, 
                         parameters: [String: String]?,
                         method: HTTPMethod? = .get) async throws -> Data {
    let headers = [
      "Authorization" : "Bearer \(Keys.readAcceccToken)",
      "accept" : "application/json"
    ]
    
    var urlComponents = URLComponents(string: urlString)

    var queryItems = [URLQueryItem]()
    if let parameters = parameters {
      for (key, value) in parameters {
          queryItems.append(URLQueryItem(name: key, value: value))
      }
    }
    queryItems.append(URLQueryItem(name: "language", value: "ko-KR"))
    queryItems.append(URLQueryItem(name: "region", value: "KR"))
    
    urlComponents?.queryItems = queryItems

    var request = URLRequest(url: (urlComponents?.url)!)
    request.httpMethod = method?.capitalizedValue

    for (key, value) in headers {
        request.setValue(value, forHTTPHeaderField: key)
    }
    
    let (data, response) = try await URLSession.shared.data(for: request)
    if let error = NetworkError(httpResponse: response as? HTTPURLResponse) {
      throw error
    }
    
    return data
  }
}
