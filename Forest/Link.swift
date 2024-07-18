//
//  Link.swift
//  Forest
//
//  Created by Anh Dinh on 7/18/24.
//

import Foundation
import FarFarAway
import Combine

class Link {
    private let state = State()
    @Published private(set) var contents: String?
    private var cancellables: Set<AnyCancellable> = Set()
    
    init() {
        contentsSubscription().store(in: &cancellables)
        self.contents = "..."
    }
}

extension Link {
  func next() {
    state.next()
  }
}

extension Link {
  func contentsSubscription() -> AnyCancellable {
    state.$model
      .dropFirst()
      .map(\.value.description)
      .sink {[weak self] string in
        self?.contents = string
      }
  }
}
