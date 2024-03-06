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
  
  private var viewModel: HomeViewModel = HomeViewModel()
  private var cancellabels: Set<AnyCancellable> = []
  
  enum HomeSection: Int {
    case popular
    case banner
  }

  
  override func viewDidLoad() {
    super.viewDidLoad()
    bindViewModel()
  }

}

extension HomeViewController {
  private func bindViewModel() {
    viewModel.process(action: .loadData)
  }
}

