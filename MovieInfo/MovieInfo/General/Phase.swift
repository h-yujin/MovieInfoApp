//
//  Phase.swift
//  MovieInfo
//
//  Created by Hong yujin on 3/7/24.
//

import Foundation

enum Phase {
  case notRequested
  case loading
  case success
  case fail(error: Error)
}
