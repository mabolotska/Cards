//
//  ViewController.swift
//  Cards
//
//  Created by Maryna Bolotska on 10/07/23.
//

import UIKit

class ViewController: UIViewController {
    lazy var game = ConcentrationModel(numberOfPairsOfCards: numberOfPairsOfCards)
    private var emoji = [Card: String]()
    
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    private var backgroundColor = UIColor.black
    private var cardBackColor = UIColor.orange
    
    var flipCount = 0 {
        didSet {
            updateFlipLabel()
        }
    }
    
    func updateFlipLabel() {
        let attributes: [NSAttributedString.Key: Any] = [
            .strokeWidth: 5.0,
            .strokeColor: UIColor.orange
        ]
        let attributedString = NSAttributedString(string: "Flips: \(flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attributedString
    }
    
   // var emojiChoices = ["👩🏻‍✈️","👩🏻‍🎨","🕵🏻","👨🏻‍💻","👨🏼‍🔬","👨🏻‍🚒","👨🏻‍🎤","👩🏻‍🏫","👩🏻‍🍳"]
    
    var emojiChoices = "🐶🐭🦊🦋🐢🐸🐵"
    
    @IBOutlet weak var flipCountLabel: UILabel! {
        didSet {
            updateFlipLabel()
        }
    }
    @IBOutlet var cardButtons: [UIButton]!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func flipCard(with emoji: String, on button: UIButton) {
        if button.currentTitle == emoji {
               button.setTitle("", for: .normal)
               button.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
   
           } else {
               button.setTitle(emoji, for: .normal)
               button.backgroundColor = .white
           }
    }

    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
        //    flipCard(with: emojiChoices[cardNumber], on: sender)
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
      
    
        //we move this code to didSet of flipCount
      //  flipCountLabel.text = "Flips: \(flipCount)"
    }
    
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                   button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : cardBackColor
            }
        }
    }
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            //we use string instead of array so we implement this method with indicies
      //      emoji[card] = emojiChoices.remove(at: emojiChoices.count.arc4random)
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
        }
        return emoji[card] ?? "?"
    }
    @IBAction private func startNewGame(_ sender: UIButton) {
         flipCount = 0
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self))) }
        else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
