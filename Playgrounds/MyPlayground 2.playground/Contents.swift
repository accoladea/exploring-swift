//: Playground - noun: a place where people can play
// LOOPS
// LOOPS
// LOOPS
// LOOPS
// LOOPS
import UIKit
// LOOPS
// LOOPS

var i = 7;
while i <= 140{
    print(i)
    i+=7;
}

var array = [7, 23, 98, 1, 0, 763]
var iu = 0;
while iu < array.count{
    array[iu] += 1;
    iu += 1;
}
print(array)




var arrayh = [8,4,8,1]
for number in arrayh {
    print(number)
}



//Create an array with 4 names of friends/family print "Hi there ---- !"
var names = ["Mahdiya", "Iasin", "Rashid"]
for name in names {
    print("Hi there \(name)!")
}




var numberss = [7, 2, 9, 4, 1]
for (index, value) in numberss.enumerated(){
    numberss[index] = value + 1
}
print(numberss)
//
//
//
//// array containing 8,7,19,28.  Halve each of the values

var numbersss = [8.0,7,19,28]
for (index, value) in numbersss.enumerated(){
    numbersss[index] = value / 2
}
print(numbersss)
























