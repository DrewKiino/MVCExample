//
//  Model.swift
//  UIPrototype
//
//  Created by Andrew Aquino on 11/8/15.
//  Copyright © 2015 Kiino. All rights reserved.
//

import Foundation
import Signals

/**
 The model handles data storage and changes
*/
public class Model {
  // this variable allows real time closure execution on data change
  public let _users = Signal<[User]>()
  // this variable allows the controller to read and write to
  // any changes to this variable. On write, this variable will fire
  // the new changes to the Signal variable which will then execute 
  // real time callbacks for any listeners subscribed to the signal variable
  // this two-step approach allows for real time data watching
  // with READ and WRITE capabilities.
  public var users: [User] = [] { didSet { _users => users } }
}

public class User {
  public let _name = Signal<String>()
  public var name: String = "" { didSet { _name => name  } }
}