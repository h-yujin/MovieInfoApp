//
//  HomeViewModel.swift
//  MovieInfo
//
//  Created by Hong yujin on 3/6/24.
//

import Foundation

class HomeViewModel {
  struct HomeViewModels {
    var popular: (title: String , itms: [Movie])?
    var banner: [String]?
  }
  
  enum Action {
    case loadData
  }
  
  @Published var phase: Phase = .notRequested
  @Published var homeViewModels = HomeViewModels()
  private var loadDataTask: Task<Void, Never>?
  
  func process(action: Action) {
    switch action {
    case .loadData:
      phase = .loading
      loadData()
    }
  }
  
  deinit {
    loadDataTask?.cancel()
  }
}

extension HomeViewModel {
  private func loadData() {
    loadDataTask = Task {
      do {
        let response = try await NetworkService.shared.request(path: .popular)
        homeViewModels.popular = ("인기순", response.results)
        phase = .success
      } catch {
        phase = .fail(error: error)
      }
      
      homeViewModels.banner = [
        "https://picsum.photos/id/1/500/500",
        "https://picsum.photos/id/2/500/500",
        "https://picsum.photos/id/3/500/500",
        "https://picsum.photos/id/4/500/500",
        "https://picsum.photos/id/5/500/500"
      ]
    }
    
    
  }
}
