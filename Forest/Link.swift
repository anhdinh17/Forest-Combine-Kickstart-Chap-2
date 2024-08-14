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
      // If we use .dropFirst, when app starts, $model at first will have value = 0
      // it will omit the 0 => .sink {} ko chạy (đặt break point) lần đầu
      // => cả đống subscriber and publishers này ko broadcast gì hết
      // => content sẽ có giá trị nil và broadcast cho VC
      //
      // Nhưng vì dòng tiếp theo trong init() set content = ...
      // => content sẽ broadcast ... to VC
      //
      // Thử bỏ dòng content = ... thì sẽ hiểu content sẽ send nil tới VC nếu dùng .dropfirst()
      //
      // Nếu ko dùng .dropFirst() thì đầu tiên trong init() cái func này chạy
      // => broadcast initial value của Model là 0 => content = 0 và send tới VC
      // nhưng vì dòng tiếp theo trong init() lại set content = ... nên VC vẫn sẽ nhận ...
      .dropFirst()
      .map(\.value)
      // Use our custom operator to convert Output to String
      .description()
      .sink {[weak self] string in
        self?.contents = string
      }
  }
}
