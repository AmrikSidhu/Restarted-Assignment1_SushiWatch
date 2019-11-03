//
//  InterfaceController.swift
//  sushiWatch Extension
//
//  Created by Z Angrazy Jatt on 2019-11-03.
//  Copyright © 2019 Parrot. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


class InterfaceController: WKInterfaceController, WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        
        if WCSession.isSupported() {
            print("Watch is supporting WCSession")
            WCSession.default.delegate = self
            WCSession.default.activate()
            print("Session is Activated")
        }
        else {
            print("Watch WCSession error!")
        }
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @IBAction func btnRightClicked() {
        if (WCSession.default.isReachable) {
            print("phone reachable")
            let message = ["movingTo": "right"]
            WCSession.default.sendMessage(message, replyHandler: nil)
            // output a debug message to the console
            print("sent move right to phone")
        }
        else {
            print("WATCH: Cannot reach phone")
        }
    }
    
    @IBAction func btnLeftClicked() {
        if (WCSession.default.isReachable) {
            print("phone reachable")
            let message = ["movingTo": "left"]
            WCSession.default.sendMessage(message, replyHandler: nil)
            // output a debug message to the console
            print("sent move left to phone")
        }
        else {
            print("WATCH: Cannot reach phone")
        }
    }
    
}
