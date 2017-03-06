//: Swift Fundamentals III

import UIKit


//: Write a program that adds the numbers 1-255 to an array
var arrOfInts = [Int]()
for num in 1...255 {
    arrOfInts.append(num)
}

//: Swap two random values in the array
//: Hint: you can use the arc4random_uniform(UInt32) function to get a random number from 0 to the number passed in. The arc4random_uniform function takes in one parameter that is of the UInt32 type and returns a random number that is of the UInt32 type. How can you deal with this using your knowledge of types?

//: How I used to do it...
//var ind1 = Int(arc4random_uniform(255))
//var ind2 = Int(arc4random_uniform(255))
//var temp = arrOfInts[ind1]
//arrOfInts[ind1] = arrOfInts[ind2]
//arrOfInts[ind2] = temp

//: Better way of doing it...using the swap() method. Declaring random indexes outside of method for error checking.
//var ind1 = Int(arc4random_uniform(255))
//var ind2 = Int(arc4random_uniform(255))
//swap(&arrOfInts[ind1], &arrOfInts[ind2])


//: Now write the code that swaps random values 100 times (You've created a "Shuffle"!) 
for num in 1...100 {
    var ind1 = Int(arc4random_uniform(255))
    var ind2 = Int(arc4random_uniform(255))
    if ind1 == ind2 {
        ind2 = Int(arc4random_uniform(255))
    }
    swap(&arrOfInts[ind1], &arrOfInts[ind2])
}

//: Remove the value "42" from the array and Print "We found the answer to the Ultimate Question of Life, the Universe, and Everything at index __" and print the index of where "42" was before you removed it.

var idx = 0
for num in arrOfInts {
    if num == 42 {
        arrOfInts.remove(at: idx)
        print ("We found the answer to the Ultimate Question of Life, the Universe, and Everything at index \(idx).")
    }
    idx += 1
}
