//
//  registerViewController.swift
//  Musical_Seats
//
//  Created by Steve T on 8/19/15.
//  Copyright © 2015 Steve T. All rights reserved.
//

import UIKit

var canRegister = true

class registerViewController: UIViewController {
    
    let socket = SocketIOClient(socketURL: "https://blooming-cliffs-5704.herokuapp.com")

    @IBOutlet weak var textField: UITextField!
    
    @IBAction func registerButton(sender: UIButton) {
        if canRegister {
            socket.emit("newUser", textField.text!)
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setObject(textField.text!, forKey: "userName")
            canRegister = false
            textField.text = ""
        }
        view.endEditing(true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        socket.connect()
    }
}