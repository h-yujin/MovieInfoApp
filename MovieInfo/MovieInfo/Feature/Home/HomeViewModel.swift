//
//  HomeViewModel.swift
//  MovieInfo
//
//  Created by Hong yujin on 3/6/24.
//

import Foundation

class HomeViewModel {
  @Published var popularList: [Movie] = []
  
  enum Action {
    case loadData
    case getDataFailure(Error)
  }
  
  
  func process(action: Action) {
    switch action {
    case .loadData:
      loadData()
    case .getDataFailure(let error):
      return
    }
  }
}

extension HomeViewModel {
  private func loadData() {
    Task {
      do {
        let response = try await NetworkService.shared.request(path: .popular)
        popularList = response.results
      } catch {
        process(action: .getDataFailure(error))
      }
      
    }
  }
}
