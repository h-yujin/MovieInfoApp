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
    let data = try await fetchData(from: "\(baseURL)/\(path.pathString)", parameters: nil, method: nil)
    
    do {
      let decodeData = try JSONDecoder().decode(HomeResponse.self, from: data)
      return decodeData
    } catch {
      throw NetworkError.decodeError
    }
  }
}

extension NetworkService {
  private func fetchData(from urlString: String, 
                         parameters: [String: String]?,
                         method: HTTPMethod?) async throws -> Data {
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
