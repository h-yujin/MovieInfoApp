//
//  LoadingIndicator.swift
//  MovieInfo
//
//  Created by Hong yujin on 3/7/24.
//

import UIKit

class LoadingIndicator {
  
  static let shared = LoadingIndicator()
  
  private var indicator: UIActivityIndicatorView
  private var view: UIView?
  
  private init() {
    self.indicator = UIActivityIndicatorView(style: .large)
    self.indicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
    self.indicator.center = CGPoint(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
    self.indicator.color = .indicator
    self.indicator.hidesWhenStopped = true
  }
  
  func start(on view: UIView?) {
    self.view = view
    self.view?.addSubview(self.indicator)
    DispatchQueue.main.async {
      self.indicator.startAnimating()
    }
  }
  
  func stop() {
    DispatchQueue.main.async {
      self.indicator.stopAnimating()
      self.view?.subviews.forEach({ view in
        if view == self.view {
          view.removeFromSuperview()
        }
      })
    }
  }
}
