//
//  HomePopularCell.swift
//  MovieInfo
//
//  Created by Hong yujin on 3/6/24.
//

import UIKit
import Kingfisher

class HomePopularCell: UICollectionViewCell {
  static let reusableId: String = "HomePopularCell"
  
  @IBOutlet weak var posterImageView: UIImageView!
  @IBOutlet weak var numberLabel: UILabel!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    self.layer.cornerRadius = 10
    self.posterImageView.layer.cornerRadius = 10
  }
  
  func setMovie(_ movie: Movie, rank: Int) {
    posterImageView.kf.setImage(with: URL(string: movie.thumbnailImagePath))
    numberLabel.text = "\(rank)"
    titleLabel.text = movie.title
    dateLabel.text = movie.release_date.toReleaseDate?.toReleaseDateString ?? "-"
  }
}

extension HomePopularCell {
  static func homePopularLayout() -> NSCollectionLayoutSection {
    let itemSize: NSCollectionLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
    let item: NSCollectionLayoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
    
    let groupSize: NSCollectionLayoutSize = NSCollectionLayoutSize(widthDimension: .absolute(117), heightDimension: .estimated(224))
    let group: NSCollectionLayoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    
    let section = NSCollectionLayoutSection(group: group)
    section.orthogonalScrollingBehavior = .continuous
    section.contentInsets = .init(top: 40, leading: 33, bottom: 0, trailing: 33)
    section.interGroupSpacing = 10
    return section
  }
}
