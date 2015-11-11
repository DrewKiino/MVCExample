//
//  ViewController2.swift
//  UIPrototype
//
//  Created by Andrew Aquino on 11/8/15.
//  Copyright © 2015 Kiino. All rights reserved.
//

import Foundation
import UIKit

/**
 The view handles the representation of data given by the model
*/
public class View: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
  
  private var label: UILabel?
  private var textField: UITextField?
  private var button: UIButton?
  private var tableView: UITableView?
  
  // the controller the will handle the view's logic
  private let controller = Controller()
  // the model whose data the view will represent
  private unowned var model: Model { get { return controller.model } }
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    setupListeners()
  }
  
  private func setupListeners() {
    model._users.listen(self) { [unowned self] names in
      self.tableView?.reloadData()
    }
  }
  
  private func setupUI() {
    textField = UITextField(frame: CGRectMake(0, 100, 200, 48))
    textField?.backgroundColor = UIColor.greenColor()
    textField?.delegate = self
    view.addSubview(textField!)
    
    label = UILabel(frame: CGRectMake(24, 24, 248, 48))
    label?.backgroundColor = UIColor.lightGrayColor()
    label?.text = "type something in the green bar"
    view.addSubview(label!)
    
    button = UIButton(frame: CGRectMake(200, 100, 200, 48))
    button?.backgroundColor = UIColor.grayColor()
    button?.addTarget(self, action: "addName", forControlEvents: .TouchUpInside)
    button?.setTitle("press me to add input!", forState: .Normal)
    view.addSubview(button!)
    
    tableView = UITableView(frame: CGRectMake(0, 200, 400, 400))
    tableView?.backgroundColor = UIColor.yellowColor()
    tableView?.delegate = self
    tableView?.dataSource = self
    view.addSubview(tableView!)
  }
  
  // on button press, the view will pass the user data to the controller
  // the controller will then handle the view's data and manipulate it accordingly
  // the data will then be passed off to the model and any changes in the model
  // will change the view's representation of the data all in real time.
  public func addName() {
    controller.addName(textField?.text)
    if let textField = textField, let name = textField.text {
      label?.text = "adding new name: \(name)"
    }
  }
  
  public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // the table view rows are dependent on the model's user count
    return model.users.count
  }
  
  public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
    // assign the cell's text the user's name
    cell.textLabel?.text = model.users[indexPath.row].name
    // subscribe the cell's text to listen for changes in the user's name
    model.users[indexPath.row]._name.listen(self) { [weak cell] name in
      cell?.textLabel?.text = name
    }
    return cell
  }
  
  public func textFieldShouldReturn(textField: UITextField) -> Bool {
    textField.endEditing(true)
    return false
  }
}
