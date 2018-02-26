//
//  stringChar.swift
//  Stepp
//
//  Created by Dalton Ng on 23/2/18.
//  Copyright © 2018 AppsLab. All rights reserved.
//  All credits for this go to Stackoverflow

/*
 Use Case Demonstration
 let test = "Hello USA 🇺🇸!!! Hello Brazil 🇧🇷!!!"
 test.character(at: 10)   // "🇺🇸"
 test.character(at: 11)   // "!"
 test[10...]   // "🇺🇸!!! Hello Brazil 🇧🇷!!!"
 test[10..<12]   // "🇺🇸!"
 test[10...12]   // "🇺🇸!!"
 test[...10]   // "Hello USA 🇺🇸"
 test[..<10]   // "Hello USA "
 test.first   // "H"
 test.last    // "!"
 
 // Note that they all return a Substring of the original String.
 // To create a new String you need to add .string as follow
 test[10...].string  // "🇺🇸!!! Hello Brazil 🇧🇷!!!"
 */


import Foundation
extension String {
    func index(at offset: Int, from start: Index? = nil) -> Index? {
        return index(start ?? startIndex, offsetBy: offset, limitedBy: endIndex)
    }
    func character(at offset: Int) -> Character? {
        precondition(offset >= 0, "offset can't be negative")
        guard let index = index(at: offset) else { return nil }
        return self[index]
    }
    subscript(_ range: CountableRange<Int>) -> Substring {
        precondition(range.lowerBound >= 0, "lowerBound can't be negative")
        let start = index(at: range.lowerBound) ?? endIndex
        return self[start..<(index(at: range.count, from: start) ?? endIndex)]
    }
    subscript(_ range: CountableClosedRange<Int>) -> Substring {
        precondition(range.lowerBound >= 0, "lowerBound can't be negative")
        let start = index(at: range.lowerBound) ?? endIndex
        return self[start..<(index(at: range.count, from: start) ?? endIndex)]
    }
    subscript(_ range: PartialRangeUpTo<Int>) -> Substring {
        return prefix(range.upperBound)
    }
    subscript(_ range: PartialRangeThrough<Int>) -> Substring {
        return prefix(range.upperBound+1)
    }
    subscript(_ range: PartialRangeFrom<Int>) -> Substring {
        return suffix(max(0,count-range.lowerBound))
    }
}

extension Substring {
    var string: String { return String(self) }
}
