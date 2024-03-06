//
//  HomeHeaderCollectionReusableView.swift
//  MovieInfo
//
//  Created by Hong yujin on 3/6/24.
//

import UIKit


final class HomeHeaderCollectionReusableView: UICollectionReusableView {
  static let reuseableId: String = "HomeHeaderCollectionReusableView"
  
  @IBOutlet private weak var headerLabel: UILabel!
  
  func setTitle(_ title: String) {
    headerLabel.text = title
  }
}
