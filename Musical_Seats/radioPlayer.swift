//
//  radioPlayer.swift
//  Musical_Seats
//
//  Created by Steve T on 8/19/15.
//  Copyright © 2015 Steve T. All rights reserved.
//

import Foundation
import AVFoundation

class RadioPlayer {
    static let sharedInstance = RadioPlayer()
    private var player = AVPlayer(URL: NSURL(string: "http://www.radiobrasov.ro/listen.m3u")!) //can change this to a different radio station possibly an array of stations
    private var isPlaying = false
    
    func play() {
        player.play()
        isPlaying = true
    }
    
    func pause() {
        player.pause()
        isPlaying = false
    }
    
    func toggle() {
        if isPlaying == true {
            pause()
        } else {
            play()
        }
    }
    
    func currentlyPlaying() -> Bool {
        return isPlaying
    }
}
