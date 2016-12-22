//: Playground - noun: a place where people can play

import UIKit

class Ghost {
    var isAlive = true
    var strength = 9
    
    func kill() {
        isAlive = false
    }
    
    func isStrong() -> Bool{
        if strength > 10{
            return true
        } else {
            return false
        }
    }
}

var ghost = Ghost()
print(ghost.isAlive)
ghost.strength = 20;
print(ghost.strength)
ghost.kill()
print(ghost.isAlive)
print(ghost.isStrong())



