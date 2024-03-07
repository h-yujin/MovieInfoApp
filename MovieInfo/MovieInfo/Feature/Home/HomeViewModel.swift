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
    var topRate: (title: String , itms: [Movie])?
    var upcoming: (title: String , itms: [Movie])?
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
    Task { await popularAPI() }
  }
  
  private func popularAPI() async {
    do {
      let response = try await NetworkService.shared.getHomeData(path: .popular)
      homeViewModels.popular = ("인기 영화", response.results)
      Task { await addBanner() }
    } catch {
      phase = .fail(error: error)
    }
  }
  
  private func addBanner() async {
    homeViewModels.banner = [
      "https://picsum.photos/id/1/500/500",
      "https://picsum.photos/id/2/500/500",
      "https://picsum.photos/id/3/500/500",
      "https://picsum.photos/id/4/500/500",
      "https://picsum.photos/id/5/500/500"
    ]
    
    Task { await topRateAPI() }
  }
  
  private func topRateAPI() async {
    do {
      let response = try await NetworkService.shared.getHomeData(path: .topRate)
      homeViewModels.topRate = ("최고 평점 영화", response.results)
      Task { await upcomingAPI() }
      phase = .success
    } catch {
      phase = .fail(error: error)
    }
  }
  
  private func upcomingAPI() async {
    do {
      let response = try await NetworkService.shared.getHomeData(path: .upcoming)
      homeViewModels.upcoming = ("개봉 예정!", response.results)
      
      phase = .success
    } catch {
      phase = .fail(error: error)
    }
  }
}
