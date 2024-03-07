//
//  NavigationSearchBar.swift
//  MovieInfo
//
//  Created by Hong yujin on 3/7/24.
//

import UIKit

class NavigationSearchBar: UISearchBar {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  convenience init(_ placeholder: String) {
    self.init(frame: .zero)
    let width = UIScreen.main.bounds.size.width
    self.frame = CGRect(x: 0, y: 0, width: width - 28, height: 0)
    self.placeholder = placeholder
    self.showsCancelButton = true
    self.becomeFirstResponder()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
