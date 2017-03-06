//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

//: Every variable declaration follows the same format:
//: var variable_name : variable_type = variable_value
var name: String = "Anakin"
//: Basic variable types: String, Int, Double

//: CONDITIONALS
//var rings = 5
//if rings >= 5 {
//    print ("You are welcome to join the party")
//} else if rings > 2 {
//    print ("Decent...but \(rings) rings aren't enough")
//} else {
//    print ("Go win some more rings")
//}

//: Integers
//: 64 bits
//print ("The maximum value \(Int.max)")
//print ("The minimum value \(Int.min)")
//: 32 bits (signed)
//print("The maximum value \(Int32.max)")
//print("The minimum value \(Int32.min)")
//: 32 bits (unsigned)
//print("The maximum value \(UInt32.max)")
//print("The minimum value \(UInt32.min)")
//: To convert... myNormalInt = Int(myInt32)
//: While int's are precise, floating point types are not
//: Double is the inferred type

//: Conditionals
//: For-in Loops
//: A for-in loop performs a set of code in a specific range, sequence, or collection.
// loop from 1 to 5 including 5
//for i in 1...5 {
//    print(i)
//}
// loop from 1 to 5 excluding 5
//for i in 1..<5 {
//    print(i)
//}
//: While loop
//var i = 1
//while i < 6 {
//    print(i)
//    i = i+1
//}

//: Arrays and Dictionaries
//: Arrays are an ordered collection of values. Dictionaries are an unordered collection of key-value pairs.
var toDoList: [String] = [String]() //OR var toDoList = [String]()
toDoList.append("Learn iOS")
toDoList.append("Build the next Flappy Bird")
toDoList.append("Retire in Cancun")
//print(toDoList)
//print("\(toDoList[0])") //Accessing an element in an array
//print("\(toDoList[0...1])") //Ranges can be used to index instances of the Array Type as well.
//var arr = [1, 2, 3, 4]
//arr[0] = 8
//print(arr)

//: Array methods and properties

//: Append()
//var nums = [1, 2, 3, 4]
//nums.append(5)
//print(nums)

//: Remove()
//var arrayOfInts = [1, 2, 3, 4, 5]
//var popped = arrayOfInts.remove(at: 0)
//print(popped)
//print(arrayOfInts)

//: Insert()
//var arrayOfInts = [1, 2, 3, 4, 5]
//arrayOfInts.insert(6, at: 5)
//print (arrayOfInts)

//: Count - holds the total number of elements in an Array.
//var arrayOfInts = [1, 2, 3, 4, 5]
//arrayOfInts.insert(6, at: arrayOfInts.count)
//print(arrayOfInts)

