//
//  SearchViewController.swift
//  MovieInfo
//
//  Created by Hong yujin on 3/7/24.
//

import UIKit
import Combine

class SearchViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  private var dataSource: UITableViewDiffableDataSource<Section, AnyHashable>!
  
  private var viewModel = SearchViewModel()
  private var cancellabels: Set<AnyCancellable> = []
  var publisher: Just<String>?
  
  @Published var searchText: String = ""
  
  private enum Section: Int {
    case search
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupSearchBar()
    setupTableView()
    setDataSource()
    bindViewModel()
  }
}

extension SearchViewController {
  
  private func setupSearchBar() {
    let navigationSearchBar = NavigationSearchBar("검색하실 영화 제목을 입력해주세요.")
    navigationSearchBar.delegate = self
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: navigationSearchBar)
  }
  private func setupTableView() {
    tableView.register(UINib(nibName: SearchCell.reuseableId, bundle: nil),
                       forCellReuseIdentifier: SearchCell.reuseableId)
  }
  
  private func setDataSource() {
    dataSource = UITableViewDiffableDataSource(tableView: tableView, cellProvider: { [weak self] tableView, indexPath, itemIdentifier in
      switch Section(rawValue: indexPath.section) {
      case .search:
        return self?.searchCell(tableView, indexPath, itemIdentifier)
      case .none : 
        return .init()
      }
    })
  }
  
  private func bindViewModel() {
    viewModel.$phase
      .receive(on: DispatchQueue.main)
      .sink { [weak self] phase in
        switch self?.viewModel.phase {
        case .notRequested: return
        case .loading:
          LoadingIndicator.shared.start(on: self?.view)
        case .success:
          LoadingIndicator.shared.stop()
        case .fail(let error):
          LoadingIndicator.shared.stop()
          if let networkError = error as? NetworkError {
            _ = ErrorView(on: self?.view, errorText: networkError.errorString)
          }
        case .none: break
        }
      }.store(in: &cancellabels)
    
    viewModel.$movies
      .receive(on: DispatchQueue.main)
      .sink { [weak self] _ in
        self?.updateData()
      }.store(in: &cancellabels)
    
    $searchText
      .debounce(for: .seconds(0.2), scheduler: DispatchQueue.main)
      .sink { [weak self] text in
        self?.viewModel.process(action: .searchData(keyword: text))
      }.store(in: &cancellabels)
  }
  
  
  private func updateData() {
    var snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()
    
    if let movies = viewModel.movies {
      snapshot.appendSections([.search])
      snapshot.appendItems(movies, toSection: .search)
    }
    
    dataSource.apply(snapshot, animatingDifferences: true)
  }
  
  private func searchCell(_ tableView: UITableView, _ indexPath: IndexPath, _ movie: AnyHashable) -> UITableViewCell? {
    guard let movie = movie as? Movie,
      let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.reuseableId, for: indexPath) as? SearchCell else { 
      let cell = UITableViewCell()
      cell.backgroundColor = .blue
      return cell }
    cell.setMovie(movie)
    return cell
  }
}

extension SearchViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    self.searchText = searchText
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchBar.endEditing(true)
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    searchBar.text = nil
  }
}
