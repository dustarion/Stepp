//
//  eventHappening.swift
//  Stepp
//
//  Created by Dalton Ng on 23/2/18.
//  Copyright © 2018 AppsLab. All rights reserved.
//

import Foundation
import UIKit

func eventHappening(Event: String, View: ViewController) -> Void {
    //test.character(at: 10)
    //test[10...12]
    // Black Orange Red Blue
    
    if(Event == "") {
        return
    }
    
    let tileCode = Event[2...3]
    let eventCode = Event.character(at: 0)
    
    // Event : Someone steps on a tile, send seperately if multiple people are standing on different tiles
    if (eventCode == "s") {
        print("Stepped : ", tileCode)
        View.setTile(tile: String(tileCode), colour: "Orange")
    }
        
        // Event : Someone steps off a tile, send seperately if multiple people are standing on different tiles
    else if (eventCode == "r") {
        print("Released : ", tileCode)
        View.setTile(tile: String(tileCode), colour: "Black")
    }
        
        // Event : Someone falls, send the location of each tile the person has fallen on seperately
    else if (eventCode == "f") {
        print("Fell : ", tileCode)
        View.performSegue(withIdentifier: "fallAlert", sender: nil)
    }
        
        // Event : Water Detected, send the location of each tile seperately, or in this case only the center tile has water sensor
    else if (eventCode == "w") {
        print("Water : ", tileCode)
        View.setTile(tile: String(tileCode), colour: "Blue")
    }
        
        //Event : No Water Detected anymore,
    else if (eventCode == "d") {
        print("Dry : ", tileCode)
        View.setTile(tile: String(tileCode), colour: "Black")
    }
    else {
        print("Error Unknown Event : ", eventCode ?? "nil")
    }
}
