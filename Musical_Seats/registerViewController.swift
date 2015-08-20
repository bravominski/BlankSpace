//
//  registerViewController.swift
//  Musical_Seats
//
//  Created by Steve T on 8/19/15.
//  Copyright © 2015 Steve T. All rights reserved.
//

import UIKit

/////inputing name into table via text field///////

var people = ["Alex", "Minsu", "Steve"]

class registerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var textField: UITextField!

    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func registerButton(sender: UIButton) {
        print("hello")
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    // what cell should I display for each row?
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // dequeue the cell from our storyboard
        let cell = tableView.dequeueReusableCellWithIdentifier("MyCell")!
        
//cell.textLabel?.text = people[indexPath.row].objective as! String
        
        for var i = 0; i < people.count; i++ {
            cell.textLabel?.text = people[i]
        }

        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {

        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.dataSource = self
//        tableView.delegate = self
        
    }
}