//: Playground - noun: a place where people can play

import UIKit

//: Create a loop (either for or while) that prints all the values from 1-255
//for num in 1...255 {
//    print (num)
//}

//: Create a program that prints all of the values from 1-100 that are divisible by 3 or 5 but not both
//for num in 1...100 {
//    if num%3 == 0 && num%5 == 0 {
//        continue
//    }
//    if num%3 == 0 || num%5 == 0 {
//        print (num)
//    }
//}

//: Modify that program to print "Fizz" when the number is divisible by 3 and "Buzz" when the number is divisible by 5 as well as "FizzBuzz" when the number is divisible by both
for num in 1...100 {
    if num%3 == 0 && num%5 == 0 {
        print ("FizzBuzz")
    }
    if num%3 == 0 {
        print ("Fizz")
    }
    if num%5 == 0 {
        print ("Buzz")
    }
}


//: From the answer key:
////Exercise 2
//
//for i in 1...100{
//    if (i % 3 == 0 || i % 5 == 0) && i % 15 != 0{
//        print(i)
//    }
//}
//
//
////Exercise 3
//
//for i in 1...100{
//    if i % 15 == 0 {
//        print("FizzBuzz")
//    }else if i % 3 == 0{
//        print("Fizz")
//    }else if i % 5 == 0 {
//        print("Buzz")
//    }
//}
