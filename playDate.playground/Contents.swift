//: Playground - noun: a place where people can play

import UIKit

let current = NSDate()
let formatter = DateFormatter()
formatter.dateFormat = "HH"

let currentHour = formatter.string(from: current as Date)
print (current)
print (currentHour)

