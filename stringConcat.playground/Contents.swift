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
//var toDoList: [String] = [String]() //OR var toDoList = [String]()
//toDoList.append("Learn iOS")
//toDoList.append("Build the next Flappy Bird")
//toDoList.append("Retire in Cancun")
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

//: Optionals
//: Swift forces the developer to be cautious of potential nil values through the use of Optionals. An instance of optional type either has a value or it has no value or nil. When it is nil, it means there's nothing there. Optionals signal an instance may not have a value. It warns developers that the value may potentially be nil, and nil is very bad.
//: Optional binding: If an Optional Type is not nil, then do something.
//var present: String? = "Apple Watch"
//// If we can let "unwrappedPresent" equal "present" meaning there is something inside of present then go on to do something with "unwrappedPresent"
//if let unwrappedPresent = present {
//    print("OMG THANK YOU FOR THE \(unwrappedPresent)")
//}
//: Force Unwrapping: Use the "!" operator.
//var present: String? = "Apple Watch"
//print("OMG THANK YOU FOR THE \(present!)")
//: Implicitly Unwrapped Optionals
//: Implicitly unwrapped optionals are a little weird. They are still of the Optional Type: it can either contain a value of it is nil. The difference is that we don't need to unwrap them.
//var present: String! = "Apple Watch"
//print("\(present)")
//present = nil
//print("\(present)")

//: Dictionaries
//: Initializing a dictionary
//var myDict2: [String: Int] // OR using type inference: var myDict2 = [String: Int]()
//: Initialize and set the values of the Dictionary in one line
var dictionary = [
    "Kobe": 24,
    "Lebron": 23,
    "Rondo": 9
]
//dictionary["Kobe"]
//: When we access a Dictionary we get back an Optional Type.
//var jerseyNumber = dictionary["Kobe"]
//print(jerseyNumber) // Optional is not unwrapped
//var jerseyNumber = dictionary["Kobe"]! //Force unwrapping
//print(jerseyNumber)
//: Best practice is to use optional binding:
if let jerseyNumber = dictionary["Kobe"] {
    print(jerseyNumber)
}

//: Modifying a dictionary...
print(dictionary)
dictionary["Fisher"] = 2
print(dictionary)
dictionary["Kobe"] = 24
print(dictionary)

//: Removing...
//dictionary["Lebron"] = nil
//print(dictionary)
// OR use removeValue
//var lebronsNumber = dictionary.removeValue(forKey: "Lebron")
//print(lebronsNumber) //this message returns an Optional Type that might contain the value of the key-value pair that was deleted
// Use opational binding...
//if let lebronsNumber = dictionary.removeValue(forKey: "Lebron") {
//    print(lebronsNumber)
//}

//: Looping
for (key, value) in dictionary {
    print("The key is \(key) and the value is \(value)")
}
// Printing out a tuple...
for x in dictionary {
    print(x)
}
