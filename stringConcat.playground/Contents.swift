//: Playground - noun: a place where people can play

import UIKit

//: Every variable declaration follows the same format:
//: var variable_name : variable_type = variable_value
//var name: String = "Anakin"
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
//var dictionary = [
//    "Kobe": 24,
//    "Lebron": 23,
//    "Rondo": 9
//]
//dictionary["Kobe"]
//: When we access a Dictionary we get back an Optional Type.
//var jerseyNumber = dictionary["Kobe"]
//print(jerseyNumber) // Optional is not unwrapped
//var jerseyNumber = dictionary["Kobe"]! //Force unwrapping
//print(jerseyNumber)
//: Best practice is to use optional binding:
//if let jerseyNumber = dictionary["Kobe"] {
//    print(jerseyNumber)
//}

//: Modifying a dictionary...
//print(dictionary)
//dictionary["Fisher"] = 2
//print(dictionary)
//dictionary["Kobe"] = 24
//print(dictionary)

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
//for (key, value) in dictionary {
//    print("The key is \(key) and the value is \(value)")
//}
// Printing out a tuple...
//for x in dictionary {
//    print(x)
//}

//: Functions
//: A function is invoked when we call its name, pass along the necessary input, and it will give us back soem kind of output.
//func sayHello() {
//    print("Hello how are you doing today?")
//}
//sayHello()
//: When declaring parameters for functions, we need to specify type of parameter
//func sayHello(name: String) {
//    print("Hello, \(name), how are you doing today?")
//}
//sayHello(name: "Andrew")
//: Sometimes having an external parameter name helps make our functions more expressive. Give external parameter names so that when we use the function, there's a higher chance that we pass in the right arguments.
// The two parameters have external names of width and height
// and internal names of w and h
//func printDescription(width w: Int, height h: Int) {
//    print("My width is \(w) and my height is \(h)")
//}
// The func can be invoked by calling its name and passing in
// right arguments with corresponding external parameter names.
//printDescription(width: 10, height: 20)
//: More Swift-like to leave out the external parameter name for the first argument. This convention is used a lot in Swift and is highly recommended in your own code.
//func printDescriptionWithWidth(w: Int, andHeight h: Int) {
//    print("My width is \(w) and my height is \(h)")
//}
//printDescriptionWithWidth(w: 10, andHeight: 20)

//: When we pass in an argument to a function, our function assigns the value to a constant with the name of the internal parameter name. If we want to modify the argument we have to specify that we want to store it in a variable.

//: In-out Parameters
//: If we want to modify an argument and want to change to appear on the outside of hte function call, we need in-out parameters. First, we have to specify that our parameter is an in-out by following the parameter name with in-out. Next, when we invoke the function we have to pass in an argument with the '&' sign prefixed to it. '&' sign like passing the memory address of the particular constant or variable, so function can go directly there and modify it (so it persists outside of the function). 
//var myInt = 1
//func changeMyInt(someInt: inout Int) {         // must specify "inout"
//    someInt = someInt + 1
//    print(someInt)
//}
//changeMyInt(someInt: &myInt)                   // must pass in the variable with "&" symbol
//print(myInt)


//: Default Parameter Values
//func sayHello(name: String = "buddy") {
//    print("Hey \(name)")
//}
//// We can call it without providing any arguments and the default value will be used...
//sayHello()
//// ...or we can call it with an argument and that argument's value will be used
//sayHello(name: "Yoda")

//: Return
//func sayHello(name: String = "buddy") -> String {
//    return "Hey \(name)"
//}
//var greeting: String?
//greeting = sayHello()
//print(greeting)

//: If we want to return a value in some cases, we just have to specify that our function will return an Optional Type. For example:
// We are declaring a function named lookForSomethingIn and declaring two parameters.
// The first parameter will be an instance of Dictionary, with keys being instances of String
// and values being instances of Int.
// The first parameter has no external name but it has an internal name of dictionary.
// The second parameter will be an instance of a String.
// It has an external name of forKey and an internal name of key.
// This function promises to return an Optional Type that can either be nil or hold an instance of Int.
//func lookForSomethingIn(dictionary: [String: Int], forKey key: String) -> Int? {
//    if let value = dictionary[key] {
//        return value
//    } else {
//        return nil
//    }
//}
//var jerseyNumber = lookForSomethingIn(dictionary: dictionary, forKey: "Kobe")
//if let num = jerseyNumber {
//    print(num)
//}

