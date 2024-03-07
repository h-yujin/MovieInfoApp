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
  
  private var dataSorce: UICollectionViewDiffableDataSource<Section, AnyHashable>!
  
  private var viewModel = HomeViewModel()
  private var cancellabels: Set<AnyCancellable> = []
  
  enum Section: Int {
    case popular
    case banner
    case topRate
    case upcoming
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupLeftBarButtonItem()
    setupCollectionView()
    setDataSource()
    bindViewModel()
  }
  
  @IBAction func searchButton(_ sender: Any) {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    if let searchViewController = storyboard.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController {
      navigationController?.pushViewController(searchViewController, animated: true)
    }
  }
  
}

extension HomeViewController {
  private func setupLeftBarButtonItem() {
    navigationItem.leftBarButtonItem = UIImage(named: "movie_icon")?.createBarButtonItem()
  }
  
  private func setupCollectionView() {
    collectionView.register(UINib(nibName: HomeMovieCell.reuseableId, bundle: nil),
                            forCellWithReuseIdentifier: HomeMovieCell.reuseableId)
    collectionView.register(UINib(nibName: HomeHeaderCollectionReusableView.reuseableId, bundle: nil),
                            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                            withReuseIdentifier: HomeHeaderCollectionReusableView.reuseableId)
    collectionView.register(UINib(nibName: HomeBannerCollectionViewCell.reuseableId, bundle: nil),
                            forCellWithReuseIdentifier: HomeBannerCollectionViewCell.reuseableId)
    
    collectionView.collectionViewLayout = setCompositionLayout()
    collectionView.delegate = self
  }
  
  private func setDataSource() {
    dataSorce = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
      switch Section(rawValue: indexPath.section) {
      case .popular, .topRate, .upcoming:
        return self.productItemCell(collectionView, indexPath, item)
      case .banner:
        return self.bannerItemCell(collectionView, indexPath, item)
      case .none:
        return .init()
      }
    })
    
    dataSorce.supplementaryViewProvider = { [weak self] collectiomView, kind, indexPath in
      guard kind == UICollectionView.elementKindSectionHeader else { return UICollectionReusableView.init() }
      
      let headerView = collectiomView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                       withReuseIdentifier: HomeHeaderCollectionReusableView.reuseableId,
                                                                       for: indexPath) as? HomeHeaderCollectionReusableView
      
      var title = ""
      switch Section(rawValue: indexPath.section) {
      case .popular:
        title = self?.viewModel.homeViewModels.popular?.title ?? ""
      case .topRate:
        title = self?.viewModel.homeViewModels.topRate?.title ?? ""
      case .upcoming:
        title = self?.viewModel.homeViewModels.upcoming?.title ?? ""
      default: break
      }
      
      headerView?.setTitle(title)
      
      return headerView
      
    }
    
  }
  
  private func setCompositionLayout() -> UICollectionViewCompositionalLayout {
    UICollectionViewCompositionalLayout { section, _ in
      switch Section(rawValue: section) {
      case .popular, .topRate, .upcoming:
        return HomeMovieCell.homePopularLayout()
      case .banner:
        return HomeBannerCollectionViewCell.bannerLayout()
      case .none: return nil
      }
    }
    
  }
  
  private func bindViewModel() {
    viewModel.$phase
      .receive(on: DispatchQueue.main)
      .sink { [weak self] phase in
        switch self?.viewModel.phase {
        case .notRequested:
          self?.viewModel.process(action: .loadData)
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
    
    
    viewModel.$homeViewModels
      .receive(on: DispatchQueue.main)
      .sink { [weak self] _ in
        self?.updateData()
      }.store(in: &cancellabels)
  }
  
  private func updateData() {
    var snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()
    
    if let popular = viewModel.homeViewModels.popular {
      snapshot.appendSections([.popular])
      snapshot.appendItems(popular.1, toSection: .popular)
    }
    
    if let banner = viewModel.homeViewModels.banner {
      snapshot.appendSections([.banner])
      snapshot.appendItems(banner)
    }
    
    if let topRate = viewModel.homeViewModels.topRate {
      snapshot.appendSections([.topRate])
      snapshot.appendItems(topRate.1, toSection: .topRate)
    }
    
    if let upcoming = viewModel.homeViewModels.upcoming {
      snapshot.appendSections([.upcoming])
      snapshot.appendItems(upcoming.1, toSection: .upcoming)
    }
    
    dataSorce.apply(snapshot)
    
  }
  
  private func productItemCell(_ collectionView: UICollectionView,
                               _ indexPath: IndexPath,
                               _ movie: AnyHashable) -> UICollectionViewCell {
    guard let movie = movie as? Movie,
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeMovieCell.reuseableId, for: indexPath) as? HomeMovieCell else { return .init() }
    cell.setMovie(movie, rank: indexPath.item + 1)
    return cell
  }
  
  private func bannerItemCell(_ collectionView: UICollectionView,
                              _ indexPath: IndexPath,
                              _ imagePath: AnyHashable) -> UICollectionViewCell {
    guard let imagePath = imagePath as? String,
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeBannerCollectionViewCell.reuseableId, for: indexPath) as? HomeBannerCollectionViewCell else { return .init() }
    
    cell.setImagePath(imagePath)
    return cell
  }
}

extension HomeViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    switch Section(rawValue: indexPath.section) {
    case .banner:
      break
    case .popular:
      break
    case .topRate:
      break
    case .upcoming:
      break
    default: break
    }
  }
}
