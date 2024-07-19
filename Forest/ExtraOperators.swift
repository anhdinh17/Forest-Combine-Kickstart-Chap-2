//
//  ExtraOperators.swift
//  Forest
//
//  Created by Anh Dinh on 7/19/24.
//

import Foundation
import Combine

extension Publisher where Output: CustomStringConvertible {
    func description() -> Publishers.Map<Self, String> {
        return map(\.description)
        // This equals .map { valueFromUpStream in
        // valueFromUpStream.description
        // }
        // valueFromupStream has to be a String
    }
    
    func descriptionAsOptional() -> Publishers.Map<Self, String?> {
        // convert String to Optional String
        map{.some($0.description)}
    }
}