//: Scope: Describes the visibility an instance or a function will have. The inner scopes will have access to the outer scopes while outer scopes do not have access to inner scopes.

//: Function Types:

//This function is an instance of ([Int]) -> Int? type.
//func findMinOf(arr: [Int]) -> Int? {
//    if arr.count > 0 {
//        var min = arr[0]
//        for num in arr {
//            if num < min {
//                min = num
//            }
//        }
//        return min
//    } else {
//        return nil
//    }
//}

//This function is an instance of the Type of () -> ().
//func sayHello() -> () {
//    print("Hello")
//}

//: Classes, Structs, and Enumerations
//: Classes in Swift allow you to define the blueprint of a particular type and then create instances of that type.
//Create the class Person that has one property "species"
//class Person {
//    var species = "H. Sapiens" // "var" for readable/writable ; "let" for read-only
//    var name: String
//    init(name: String) {   // Note this function doesn't get called explicitly. It is called
//        // when creating an instance using initialization syntax -- "Person()".
//        self.name = name     // Note use of "self" here to refer to the name property.
//    }
//    func speak() {
//        print("Hello! I am a \(self.species) and my name is \(self.name)")   // Note how we refer to the properties using "self"
//    }
//    func studyForTopic(topic: String, hours: Int) {
//        print("I am studying \(topic) for \(hours) hours")
//    }
//}
//var myPerson: Person = Person(name: "Jay")
//print("\(myPerson.species)")
//myPerson.speak()
//myPerson.studyForTopic(topic: "Math", hours: 12)
//: It is common practice to  write the name of the first argument in the actual function name ('Topic') because the first argument is not going to get an external parameter name. By following this practice, it becomes very clear what each argument does. Methods do not give free external parameter names for the first argument but do give external parameter names for all arguments afterwards.

//: Structs in Swift
//: Structs, like classes, are used to create types. Structs are used more for creating collections of values (e.g. shapes).
//struct Rectangle {
//    var width : Int
//    var height : Int
//    func printDesc() {
//        print("I have a width of \(width) and a height of \(height)")
//    }
//    mutating func doubleWidth() {    // See note below.
//        width *= 2
//    }
//}
//var myRectangle = Rectangle(width: 200, height: 400)
//print("\(myRectangle.width)")

//: 'Mutating' means method changes value(s) of the instance. We do NOT need 'mutating' when writing a similar method in a Class.

//: Struct initialization
//: Swift will give us a "memberwise" initializer so that we don't have to explicitly define the initialization method. This memberwise initializer will include external parameter names for all of the stored properties that need values.
//: Primary role of initialization is to make sure that the new instance has values for all of its stored properties.

//: Value vs Reference Types
//: Classes and Functions are the only Reference types; everything else is a Value Type.
//: Value types are copied when they are assigned to a variable or a constant and when they are passed in as an argument to a function. Reference types are not copied. Their memory address location is passed back and forth so changing the value of a Reference Type will change all of the "pointers" that refer to that object. 

//: Example...
// Create Person class that has a "fullName" property and an introduce method
class Person {
    var fullName: String
    init(name: String) {
        self.fullName = name
    }
    func introduce() {
        print("Hi my name is \(self.fullName)")
    }
}

var j = Person(name: "Ketul Patel") // Initialize a Person object and assign it to the j variable
var k = j                           // Create a k variable and set its value to be the j variable
                                    // (remember classes are reference types)
j.introduce()                       // Prints "Hi my name is Ketul Patel"
k.fullName = "Ketul J Patel"        // We are changing the name through the k variable.
j.introduce()                       // Prints "Hi my name is Ketul J Patel" since both
                                    // j and k refer to the same instance in memory

//: In contrast, Structs are Value Types which means that when they are passed, their values are copied and then passed.
struct Rectangle {
    var width: Int
    var height: Int
}
var square1 = Rectangle(width: 10, height: 10)
var square2 = square1                         // Here the val inside square 1 (an instance of Rectangle)
// is copied and passed rather than just pointed to.
print("square1's width: \(square1.width), square2's width \(square2.width)")
// They are the same because square2 is a copy of square1
square2.width = 20                            // This only changes square2 because there are
// 2 separate instances of rectangle in memory
square2.height = 20
print("square1's width: \(square1.width), square2's width \(square2.width)")
// They are different now: changing square2 changed a
// completely separate instance from square1.

//: The only way to pass a Value Type by memory location is by using the inout designation when passing the Value type as an argument to a function.