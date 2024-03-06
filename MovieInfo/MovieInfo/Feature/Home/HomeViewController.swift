//
//  HomeViewController.swift
//  MovieInfo
//
//  Created by Hong yujin on 3/6/24.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
  @IBOutlet weak var collectionView: UICollectionView!
  
  var dataSorce: UICollectionViewDiffableDataSource<Section, Movie>!
  
  
  private var viewModel: HomeViewModel = HomeViewModel()
  private var cancellabels: Set<AnyCancellable> = []
  
  enum Section: Int {
    case popular
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupCollectionView()
    setDataSource()
    bindViewModel()
    viewModel.process(action: .loadData)
  }
}

extension HomeViewController {
  private func setupCollectionView() {
    collectionView.register(UINib(nibName: HomePopularCell.reusableId, bundle: nil),
                            forCellWithReuseIdentifier: HomePopularCell.reusableId)
    
    collectionView.collectionViewLayout = setCompositionLayout()
  }
  
  private func setDataSource() {
    dataSorce = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, movie in
      switch Section(rawValue: indexPath.section) {
      case .popular:
        return self.productItemCell(collectionView, indexPath, movie)
      case .none:
        return .init()
      }
    })
  }
  
  private func setCompositionLayout() -> UICollectionViewCompositionalLayout {
    UICollectionViewCompositionalLayout { section, _ in
      switch Section(rawValue: section) {
      case .popular:
        return HomePopularCell.homePopularLayout()
      case .none: return nil
      }
    }
    
  }
  
  private func bindViewModel() {
    viewModel.$popularList
      .receive(on: DispatchQueue.main)
      .sink { [weak self] movies in
        self?.updateData(on: movies)
      }.store(in: &cancellabels)
  }
  
  private func updateData(on movies: [Movie]) {
    var snapshot = NSDiffableDataSourceSnapshot<Section, Movie>()
    snapshot.appendSections([.popular])
    snapshot.appendItems(movies, toSection: .popular)
    
    DispatchQueue.main.async { [weak self] in
      self?.dataSorce.apply(snapshot, animatingDifferences: true)
    }
  }
  
  private func productItemCell(_ collectionView: UICollectionView, _ indexPath: IndexPath, _ movie: Movie) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomePopularCell.reusableId, for: indexPath) as? HomePopularCell else { return .init() }
    cell.setMovie(movie, rank: indexPath.row + 1)
    return cell
  }
}

