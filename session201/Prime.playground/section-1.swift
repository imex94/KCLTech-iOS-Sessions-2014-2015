// Playground - noun: a place where people can play

import Foundation

func isPrime(number: Int) -> Bool {
    for i in 2...number/2 {
        if (number % i == 0) {
            return false
        }
    }
    
    return true
}

isPrime(59)

class Vehicle {
    var numberOfWheels = 0
    var description: String {
        get {
            return "\(numberOfWheels) wheels"
        }
    }
}

class Car: Vehicle {

    override init() {
        super.init()
        
        numberOfWheels = 4
    }
}

let car = Car()
car.description