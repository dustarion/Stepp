//
//  ViewController.swift
//  Stepp
//
//  Created by Dalton Ng on 6/2/18.
//  Copyright © 2018 AppsLab. All rights reserved.
//

import UIKit
import CoreBluetooth
import SwiftySound

class ViewController: UIViewController, CBCentralManagerDelegate, CBPeripheralDelegate  {
    
    // Setting Up Bluetooth
    var btManager: CBCentralManager!
    var theThing: CBPeripheral!
    
    // bt characteristics
    let uartSV = CBUUID(string: "6e400001-b5a3-f393-e0a9-e50e24dcca9e")
    let uartTX = CBUUID(string: "6e400002-b5a3-f393-e0a9-e50e24dcca9e")
    let uartRX = CBUUID(string: "6e400003-b5a3-f393-e0a9-e50e24dcca9e")
    
    var txResponse: CBCharacteristic!
    var rxResponse: CBCharacteristic!
    
    // Define The Outlets that form our 3 by 3 grid
    @IBOutlet weak var A1: UIImageView!
    @IBOutlet weak var A2: UIImageView!
    @IBOutlet weak var A3: UIImageView!
    @IBOutlet weak var B1: UIImageView!
    @IBOutlet weak var B2: UIImageView!
    @IBOutlet weak var B3: UIImageView!
    @IBOutlet weak var C1: UIImageView!
    @IBOutlet weak var C2: UIImageView!
    @IBOutlet weak var C3: UIImageView!
    @IBOutlet weak var A1Left: UIImageView!
    @IBOutlet weak var A2Left: UIImageView!
    @IBOutlet weak var A3Left: UIImageView!
    @IBOutlet weak var A3Right: UIImageView!
    @IBOutlet weak var B3Right: UIImageView!
    @IBOutlet weak var C3Right: UIImageView!
  
    // Define Other Outlets
    
