//: Animals
//: The objective of this assignment is to help you understand inheritance and how classes can be used to help organize your code.

import UIKit

//: First, create a class called Animal
    // Give Animal a property "name"
    // Give Animal a property "health" with a default value of 100
    // Give Animal an initialization that takes in a name and sets the name property appropriately
    // Give the animal a displayHealth method
class Animal {
    var name : String
    var health : Int
    init(name: String){
        self.name = name
        self.health = 100
    }
    func displayHealth() {
        print ("Health of \(self.name): \(self.health)")
    }
}


//: Next, create a subclass of Animal called Cat
    // Give the Cat a method "growl" that prints to the screen "Rawr!"
    // Modify the Cat's health to be 150
    // Give the Cat a method "run" that prints to the screen "Running" and deducts 10 health
class Cat: Animal {
    override init(name: String) {
        super.init(name: name)
        self.health = 150
    }
    func run() -> Cat {
        if self.health > 0 {
            print ("Running")
            self.health -= 10
        } else {
            print ("Too tired. Can't run.")
        }
        return self
    }
    func growl() {
        print ("Rawr!")
    }
}


//: Next, create two subclasses of Cat - Cheetah and Lion
    // Override the growl method of the Lion to make it print "ROAR!!!! I am the King of the Jungle"
    // Override Lion's health to be 200
    // Override the Cheetah's run method to print "Running Fast" and deduct 50 health
    // Add a sleep function to the Cheetah class that adds 50 health (make sure that the Cheetah's health limit remains 200)
class Cheetah: Cat {
    override func run() -> Cat {
        if self.health > 0 {
            print ("Running Fast")
            self.health -= 50
        } else {
            print ("Too tired. Can't run.")
        }
        return self
    }
    func sleep() -> Cat {
        print ("Snoozing")
        self.health += 50
        if self.health > 200 {
            self.health = 200
        }
        return self
    }
}

class Lion: Cat {
    override func growl() {
        print ("ROAR! I am King of the Jungle")
    }
    override init(name: String) {
        super.init(name: name)
        self.health = 200
    }
}

var myCheetah = Cheetah(name: "Chester")
myCheetah.run().run().run().run().displayHealth()

var myLion = Lion(name: "Mufasa")
myLion.run().run().run().growl()