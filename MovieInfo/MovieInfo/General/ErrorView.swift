//
//  ErrorView.swift
//  MovieInfo
//
//  Created by Hong yujin on 3/7/24.
//

import UIKit
import Lottie

class ErrorView: UIView {
  
  var rootView: UIView?
  
  private var errorLabel: UILabel = {
    let label: UILabel = UILabel()
    label.font = .systemFont(ofSize: 16)
    label.textColor = .black
    label.numberOfLines = 0
    label.textAlignment = .center
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  private var lottieView = LottieAnimationView(name: "error")
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  convenience init(on view: UIView?, errorText: String) {
    self.init(frame: view?.frame ?? .zero)
    rootView = view
    errorLabel.text = errorText
    commonInit()
  }
  
  private func commonInit() {
    rootView?.addSubview(self)
    
    lottieView.loopMode = .loop
    lottieView.contentMode = .scaleAspectFit
    lottieView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    lottieView.translatesAutoresizingMaskIntoConstraints = false
    
    
    addSubview(lottieView)
    addSubview(errorLabel)
    
    self.lottieView.play()
  }

  
  override func updateConstraints() {

    NSLayoutConstraint.activate([

      lottieView.centerXAnchor.constraint(equalTo: centerXAnchor),
      lottieView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -30),
      lottieView.widthAnchor.constraint(equalToConstant: 200),
      lottieView.heightAnchor.constraint(equalToConstant: 200),
      
      errorLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
      errorLabel.topAnchor.constraint(equalTo: lottieView.bottomAnchor, constant: 5),
      errorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
      errorLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
    ])
    
    super.updateConstraints()
  }
  
}

