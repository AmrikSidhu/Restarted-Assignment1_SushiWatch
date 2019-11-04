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
    
    var timer = 25
    var boosterLimit = 2
    var timeIsZero = 0
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    @IBOutlet weak var lblBooster: WKInterfaceLabel!
    
    
    
    @IBOutlet weak var lblGameOver: WKInterfaceLabel!
    
    
    
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
        self.lblGameOver.setHidden(true)
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
       func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
    
                let timerMessage = message["secondsRemaining"] as! Int
        let boosterFromPhone = message["booster"] as! Int
                //messageLabel.setText(messageBody)
                self.timer = timerMessage
                print("Status message from Phone = \(timerMessage)")
         print("BOOSTER: message from Phone = \(boosterFromPhone)")
        
        self.timeIsZero = timerMessage
        
        if (timeIsZero == 0)
        {
            self.lblGameOver.setHidden(false)
            self.lbltimerForWatch.setHidden(true)
        }
        else
        {
            self.lbltimerForWatch.setText("seconds: \(timeIsZero)")
        }
        
        if(boosterLimit != 0)
        {
            self.lblBooster.setText(" \(boosterFromPhone)")
            
            self.boosterLimit = self.boosterLimit - 1
            
        }
        if(boosterLimit == 0)
        {
            self.lblBooster.setHidden(true)
            self.lblBooster.setText(" \(0)")
        }
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
    
    @IBAction func btnClickBoost() {
        if(boosterLimit != 0)
        {
        
        if (WCSession.default.isReachable) {
                    print("Phone reachable")
                    let message = ["boosterGet": "get"]
                    WCSession.default.sendMessage(message, replyHandler: nil)
                    // output a debug message to the console
                    print("asking booster to phone")
            }
                else {
                    print("WATCH: Cannot reach phone")
                }
        
        print("booster Pressed!")
        
        
        }}
    
    @IBOutlet weak var lbltimerForWatch: WKInterfaceLabel!
    
    
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
