//: Playground - noun: a place where people can play

import UIKit

var str = "Hello"

var newString = str + " Islomzhan!"

for character in newString.characters {
    
    print(character)
    
}

let newTypeString = NSString(string: newString)

newTypeString.substring(to: 5)

newTypeString.substring(from: 4)

NSString(string: newTypeString.substring(from: 6)).substring(to: 9)

newTypeString.substring(with: NSRange(location: 6, length: 9))

if newTypeString.contains("Islomzhan") {
    
    print("newTypeString contains Islomzhan!")
    
}

newTypeString.components(separatedBy: " ")

newTypeString.lowercased
newTypeString.capitalized