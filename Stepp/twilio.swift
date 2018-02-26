//
//  twilio.swift
//  Stepp
//
//  Created by Dalton Ng on 23/2/18.
//  Copyright © 2018 AppsLab. All rights reserved.
//

import Foundation

func sendSms(message: String, ReciepientNumber: String) -> Void {
    let twilioSID = GlobalConstants.twilioSID
    let twilioSecret = GlobalConstants.twilioSecret
    
    print("Sending SMS using Twilio API")
    
    if ((message == "") && (ReciepientNumber == "")) {
        // Either the message field or toNumber field is empty, prevent a crash and notify the developer of the error.
        print ("Unable to send SMS. Reason : Message or Number value is nil.")
    } else {
        // Neither field is blank, proceeding to send SMS
        let fromNumber = GlobalConstants.fromNumber
        let toNumber = "\("%2B65%20") \(ReciepientNumber)"
        print ("Sending SMS to : \(toNumber)")
        
        let request = NSMutableURLRequest(url: NSURL(string:"https://\(twilioSID):\(twilioSecret)@api.twilio.com/2010-04-01/Accounts/\(twilioSID)/Messages")! as URL)
        request.httpMethod = "POST"
        request.httpBody = "From=\(fromNumber)&To=\(toNumber)&Body=\(message)".data(using: String.Encoding.utf8)
        
        // Build the completion block and send the request
        URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
            print("Finished")
            if let data = data, let responseDetails = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                // Success
                print("Sent SMS!")
                print("Response: \(responseDetails)")
            } else {
                // Failure
                print("Failed to Send SMS!")
                print("Error: \(String(describing: error))")
            }
        }).resume()
    }
}
