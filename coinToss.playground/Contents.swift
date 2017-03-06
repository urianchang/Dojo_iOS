//: Heads or Tails

import UIKit

//: Create a function tossCoin() -> String
//: Have this function print "Tossing a Coin!"
//: Next have the function randomly pick either "Heads" or "Tails" 
//: Have the function print the result 
//: Finally, have the function return the result
func tossCoin() -> String? {
    var result_str : String?
    print ("Tossing a Coin!")
    let result = Int(arc4random_uniform(2))
    if result == 0 {
        result_str = "HEADS"
    } else {
        result_str = "TAILS"
    }
    if let toss_result = result_str {
        print (toss_result)
    }
    return result_str
}


//: Now create another function tossMultipleCoins(Int) -> Double
//: Have this function call the tossCoin function multiple times based on the Integer input 
//: Have the function return a Double that reflects the ratio of head toss to total toss

func tossMultipleCoins(Tosses: Int) -> Double {
    var num_heads : Double = 0
    for _ in 1...Tosses {
        let result = tossCoin()
        if result == "HEADS" {
            num_heads += 1
        }
    }
    let ratio : Double = num_heads/Double(Tosses)
    return ratio
}

print ("Ratio of head toss to total toss: \(tossMultipleCoins(Tosses: 10))")


