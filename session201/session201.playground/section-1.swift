// Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

let greeting = {
    println("HelloWorld")
}

greeting()

func repeat(count: Int, task: () -> ()) {
    for i in 0..<count {
        task()
    }
}

repeat(2, {
    println("Hello!")
})

class Vehicle {
    var numberOfWheels = 10
    var description: String {
        get {
            return "\(numberOfWheels) wheels"
        }
        set {
            self.description = self.description + "number"
        }
    }
}

var c = Vehicle()
c.description = ""
println(c.description)
