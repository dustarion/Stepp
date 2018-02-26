//
//  igloohome.swift
//  igloo
//
//  Created by Roy Tay on 24/2/18.
//  Copyright © 2018 ζauri. All rights reserved.

import Foundation


/*
 To call a duration pin of 3 hours :
    igloo(get: .duration, from: Date(), forDuration: 3) { (pin) in
        print(pin)
    }
 */

func igloo(get: iglooPinType, from: Date? = nil, forDuration: TimeInterval = 0, completion: @escaping(String) -> ()) {
    var url: URL
    let duration = forDuration * 60 * 60

    switch(get) {
    case .otp:
        url = URL(string: "https://hackathon.iglooho.me/IGHACK-3510/otp")!
    case .permanent:
        url = URL(string: "https://hackathon.iglooho.me/IGHACK-3510/permanent")!
    case .duration:
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH"
        
        let fromString = dateFormatter.string(from: from!) + ":00:00"
        let toString = dateFormatter.string(from: (from! + duration)) + ":00:00"
        
        url = URL(string: "https://hackathon.iglooho.me/IGHACK-3510/duration?startDate=" + fromString + "&endDate=" + toString)!
        
    }
    
    var request = URLRequest(url: url)
    request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    request.httpMethod = "POST"
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data, error == nil else {
            print("error=\(error)")
            return
        }
        
        if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
            print("statusCode should be 200, but is \(httpStatus.statusCode)")
            print("response = \(response)")
        }
        
        let responseString = String(data: data, encoding: .utf8)
        print("responseString = \(responseString)")
        
        let pin = responseString!.split(separator: "\"")[3]
        completion(String(pin))
    }
    task.resume()
}

enum iglooPinType {
    case otp
    case permanent
    case duration
}
