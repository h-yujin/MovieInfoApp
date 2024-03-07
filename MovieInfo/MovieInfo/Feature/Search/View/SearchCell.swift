//
//  SearchCell.swift
//  MovieInfo
//
//  Created by Hong yujin on 3/7/24.
//

import UIKit

class SearchCell: UITableViewCell {
  static let reuseableId: String = "SearchCell"
  
  @IBOutlet weak var posterImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var overviewLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
  }
  
  func setMovie(_ movie: Movie) {
    posterImageView.kf.setImage(with: URL(string: movie.thumbnailImagePath))
    titleLabel.text = movie.title
    dateLabel.text = movie.release_date?.toReleaseDate?.toReleaseDateString ?? "-"
    overviewLabel.text = movie.overview
  }
}
