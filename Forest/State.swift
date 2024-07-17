//
//  State.swift
//  Forest
//
//  Created by Anh Dinh on 7/17/24.
//

import Foundation

public class State {
  @Published public private(set) var model = Model()
  
  public init() {}
}

extension State {
  public func next() {
    model = model.next
  }
}
