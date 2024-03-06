//
//  HomeViewModel.swift
//  MovieInfo
//
//  Created by Hong yujin on 3/6/24.
//

import Foundation

class HomeViewModel {
  enum Action {
    case loadData
    case getDataSuccess(HomeResponse)
    case getDataFailure(Error)
  }
  
  
  func process(action: Action) {
    switch action {
    case .loadData:
      loadData()
    case .getDataSuccess(let homeResponse):
      return
    case .getDataFailure(let error):
      return
    }
  }
}

extension HomeViewModel {
  private func loadData() {
    Task {
      
      let response = try await NetworkService.shared.request(path: .popular)
      print(response)
    }
  }
}
