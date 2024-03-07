//
//  UIImage+extension.swift
//  MovieInfo
//
//  Created by Hong yujin on 3/6/24.
//

import UIKit


extension UIImage {
  func createBarButtonItem() -> UIBarButtonItem {
    let imageView = UIImageView()
    imageView.image = self
    imageView.contentMode = .scaleAspectFill
    imageView.clipsToBounds = true
    imageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
    imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
    return UIBarButtonItem(customView: imageView)
  }
}
