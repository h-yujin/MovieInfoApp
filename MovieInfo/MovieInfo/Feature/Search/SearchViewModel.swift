//
//  SearchViewModel.swift
//  MovieInfo
//
//  Created by Hong yujin on 3/7/24.
//

import Foundation

class SearchViewModel {
  enum Action {
    case searchData(keyword: String)
  }
  
  @Published var movies: [Movie]?
  @Published var phase: Phase = .notRequested
  
  func process(action: Action) {
    switch action {
    case .searchData(let keyword):
      phase = .loading
      loadData(keyword)
    }
  }
}

extension SearchViewModel {
  private func loadData(_ keyword: String) {
    Task { await searchMovieAPI(with: keyword) }
  }
  
  private func searchMovieAPI(with keyword: String) async {
    do {
      let param = ["query": keyword]
      let response = try await NetworkService.shared.getSearchData(path: .search, parameters: param)
      movies = response.results
      phase = .success
    } catch {
      phase = .fail(error: error)
    }
  }
}
