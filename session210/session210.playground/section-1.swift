// Playground - noun: a place where people can play

import UIKit

/* 1. Difference between CLASS and STRUCT

STRUCT
- encapsulate a few relatively simple data values
- structure instances are always passed by value, so that the encapsulated values will be copied rather than referenced
- The structure does not need to inherit properties or behavior from another existing type

CLASS
- class instances are always passed by reference
- inheritance, The size of a geometric shape, perhaps encapsulating a width property and a height property, both of type Double
- most custom data constructs should be classes

*/

// I. Stack using STRUCT
struct Stack<T> {
    var localStack = [T]()
    
    func top() -> T? {
        return localStack.last
    }
    
    mutating func pop() -> T? {
        if !localStack.isEmpty {
            return localStack.removeLast()
        }
        return nil
    }
    
    mutating func push(anElement: T) {
        localStack.append(anElement)
    }
    
    func isEmpty() -> Bool {
        return localStack.isEmpty
    }
}

var stack = Stack<Int>()
stack.top()
stack.push(5)
stack.push(6)
stack.push(7)
stack.top()
stack
stack.pop()
stack
println(stack)

// 2. Same stack using extension

extension Array {
    func top() -> T? {
        return self.last
    }
    
    mutating func pop() -> T? {
        if !self.isEmpty {
            return self.removeLast()
        }
        return nil
    }
    
    mutating func push(anElement: T) {
        self.append(anElement)
    }
}

var stackArray = [Float]()
stackArray.top()
stackArray.push(5)
stackArray.push(6)
stackArray.push(7)
stackArray.top()
stackArray
stackArray.pop()
stackArray

// 3. Closure
func evaluate(op: String) {
    switch op {
    case "+": return performOperation(+)
    case "-": return performOperation() { $1 - $0 }
    case "*": return performOperation(*)
    case "/": return performOperation() { $1 / $0 }
    default: break
    }
}

func performOperation(apply: (Float, Float) -> Float) {
    let result = apply(stackArray.pop()!, stackArray.pop()!)
    stackArray.push(result)
}

evaluate("/")

stackArray

// 3. ENUM
enum Op {
    case operand(Double)
    case unaryOperation(String, Double -> Double)
    case binaryOperation(String, (Double, Double) -> Double)
}

Op.unaryOperation("√", sqrt)
Op.operand(6)
Op.binaryOperation("+", +)
Op.binaryOperation("÷") {$1 / $0}

// FOLLOW THIS - TYPE INFERENCE
/*
1. 
case "+": return performOperation({ (op1, op2) -> Float in
return op1 + op2
})

2.
case "+": return performOperation({ (op1, op2) in
return op1 + op2
})

3. 
case "+": return performOperation({ (op1, op2) in op1 + op2 })

4.
case "+": return performOperation({ $0 + $1 })

5. - IF THE APPLY IS THE LAST ARGM
case "+": return performOperation() { $0 + $1 }

6.
case "+": return performOperation(+)

*/

// WWDC FOLDER

