//: Playground - noun: a place where people can play

import UIKit

// var and let

var str = "Hello, playground"
print("Islomzhan Akhemdov")
let otherStr = "Hi, Islomzhan" // otherStr cannot be changed

//Strings

let name = "Islomzhan"
print("Hello " + name)

//Integer (whole number)
let myInt = 8;
print(myInt * 2)
print(myInt + 100)
print(myInt + 1)
print(myInt / 5)
print("myInt has value \(myInt)")

let age = 19;
print("My name is "+name+". I am \(age) years old")

//Doubles

var a: Double = 8.73;
var b: Float = 8.73;
var c = 7.12;

print(a/c)

// every time for var stored Double
// cannot be combined two different types
print (Double(myInt) + a)

let gameOver = false
var gameOverString = String(gameOver)

// double - 5.76, int -8
var q: Double = -5.76;
var w: Int = -8;
print(q*Double(w))

// Array

var array = [35, 36, 5, 2]

print(array[0])
print(array.count)
array.append(1)
array.remove(at: 1)
array.sort()
print(array)

//Challenge

var challenge = [3.87, 7.1, 8.9]

challenge.remove(at: 1)
challenge.append(challenge[0]*challenge[1])

// Dictionary

var dictionary = ["computer":"something to play Call of Duty on", "coffee":"best drink ever"]
print(dictionary.count)
dictionary["pen"] = "Old fashioned writing implement"
dictionary.removeValue(forKey: "computer")
print(dictionary)

var gameCharacters = [String: Decimal]()
gameCharacters["ghost"] = 8.7;

//Challenge 
var menu = ["pizza":10.99, "ice cream": 4.99, "salad": 7.99]


print("The total cost of my meal is \(menu["pizza"]!+menu["ice cream"]!)")

// If else statements

//let age = 13
if age >= 18{
    print("You can Play")
}
else{
    print("You are too young")
}

// Check username

//let name = "kirsten"
if name == "Islomzhan"{
    print("Hi " + name + "! You can play")
} else {
    print("Sorry, " + name + ", you can't play")
}

//2 if statements with and
if name == "Islomzhan" && age >= 18{
    print("You can play")
} else {
    print("Sorry, " + name + ", you need to get older")
}

//2 if statements with or
if name == "Islomzhan" || name == "kirsten"{
    print("You can play")
} else {
    print("Sorry, " + name + ", you need to get older")
}

// Booleans with if statements
let isMale = true
if isMale{
    print("You are male!")
}

// Login system.

var username = "user"
var password = "pass"

if username == "user" && password == "pass"{
    print("The data is correct!")
} else{
    print("Smth is wrong!")
}


if username != "user"{
    print("The username is correct!")
} else{
    print("The username is wrong!")
}

if password != "pass"{
    print("The password is correct!")
} else{
    print("The password is wrong!")
}





