    @IBAction func FallAlertTest(_ sender: Any) {
        self.performSegue(withIdentifier: "fallAlert", sender: nil)
    }
    
    
    
    
    
    
    var previousTile = ""
    
    
    
    
    // Set Status Bar as Light
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidAppear(_ animated: Bool) {
        print("IS OUR OUTLET HERE", A1)
        //A1.image = #imageLiteral(resourceName: "TileTopRed")
        var timer = Timer.scheduledTimer(timeInterval: 0.5,
                                         target: self,
                                         selector: #selector(self.updateTime),
                                         userInfo: nil,
                                         repeats: true)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

       print("IS OUR OUTLET HERE", A1)
        //A1.image = #imageLiteral(resourceName: "TileTopRed")
       
        
        
        
        // Set Background Image as a gradiented PDF from Assets.Xcassets
        self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "Background"))
        
        // Set up bluetooth manager
        btManager = CBCentralManager(delegate: self, queue: nil)
        
        // Cancel any Alarms giving everyone ear rape
        Sound.stopAll()
    }
    
    @objc func updateTime() {
        if(rxResponse != nil) {
            print("attempting update")
            self.uart(action: .write, write: "")
            self.uart(action: .read)
        }
    }
    
    @IBAction func Walk(_ sender: Any) {
       
        uart(action: .write, write: "1")
    }
    
    func delayWithSeconds(_ seconds: Double, completion: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            completion()
        }
    }

    func setTile(tile: String, colour: String) -> Void {
        print(A1)
        
        if(A1 == nil || A2 == nil || A3 == nil || B1 == nil || B2 == nil || B3 == nil || C1 == nil || C2 == nil || C3 == nil) {
            return
        }
        
        // Possible Tiles Being : A1, A2, A3, B1, B2, B3, C1, C2, C3
        // Possible Colours Being : Black, Orange, Red, Blue
        
        // Check for Nil Values First
        if ((tile == "")&&(colour == "")) {
            print ("Error : Cannot Accept Nil Values")
        }
        
        //Tile A1
        else if (tile == "A1") {
            // Set Tile Attributes to Black
            if (colour == "Black") {
                A1.image = #imageLiteral(resourceName: "TileTop")
                A1Left.image = #imageLiteral(resourceName: "TileLeftWall")
            }
            
            // Set Tile Attributes to Orange
            else if (colour == "Orange") {
                A1.image = #imageLiteral(resourceName: "TileTopOrange")
                A1Left.image = #imageLiteral(resourceName: "TileLeftWallOrange")
            }
            
            // Set Tile Attributes to Red
            else if (colour == "Red") {
                A1.image = #imageLiteral(resourceName: "TileTopRed")
                A1Left.image = #imageLiteral(resourceName: "TileLeftWallRed")
            }
            
            // Set Tile Attributes to Blue
            else if (colour == "Blue") {
                A1.image = #imageLiteral(resourceName: "TileTopBlue")
                A1Left.image = #imageLiteral(resourceName: "TileLeftWallBlue")
            }
            
            else {
                NSLog("Invalid Colour : %@", colour)
            }
        }
        
        //Tile A2
        else if (tile == "A2") {
            // Set Tile Attributes to Black
            if (colour == "Black") {
                A2.image = #imageLiteral(resourceName: "TileTop")
                A2Left.image = #imageLiteral(resourceName: "TileLeftWall")
            }
                
                // Set Tile Attributes to Orange
            else if (colour == "Orange") {
                A2.image = #imageLiteral(resourceName: "TileTopOrange")
                A2Left.image = #imageLiteral(resourceName: "TileLeftWallOrange")
            }
                
                // Set Tile Attributes to Red
            else if (colour == "Red") {
                A2.image = #imageLiteral(resourceName: "TileTopRed")
                A2Left.image = #imageLiteral(resourceName: "TileLeftWallRed")
            }
                
                // Set Tile Attributes to Blue
            else if (colour == "Blue") {
                A2.image = #imageLiteral(resourceName: "TileTopBlue")
                A2Left.image = #imageLiteral(resourceName: "TileLeftWallBlue")
            }
                
            else {
                NSLog("Invalid Colour : %@", colour)
            }
        }
        
        //Tile A3
        else if (tile == "A3") {
            // Set Tile Attributes to Black
            if (colour == "Black") {
                A3.image = #imageLiteral(resourceName: "TileTop")
                A3Left.image = #imageLiteral(resourceName: "TileLeftWall")
                A3Right.image = #imageLiteral(resourceName: "TileRightWall")
            }
                
                // Set Tile Attributes to Orange
            else if (colour == "Orange") {
                A3.image = #imageLiteral(resourceName: "TileTopOrange")
                A3Left.image = #imageLiteral(resourceName: "TileLeftWallOrange")
                A3Right.image = #imageLiteral(resourceName: "TileRightWallOrange")
            }
                
                // Set Tile Attributes to Red
            else if (colour == "Red") {
                A3.image = #imageLiteral(resourceName: "TileTopRed")
                A3Left.image = #imageLiteral(resourceName: "TileLeftWallRed")
                A3Right.image = #imageLiteral(resourceName: "TileRightWallRed")
            }
                
                // Set Tile Attributes to Blue
            else if (colour == "Blue") {
                A3.image = #imageLiteral(resourceName: "TileTopBlue")
                A3Left.image = #imageLiteral(resourceName: "TileLeftWallBlue")
                A3Right.image = #imageLiteral(resourceName: "TileRightWallBlue")
            }
                
            else {
                NSLog("Invalid Colour : %@", colour)
            }
        }
        
        //Tile B1
        else if (tile == "B1") {
            // Set Tile Attributes to Black
            if (colour == "Black") {
                B1.image = #imageLiteral(resourceName: "TileTop")
            }
                
                // Set Tile Attributes to Orange
            else if (colour == "Orange") {
                B1.image = #imageLiteral(resourceName: "TileTopOrange")
            }
                
                // Set Tile Attributes to Red
            else if (colour == "Red") {
                B1.image = #imageLiteral(resourceName: "TileTopRed")
            }
                
                // Set Tile Attributes to Blue
            else if (colour == "Blue") {
                B1.image = #imageLiteral(resourceName: "TileTopBlue")
            }
                
            else {
                NSLog("Invalid Colour : %@", colour)
            }
        }
        
        //Tile B2
        else if (tile == "B2") {
            // Set Tile Attributes to Black
            if (colour == "Black") {
                B2.image = #imageLiteral(resourceName: "TileTop")
            }
                
                // Set Tile Attributes to Orange
            else if (colour == "Orange") {
                B2.image = #imageLiteral(resourceName: "TileTopOrange")
            }
                
                // Set Tile Attributes to Red
            else if (colour == "Red") {
                B2.image = #imageLiteral(resourceName: "TileTopRed")
            }
                
                // Set Tile Attributes to Blue
            else if (colour == "Blue") {
                B2.image = #imageLiteral(resourceName: "TileTopBlue")
            }
                
            else {
                NSLog("Invalid Colour : %@", colour)
            }
        }
        
        //Tile B3
        else if (tile == "B3") {
            // Set Tile Attributes to Black
            if (colour == "Black") {
                B3.image = #imageLiteral(resourceName: "TileTop")
                B3Right.image = #imageLiteral(resourceName: "TileRightWall")
            }
                
                // Set Tile Attributes to Orange
            else if (colour == "Orange") {
                B3.image = #imageLiteral(resourceName: "TileTopOrange")
                B3Right.image = #imageLiteral(resourceName: "TileRightWallOrange")
            }
                
                // Set Tile Attributes to Red
            else if (colour == "Red") {
                B3.image = #imageLiteral(resourceName: "TileTopRed")
                B3Right.image = #imageLiteral(resourceName: "TileRightWallRed")
            }
                
                // Set Tile Attributes to Blue
            else if (colour == "Blue") {
                B3.image = #imageLiteral(resourceName: "TileTopBlue")
                B3Right.image = #imageLiteral(resourceName: "TileRightWallBlue")
            }
                
            else {
                NSLog("Invalid Colour : %@", colour)
            }
        }
            
        // Tile C1
        else if (tile == "C1") {
            // Set Tile Attributes to Black
            if (colour == "Black") {
                C1.image = #imageLiteral(resourceName: "TileTop")
            }
                
                // Set Tile Attributes to Orange
            else if (colour == "Orange") {
                C1.image = #imageLiteral(resourceName: "TileTopOrange")
            }
                
                // Set Tile Attributes to Red
            else if (colour == "Red") {
                C1.image = #imageLiteral(resourceName: "TileTopRed")
            }
                
                // Set Tile Attributes to Blue
            else if (colour == "Blue") {
                C1.image = #imageLiteral(resourceName: "TileTopBlue")
            }
                
            else {
                NSLog("Invalid Colour : %@", colour)
            }
        }
        
        // Tile C2
        else if (tile == "C2") {
            // Set Tile Attributes to Black
            if (colour == "Black") {
                C2.image = #imageLiteral(resourceName: "TileTop")
            }
                
                // Set Tile Attributes to Orange
            else if (colour == "Orange") {
                C2.image = #imageLiteral(resourceName: "TileTopOrange")
            }
                
                // Set Tile Attributes to Red
            else if (colour == "Red") {
                C2.image = #imageLiteral(resourceName: "TileTopRed")
            }
                
                // Set Tile Attributes to Blue
            else if (colour == "Blue") {
                C2.image = #imageLiteral(resourceName: "TileTopBlue")
            }
                
            else {
                NSLog("Invalid Colour : %@", colour)
            }
        }
        
        //Tile C3
        else if (tile == "C3") {
            // Set Tile Attributes to Black
            if (colour == "Black") {
                C3.image = #imageLiteral(resourceName: "TileTop")
                C3Right.image = #imageLiteral(resourceName: "TileRightWall")
            }
                
                // Set Tile Attributes to Orange
            else if (colour == "Orange") {
                
                print(C3)
                
                
                C3.image = #imageLiteral(resourceName: "TileTopOrange")
                C3Right.image = #imageLiteral(resourceName: "TileRightWallOrange")
 
            }
 
                
                // Set Tile Attributes to Red
            else if (colour == "Red") {
                C3.image = #imageLiteral(resourceName: "TileTopRed")
                C3Right.image = #imageLiteral(resourceName: "TileRightWallRed")
            }
                
                // Set Tile Attributes to Blue
            else if (colour == "Blue") {
                C3.image = #imageLiteral(resourceName: "TileTopBlue")
                C3Right.image = #imageLiteral(resourceName: "TileRightWallBlue")
            }
                
            else {
                NSLog("Invalid Colour : %@", colour)
            }
        }
        
        else {
            NSLog("Invalid Tile : %@", tile)
        }
    }
    
    // Bluetooth UART Code
    func bluetooth(scanFor service: CBUUID) {
        output("Scanning for UART Service...")
        print("scanning")
        btManager.scanForPeripherals(withServices: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            self.output("Scan stopped")
            self.btManager.stopScan()
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if((advertisementData["kCBAdvDataLocalName"] as? String ?? "")! == "URT") {
            theThing = peripheral
            theThing.delegate = self
            btManager.connect(peripheral, options: nil)
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        peripheral.discoverServices([uartSV])
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        for service in peripheral.services ?? [] {
            if(service.uuid == uartSV) {
                output("Found UART Service")
                peripheral.discoverCharacteristics([uartTX, uartRX], for: service)
            }
        }
        
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        if(service.uuid == uartSV) {
            for characteristic in service.characteristics! {
                switch(characteristic.uuid) {
                case uartTX:
                    output("TX Characteristic Found")
                    txResponse = characteristic
                    
                    // TEMP STUFF
                    //var hi = 0
                    //if #available(iOS 10.0, *) {
                        //Timer.scheduledTimer(withTimeInterval: 3, repeats: true, block: { (_) in
                            //self.uart(action: .write, write: "hi " + String(hi))
                            //self.uart(action: .read)
                            //hi += 1
                        //})
                    //} else {
                        // Fallback on earlier versions
                    //}
                    // END TEMP STUFF
                    
                case uartRX:
                    output("RX Characteristic Found")
                    rxResponse = characteristic
                    theThing.setNotifyValue(true, for: rxResponse)
                    uart(action: .read)
                default:
                    break
                }
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?) {
        if(error != nil) {
            print(error!)
            return
        }
        
        output("Notify " + (characteristic.isNotifying ? "enabled" : "disabled"))
        print("Notification enabled", characteristic.isNotifying)
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if(error != nil) {
            print(error!)
            return
        }
        
        if(characteristic.uuid == rxResponse) {
            output("Thing: " + (String(data: rxResponse.value ?? Data(), encoding: .utf8) ?? "(nil)"))
            print("Thing update:", rxResponse.value!)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        if(error != nil) {
            print(error!)
            return
        }
    }
    
    func uart(action: uartAction, write: String = "") {
        switch(action) {
        case .read:
            output("Thing: " + (String(data: rxResponse.value ?? Data(), encoding: .utf8) ?? "(nil)"))
            print("Thing:", rxResponse.value ?? "")
            
            let tile = (String(data: rxResponse.value ?? Data(), encoding: .utf8) ?? "")
            
            if(previousTile != tile) {
                print(previousTile, tile)
                if(previousTile.index(of: "-") != nil) {
                    eventHappening(Event: "r-" + previousTile.split(separator: "-")[1], View: self)
                }
                previousTile = tile
                eventHappening(Event: tile, View: self)
            }
            
            
        case .write:
            output("You: " + write)
            print("You:", write.data(using: .utf8)!)
            theThing.writeValue(write.data(using: .utf8)!, for: txResponse, type: .withoutResponse)
        default:
            break
        }
    }
    
    func output(_ text: String...) {
        for output in text {
            
            print(text)
            
            // eventHappening(Event: output)
            
            //let label = UILabel(frame: CGRect(x: 8, y: scrollView.contentSize.height, width: view.frame.width - 16, height: 100))
            //label.numberOfLines = 0
            //label.textColor = .white
            //label.font = .monospacedDigitSystemFont(ofSize: 16, weight: .regular)
            //label.text = output
            //label.sizeToFit()
            //scrollView.addSubview(label)
            //scrollView.contentSize = CGSize(width: view.frame.width, height: label.frame.maxY)
        }
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
            bluetooth(scanFor: uartSV)
            break
        case .poweredOff:
            output("Unable to scan")
            print("BT OFF")
            break
        case .unsupported:
            output("Unable to scan")
            print("BT UNSUPPORTED")
            break
        case .unauthorized:
            output("Unable to scan")
            print("BT UNAUTHORISED")
            break
        case .resetting:
            output("Unable to scan")
            print("BT RESETTING")
            break
        case .unknown:
            output("Unable to scan")
            print("BT UNKNOWN ERROR")
            break
        default:
            break
        }
    }    
}

enum uartAction {
    case read
    case write
}
