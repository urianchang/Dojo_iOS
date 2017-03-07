//: Notes on Classes and Structs

import UIKit

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
//class Person {
//    var fullName: String
//    init(name: String) {
//        self.fullName = name
//    }
//    func introduce() {
//        print("Hi my name is \(self.fullName)")
//    }
//}
//
//var j = Person(name: "Ketul Patel") // Initialize a Person object and assign it to the j variable
//var k = j                           // Create a k variable and set its value to be the j variable
//                                    // (remember classes are reference types)
//j.introduce()                       // Prints "Hi my name is Ketul Patel"
//k.fullName = "Ketul J Patel"        // We are changing the name through the k variable.
//j.introduce()                       // Prints "Hi my name is Ketul J Patel" since both
//                                    // j and k refer to the same instance in memory


//: In contrast, Structs are Value Types which means that when they are passed, their values are copied and then passed.
//struct Rectangle {
//    var width: Int
//    var height: Int
//}
//var square1 = Rectangle(width: 10, height: 10)
//var square2 = square1                         // Here the val inside square 1 (an instance of Rectangle)
//// is copied and passed rather than just pointed to.
//print("square1's width: \(square1.width), square2's width \(square2.width)")
//// They are the same because square2 is a copy of square1
//square2.width = 20                            // This only changes square2 because there are
//// 2 separate instances of rectangle in memory
//square2.height = 20
//print("square1's width: \(square1.width), square2's width \(square2.width)")
//// They are different now: changing square2 changed a
//// completely separate instance from square1.

//: The only way to pass a Value Type by memory location is by using the inout designation when passing the Value type as an argument to a function.


//: Inheritance: Classes support inheritance while Structs do not.
class Person {
    var species = "H. Sapiens"
    var name: String
    init(name: String) {         // Note: this function doesn't get called explicitly.  It is called
        // when creating an instance using the initialization syntax -- "Person()"
        self.name = name           // Note the use of "self" here to refer to the name property
    }
    func speak() {
        print("Hello! I am a \(self.species) and my name is \(self.name)")
        // Note how we refer to the properties using "self"
    }
}
class Developer: Person {      // Note how we are specifying that Developer will inherit from Person
    var favoriteLanguage: String    // Declaring the favoriteLanguage property in Developer means it is only available in Developer and Developer's subclasses
    init(name: String, favoriteLanguage: String) {  // Developer's init method takes in a name and a favoriteLanguage
        self.favoriteLanguage = favoriteLanguage    // We set the favoriteLanguage property
        super.init(name: name)  // We then call the superclass' init method and pass it the name property since the logic is already written in Person's init.
    }
    override func speak() { // We specify that we are overrriding the speak function.
        print("Hello! I am a Developer! My name is \(self.name)")
    }
}
var myDeveloper: Developer = Developer(name: "Jay", favoriteLanguage: "Swift")
myDeveloper.speak()
