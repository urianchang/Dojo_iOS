//: Deck of Cards
import UIKit

//: Create a struct called "Card"
// Give the Card struct a property "value" which will hold the value of the card (A, 2, 3, 4, 5, 6, 7, 8, 9, 10, J, Q, K). This value should be a String 
// Give the Card a property "Suit" which will hold the suit of the card (Clubs, Spades, Hearts, Diamonds) 
// Give the Card a property "numerical_value" which will hold the numerical value of the card 1-13

struct Card {
    var value : String?
    var suit : String?
    var num_val : Int?
    func show() {
        if let val = self.value, let suit = self.suit {     //Optional unwrapping
            print ("\(val) of \(suit)")
        }
    }
}


//: Create a class called "Deck"
// Give the Deck class a property called "cards" of type [Card] 
// When initializing the deck make sure that it has the 52 unique cards in its "cards" property 
// Give the Deck a deal method that selects the "top-most" card, removes it, and returns it 
// Give the Deck a reset method that resets the cards property to the contain the original 52 cards 
// Give the Deck a shuffle method that randomly reorders the deck's cards

class Deck {
    var cards = [Card]()
    init() {
        self.reset()
    }
    func reset() {
        let values = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]
        let suits = ["Clubs", "Spades", "Hearts", "Diamonds"]
        for suit in suits {
            for num in 0...12 {
                self.cards.append(Card(value: values[num], suit: suit, num_val: num+1))
            }
        }
    }
    func show() {
        for card in self.cards {
            card.show()
        }
    }
    func shuffle() {
        print ("Shuffling!")
        for ind in 0..<self.cards.count {
            let rand_idx = Int(arc4random_uniform(52))
            let temp = cards[ind]
            cards[ind] = cards[rand_idx]
            cards[rand_idx] = temp
        }
    }
    func deal() -> Card? {
        if self.cards.count > 0 {
            return self.cards.remove(at: 0)
        } else {
            return nil
        }
    }
}


//: Create a class called "Player"
// Give the Player class a name property 
// Give the Player a hand property of type [Card] 
// Give the Player a draw method of type (Deck) -> Card which draws a card from a deck, adds it to the players hand, and returns it
//  Note how we are passing the Deck by reference here since it is a class.
// Give the Player a discard method of type (Card) -> Bool which discards the Card specified and returns True if the Card existed and was successfully removed or False if the Card was not in the player's hand.

class Player {
    var name: String
    var hand = [Card]()
    init(name: String = "player") {     // Default name is "player" if none given
        self.name = name
    }
    func draw(deck: Deck) -> Card? {
        if let newCard = deck.deal() {
            self.hand.append(newCard)
            return newCard
        } else {
            return nil
        }
    }
    func discard(suit: String, value: String) -> Bool {
        for ind in 0..<self.hand.count {
            if self.hand[ind].suit == suit && self.hand[ind].value == value {
                self.hand.remove(at: ind)
                return true
            }
        }
        return false
    }
    func show() {
        print ("Cards in the hand of \(self.name):")
        for card in self.hand {
            card.show()
        }
    }
}


//: Test the functions...

var myDeck = Deck()
myDeck.shuffle()
myDeck.show()
var player1 = Player(name: "tester 1")
for _ in 1...5 {
    player1.draw(deck: myDeck)
}
player1.show()
print (player1.discard(suit: "Clubs", value: "Q"))
