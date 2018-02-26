# Stepp

This project is for HackOMania 2018 by GeeksHacking.
* [HackOMania](http://hackomania.geekshacking.com/)

## Warning

As this is a Hackathon Build, I would not reccomend actually using the code as it can get rather 'hacky' in some bits.

### Installing

Make sure you have pods installed. Run ``` $pod install ```

Create a new file, setup.swift. Paste the following into the file. This is to keep my personal keys safe sorry.

```
import Foundation

struct GlobalConstants {
static let twilioSID = "YOUR_SID_HERE"
static let twilioSecret = "YOUR_SECRET_HERE"
static let fromNumber = "YOUR_TWILIO_NUMBER_HERE"
static let testNumber = "YOUR_OWN_NUMBER_HERE"
}
```

If you want to use these values in other areas of the app, simply call the global constant as such :

```
let twilioSID = GlobalConstants.twilioSID
print ("Your twilio SID is : ", twilioSID)
```

You can test if it's working by placing this somewhere where it will run such as ViewDidLoad.

## Built With

* [Twilio](https://www.twilio.com/) - For sending SMS Notifications in an Emergency
* [SwiftySound](https://github.com/adamcichy/SwiftySound) - Ear Rape Alarm
* [iGlooHome](https://www.igloohome.co) - Lock Api and Physcal Demo Lock for Testing


## Authors

* **Dalton Prescott** - *Main Developer* - [website](daltonprescott.com)
* **Roy Tay** - *Co Developer*

## Acknowledgments
* iGlooHome for providing a demo lock and demo api
* Christoffer Tews
* Hat tip to anyone who's code was used
