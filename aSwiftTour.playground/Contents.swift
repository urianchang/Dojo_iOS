//: Playground - noun: a place where people can play

import UIKit

//var str = "Hello, playground"
//var myVariable = 42
//myVariable = 50
//let myConstant = 42

//: Specify variable/constant type by writing it after variable, separated by colon
//var myV : Int = 32
//let myC : Float = 32.2

//: Values are never implicitly converted to another type! 
//let label = "The width is "
//let width = 94
//let widthLabel = label + String(width)
//: OR
//let apples = 3
//let oranges = 5
//let appleSummary = "I have \(apples) apples."
//let fruitSummary = "I have \(apples+oranges) pieces of fruit."

//: To create an empty array or dictionary, use the initializer syntax.
//let emptyArray = [String]()
//let emptyDictionary = [String : Float]()

//: Control Flow
//: Use if and switch to make conditionals, and use for-in, for, while, and repeat-while to make loops.
//let individualScores = [75, 43, 103, 87, 12]
//var teamScore = 0
//for score in individualScores {
//    if score > 50 {
//        teamScore += 3
//    } else {
//        teamScore += 1
//    }
//}
//print (teamScore)

//: You can use if and let to work with values that might be missing. These values are represented as optionals. An optional value either contains a value or contains nil to indicate that a value is missing. Write a question mark (?) after the type of a value to mark the value as optional.
//var optionalString: String? = "Hello"
//print (optionalString == nil)
//
//var optionalName: String? = nil
//var greeting = "Hello!"
//if let name = optionalName {
//    greeting = "Hello, \(name)"
//    print (greeting)
//} else {
//    print ("Uh...what's your name?")
//}

//: Switches support any kind of data and a wide variety of comparison operations. Execution doesn't continue to the next case, so there is no need to break out of the switch at the end of each case's code.
//let vegetable = "red pepper"
//switch vegetable {
//case "celery":
//    print ("Add some raisins and make ants on a log.")
//case "cucumber", "watercress":
//    print ("That would make a good tea sandwich.")
//case let x where x.hasSuffix("pepper"):
//    print ("Is it a spicy \(x)?")
//default:
//    print ("Everything tastes good in soup.")
//}

//: Use for-in to iterate over items in a dictionary by providing a pair of names to use for each key-value pair.
//let interestingNumbers = [
//    "Prime" : [2, 3, 5, 7, 11, 13],
//    "Fibonacci" : [1, 1, 2, 3, 5, 8],
//    "Square" : [1, 4, 9, 16, 25],
//]
//var largest = 0
//for (kind, numbers) in interestingNumbers {
//    for number in numbers {
//        if number > largest {
//            largest = number
//        }
//    }
//}
//print (largest)

//: Use while to repeat a block of code until a condition changes. The condition of a loop can be at the end instead, ensuring that the loop is run at least once.
//var n = 2
//while n < 100 {
//    n = n*2
//}
//print (n)
//
//var m = 2
//repeat {
//    m *= 2
//} while m < 100
//print (m)

//: Keep an index in a loop by using ..< to make a range of indexes.
var total = 0
for i in 0..<4 {
    total += i
}
print (total)
//: Use ..< to make a range that omits its upper value, and use ... to make a range that includes both values.
