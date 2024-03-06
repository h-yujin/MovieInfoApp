//
//  Date+extension.swift
//  MovieInfo
//
//  Created by Hong yujin on 3/6/24.
//

import Foundation

extension Date {
  
  var toReleaseDateString: String {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "ko_KR")
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter.string(from: self)
  }
  
  
}
extension String {
  var toReleaseDate: Date? {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "ko_KR")
    formatter.dateFormat = "yyyy.MM.dd"
    return formatter.date(from: self)
  }
}
