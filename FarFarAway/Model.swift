//
//  File.swift
//  FarFarAway
//
//  Created by Anh Dinh on 7/13/24.
//

import Foundation

public class Model {
    @Published public private(set) var value = 0
    
    public init() {}
}

extension Model {
  public func next() {
    value = Int.random(in: 1...100)
  }
}
