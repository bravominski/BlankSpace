//
//  ViewController.swift
//  Musical_Seats
//
//  Created by Steve T on 8/19/15.
//  Copyright © 2015 Steve T. All rights reserved.
//

import UIKit
import AVFoundation


class chairViewController: UIViewController {
    
    @IBOutlet weak var namesLabel: UILabel!
    
    var audioPlayer:AVAudioPlayer!
    var volume: Float = 0.0
    var playerString = ""
    
    let socket = SocketIOClient(socketURL: "https://blooming-cliffs-5704.herokuapp.com")
    var name = ""
    var userCanClick = false
    var arr = [0,0,0,0,0,0,0,0,0,0,0,0]
    var playerlist = [String]()
    
    func playMusic(){
        playSong()
        
        hideAll()
        for (var i = 0; i < playerlist.count-1; i++)
        {
            chairCollection[i].hidden = false
        }
        
        for (var i = 0; i < arr.count; i++)
        {
            arr[i] = 0
        }
        
        userCanClick = false
        
    }
    
    
    func stopMusic(){
        
        for (var i = 0; i < playerlist.count; i++)
        {
            chairCollection[i].backgroundColor = UIColor.yellowColor()
        }
        
        for var i = 0; i < arr.count; i++ {
            arr[i] = 1
        }
        print("music stopped")
        print(userCanClick)
        userCanClick = true
        print(userCanClick)
        ///stop music - pause///////////////////////////////////////////////////
        
        audioPlayer.pause()
        
        ////////////////////////////////////////////////////////////////////////
    }
    
    func updateTheView(){
        for (var i = 0; i < chairCollection.count; i++)
        {
            if (arr[i] == 0)
            {
                chairCollection[i].backgroundColor = UIColor.whiteColor()
            }
            if (arr[i] == 1)
            {
                chairCollection[i].backgroundColor = UIColor.yellowColor()
            }
            
        }
    }
    
    func hideAll(){
        for (var i = 0; i < chairCollection.count; i++)
        {
            chairCollection[i].hidden = true;
        }
    }
    
    
    @IBOutlet var chairCollection: [UIButton]!
    
    @IBAction func chairButton(sender: UIButton) {
        print(sender.tag)
        print(userCanClick)
        if userCanClick
        {
            if arr[sender.tag] == 1 {
                let info = ["name": name, "chairNumber": String(sender.tag)]
                socket.emit("chairClicked", info)
            
                userCanClick = false
            }
        }
    }
    
    

    func playSong() {
        //////start song ////////////////
    
        let audioFilePath1 = NSBundle.mainBundle().pathForResource("blankspace", ofType: "mp3")
    
        if audioFilePath1 != nil {
            
            let audioFileUrl1 = NSURL.fileURLWithPath(audioFilePath1!)
            
            audioPlayer = try! AVAudioPlayer(contentsOfURL: audioFileUrl1, fileTypeHint: nil)
            audioPlayer.play()
            
        } else {
            print("audio file is not found")
        }
        /////////////////////////////////
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = NSUserDefaults.standardUserDefaults()
        name = defaults.stringForKey("userName")!
        socket.connect()
        
        socket.on("connect") { data, ack in
            print("iOS::WE ARE USING SOCKETS!")
            self.socket.emit("userList")
        }
        
        
        
        socket.on("userList"){ data, ack in
            if let d = data{
                self.playerlist = d[0] as! [String]
                self.playerString = "Player List: "
                for (var i = 0; i < self.playerlist.count; i++)
                {
                    self.playerString += " " + self.playerlist[i]
                }
                
                self.namesLabel.text = self.playerString
            }
            
        }
        
        socket.on("newUser"){ data, ack in
            if let d = data{
                self.playerlist = d[0] as! [String]
            }
        }
        
        socket.on("startMusic"){data, ack in	
            self.playMusic()
        }
        
        socket.on("stopMusic"){data, ack in
            self.stopMusic()
        }
        
        socket.on("chairClicked"){data, ack in
            if let d = data{
                self.arr = d[0] as! [Int]
                self.updateTheView()
            }
        }
        
        socket.on("results") {data, ack in
            if let d = data{
                self.playerlist = d[0] as! [String]
                
                self.hideAll()
                
                for (var i = 0; i < self.playerlist.count-1; i++)
                {
                    self.chairCollection[i].hidden = false
                    self.chairCollection[i].backgroundColor = UIColor.whiteColor()
                }
                
                var check = false
                
                self.playerString = "Survivor list of this round:"
                for (var i = 0; i < self.playerlist.count; i++)
                {
                    self.playerString += " " + self.playerlist[i]
                }
                
                self.namesLabel.text = self.playerString
                
                for( var i = 0; i < self.playerlist.count; i++){
                    if (self.name == self.playerlist[i])
                    {
                        check = true
                    }
                    
                }
                
                if check == false {
                    for(var j = 0; j < self.chairCollection.count; j++){
                        self.chairCollection[j].enabled = false
                    }
                }
                
            }
        
        }
        
        socket.on("reset"){data, ack in
            self.playerlist = []
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

