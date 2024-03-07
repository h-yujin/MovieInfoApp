//
//  HomeBannerCollectionViewCell.swift
//  MovieInfo
//
//  Created by Hong yujin on 3/6/24.
//


import UIKit
import Kingfisher

final class HomeBannerCollectionViewCell: UICollectionViewCell {
  static let reuseableId: String = "HomeBannerCollectionViewCell"
  
  @IBOutlet private weak var imageView: UIImageView!

  func setImagePath(_ imagePath: String) {
    imageView.kf.setImage(with: URL(string: imagePath))
  }
}

extension HomeBannerCollectionViewCell {
  static func bannerLayout() -> NSCollectionLayoutSection {
    let itemSize: NSCollectionLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
    let item: NSCollectionLayoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
    
    let groupSize: NSCollectionLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(100 / 393))
    let group: NSCollectionLayoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    
    let section = NSCollectionLayoutSection(group: group)
    section.orthogonalScrollingBehavior = .groupPaging
    section.contentInsets = .init(top: 10, leading: 0, bottom: 0, trailing: 0)
    
    return section
  }
}
