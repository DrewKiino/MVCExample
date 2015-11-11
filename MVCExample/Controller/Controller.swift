//
//  Controller.swift
//  UIPrototype
//
//  Created by Andrew Aquino on 11/8/15.
//  Copyright © 2015 Kiino. All rights reserved.
//

import Foundation
import SwiftyTimer

/**
 The controller handles business-side logic
*/
public class Controller {
  
  // the model that the controller can READ and WRITE to
  public let model = Model()
  
  init() {
    // this represents the manipulation of the model's data
    NSTimer.every(10.0) { [unowned self] in
      self.model.users = self.model.users.map { user -> User in
        let random = Float(arc4random()) / Float(UINT32_MAX)
        if random > 0.8 {
          user.name = "Foo"
        } else if random > 0.3 {
          user.name = "Bar"
        }
        return user
      }
    }
    // this represents the model's data being discarded
    NSTimer.every(4.0) { [unowned self] in
      if !self.model.users.isEmpty {
        self.model.users.removeFirst()
      }
    }
  }
  
  public func addName(name: String?) {
    if let name = name {
      // this represents the asynchronous manipulation of the
      // model's data using the data given by the user's interaction 
      // with the view
      NSTimer.after(3.0) { [unowned self] in
        let user = User()
        user.name = "Hi, \(name)!"
        self.model.users.append(user)
      }
    }
  }
}
