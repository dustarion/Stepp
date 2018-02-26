//
//  alert.swift
//  Stepp
//
//  Created by Dalton Ng on 24/2/18.
//  Copyright © 2018 AppsLab. All rights reserved.
//

import Foundation
import UIKit
import SwiftySound

func displayAlert(view : UIView) -> Void {
    // Sound the alarm
    Sound.play(file: "alarm.wav")
    
    // TODO: Create a more elegant solution to display alerts.
    // Temporary solution, using a uiimage nested onto a uiview and a label.
    
    // Get main screen bounds
    let screenSize: CGRect = UIScreen.main.bounds
    let screenWidth = screenSize.width
    let screenHeight = screenSize.height
    
    let alertView = UIView(frame: CGRect(x: 0, y: screenHeight, width: screenWidth, height: screenHeight))
    
    let alertBackgroundView = UIImageView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
    alertBackgroundView.image = #imageLiteral(resourceName: "AlertFallDetected")
    alertBackgroundView.contentMode = .scaleAspectFill
    
    let textLabel = UILabel(frame: CGRect(x: 0, y: 593, width: screenWidth, height: 110))
    textLabel.textColor = UIColor.red
    textLabel.backgroundColor = UIColor.clear
    textLabel.textAlignment = .center
    textLabel.font =  UIFont (name: "AvenirNext-DemiBold", size: 80)
    textLabel.text = "5"
    
    alertView.addSubview(alertBackgroundView)
    alertView.addSubview(textLabel)
    
    print("Fall Detected Alert Shown")
    view.addSubview(alertView)
    
    UIView.animate(withDuration: 1) {
        alertView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
    }
    
    for i in 0..<5 {
        let countDown = 5 - i
        print(i, countDown)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(i), execute: {
            textLabel.text = String(countDown)
        })
    }
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 6, execute: {
        textLabel.text = "SENDING LOCATION..."
        alertBackgroundView.image = #imageLiteral(resourceName: "AlertSendingLocation")
        igloo(get: .duration, from: Date(), forDuration: 3) { (pin) in
            print(pin)
            let message = "Ah Gong fell down in the bathroom. Your 3 hour code : " + pin
            print(message)
            sendSms(message: message, ReciepientNumber: GlobalConstants.royNumber)
            sendSms(message: message, ReciepientNumber: GlobalConstants.testNumber)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                textLabel.text = "SENT!"
            })
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                alertView.removeFromSuperview()
                Sound.stopAll()
            })
        }
    })
    DispatchQueue.main.asyncAfter(deadline: .now() + 14, execute: {
        Sound.stopAll()
    })
}
