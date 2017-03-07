//: Notes on Functions

import UIKit

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
func printDescriptionWithWidth(w: Int, andHeight h: Int) {
    print("My width is \(w) and my height is \(h)")
}
printDescriptionWithWidth(w: 10, andHeight: 20)

//: When we pass in an argument to a function, our function assigns the value to a constant with the name of the internal parameter name. If we want to modify the argument we have to specify that we want to store it in a variable.


//: In-out Parameters
//: If we want to modify an argument and want to change to appear on the outside of hte function call, we need in-out parameters. First, we have to specify that our parameter is an in-out by following the parameter name with in-out. Next, when we invoke the function we have to pass in an argument with the '&' sign prefixed to it. '&' sign like passing the memory address of the particular constant or variable, so function can go directly there and modify it (so it persists outside of the function).
var myInt = 1
func changeMyInt(someInt: inout Int) {         // must specify "inout"
    someInt = someInt + 1
    print(someInt)
}
changeMyInt(someInt: &myInt)                   // must pass in the variable with "&" symbol
print(myInt)


//: Default Parameter Values
func sayHello(name: String = "buddy") {
    print("Hey \(name)")
}
//// We can call it without providing any arguments and the default value will be used...
sayHello()
//// ...or we can call it with an argument and that argument's value will be used
sayHello(name: "Yoda")


//: Return
//func sayHello(name: String = "buddy") -> String {
//    return "Hey \(name)"
//}
//var greeting: String?
//greeting = sayHello()
//print(greeting)

//: If we want to return a value in some cases, we just have to specify that our function will return an Optional Type. 
// For example:
// We are declaring a function named lookForSomethingIn and declaring two parameters.
// The first parameter will be an instance of Dictionary, with keys being instances of String
// and values being instances of Int.
// The first parameter has no external name but it has an internal name of dictionary.
// The second parameter will be an instance of a String.
// It has an external name of forKey and an internal name of key.
// This function promises to return an Optional Type that can either be nil or hold an instance of Int.
var dictionary = [
    "Kobe": 24,
    "Lebron": 23,
    "Rondo": 9
]
func lookForSomethingIn(dictionary: [String: Int], forKey key: String) -> Int? {
    if let value = dictionary[key] {
        return value
    } else {
        return nil
    }
}
var jerseyNumber = lookForSomethingIn(dictionary: dictionary, forKey: "Kobe")
if let num = jerseyNumber {
    print(num)
}


//: Scope: Describes the visibility an instance or a function will have. The inner scopes will have access to the outer scopes while outer scopes do not have access to inner scopes.


//: Function Types:

//This function is an instance of ([Int]) -> Int? type.
func findMinOf(arr: [Int]) -> Int? {
    if arr.count > 0 {
        var min = arr[0]
        for num in arr {
            if num < min {
                min = num
            }
        }
        return min
    } else {
        return nil
    }
}

//This function is an instance of the Type of () -> ().
//func sayHello() -> () {
//    print("Hello")
//}


