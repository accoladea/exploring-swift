//: Playground - noun: a place where people can play

import UIKit

var number: Int?

print (number)

var userEnteredText = "3"
var userEnteredInteger = Int(userEnteredText)
if let catAge = userEnteredInteger{
    print(catAge*7)
} else {
    //show an error message to user
}

