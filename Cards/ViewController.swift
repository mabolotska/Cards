//
//  ViewController.swift
//  Cards
//
//  Created by Maryna Bolotska on 10/07/23.
//

import UIKit

struct Theme {
    var name: String
    var emojis: [String]
    var backgroundColor: UIColor
    var cardBackColor: UIColor
}

class ViewController: UIViewController {
    lazy var game = ConcentrationModel(numberOfPairsOfCards: numberOfPairsOfCards)
    private var emoji = [Int: String]()
    
    private(set) var score = 0
    private var seenCards: Set<Int> = []
    
    var cards: [Card] = []
 //  private var emoji: [Card: EmojiCollections] = [:]
    
    private var emojiThemes: [Theme] = [
        Theme(name: "Fruits",
              emojis:["🍏", "🍊", "🍓", "🍉", "🍇", "🍒", "🍌", "🥝", "🍆", "🍑", "🍋"],
              backgroundColor: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1),
              cardBackColor: #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)),
        Theme(name: "Faces",
              emojis:["😀", "😂", "🤣", "😃", "😄", "😅", "😆", "😉", "😊", "😋", "😎"],
              backgroundColor: #colorLiteral(red: 1, green: 0.8999392299, blue: 0.3690503591, alpha: 1),
              cardBackColor: #colorLiteral(red: 0.5519944677, green: 0.4853407859, blue: 0.3146183148, alpha: 1)),
        Theme(name: "Activity",
              emojis:["⚽️", "🏄‍♂️", "🏑", "🏓", "🚴‍♂️","🥋", "🎸", "🎯", "🎮", "🎹", "🎲"],
              backgroundColor: #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1),
              cardBackColor: #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)),
        Theme(name: "Animals",
              emojis:["🐶", "🐭", "🦊", "🦋", "🐢", "🐸", "🐵", "🐞", "🐿", "🐇", "🐯"],
              backgroundColor: #colorLiteral(red: 0.8306297664, green: 1, blue: 0.7910112419, alpha: 1),
              cardBackColor: #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)),
        Theme(name: "Christmas",
              emojis:["🎅", "🎉", "🦌", "⛪️", "🌟", "❄️", "⛄️","🎄", "🎁", "🔔", "🕯"],
              backgroundColor: #colorLiteral(red: 0.9678710938, green: 0.9678710938, blue: 0.9678710938, alpha: 1),
              cardBackColor: #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)),
         Theme(name: "Clothes",
               emojis:["👚", "👕", "👖", "👔", "👗", "👓", "👠", "🎩", "👟", "⛱","🎽"],
               backgroundColor: #colorLiteral(red: 0.9098039269, green: 0.7650054947, blue: 0.8981300767, alpha: 1),
               cardBackColor: #colorLiteral(red: 0.5818830132, green: 0.2156915367, blue: 1, alpha: 1)),
         Theme(name: "Halloween",
               emojis:["💀", "👻", "👽", "🙀", "🦇", "🕷", "🕸", "🎃", "🎭","😈", "⚰"],
               backgroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
               cardBackColor: #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)),
         Theme(name: "Transport",
               emojis:["🚗", "🚓", "🚚", "🏍", "✈️", "🚜", "🚎", "🚲", "🚂", "🛴"],
               backgroundColor: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1),
               cardBackColor: #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1))
        
    ]
    
    private var emojiChoices = [String] ()
    private var backgroundColor = UIColor.black
    private var cardBackColor = UIColor.orange
    
    
    private var indexTheme = 0 {
        didSet {
            print (indexTheme, emojiThemes[indexTheme].name)
            emoji = [Int: String]()
            titleLabel.text = emojiThemes[indexTheme].name
            
            emojiChoices = emojiThemes[indexTheme].emojis
            backgroundColor = emojiThemes[indexTheme].backgroundColor
            cardBackColor = emojiThemes[indexTheme].cardBackColor
            
            updateAppearance()
        }
    }
    
    private func updateAppearance() {
        view.backgroundColor = backgroundColor
        flipCountLabel.textColor = cardBackColor
        scoreLabel.textColor = cardBackColor
        titleLabel.textColor = cardBackColor
      
    }
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
//    var flipCount = 0 {
//        didSet {
//            
//            updateFlipLabel()
//            
//        }
//    }
    
    func updateFlipLabel() {
        let attributes: [NSAttributedString.Key: Any] = [
            .strokeWidth: 5.0,
            .strokeColor: UIColor.orange
        ]
        let attributedString = NSAttributedString(string: "Flips: \(game.flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attributedString
    }
    
   // var emojiChoices = ["👩🏻‍✈️","👩🏻‍🎨","🕵🏻","👨🏻‍💻","👨🏼‍🔬","👨🏻‍🚒","👨🏻‍🎤","👩🏻‍🏫","👩🏻‍🍳"]
    
//    var emojiChoices = "🐶🐭🦊🦋🐢🐸🐵"
    
    @IBOutlet weak var flipCountLabel: UILabel! {
        didSet {
            updateFlipLabel()
        }
    }
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indexTheme =  emojiThemes.count.arc4random
        updateViewFromModel()
        
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
        game.flipCount += 1
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
            scoreLabel.text = String(game.score)
            flipCountLabel.text = String(game.flipCount)
        }
    }
    
//    private func emoji(for card: Card) -> String {
//        if emoji[card] == nil, emojiThemes.count > 0 {
////            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
//            
//            
//            //we use string instead of array so we implement this method with indicies
//         //   emoji[card] = emojiThemes.remove(at: emojiThemes.count.arc4random)
//       
//            
//            
//            //    emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
//        }
//        return emoji[card] ?? "?"
//    }
    
//    private func emoji(for card: Card) -> String {
//        if emoji[card] == nil, emojiThemes.count > 0 {
//            let randomCollectionIndex = Int.random(in: 0..<emojiThemes.count)
//            let randomCollection = emojiThemes.remove(at: randomCollectionIndex)
//            
//            let randomEmoji: String
//            switch randomCollection {
//            case let .collection1(_, emojis), let .collection2(_, emojis), let .collection3(_, emojis), let .collection4(_, emojis), let .collection5(_, emojis), let .collection6(_, emojis):
//                randomEmoji = emojis.randomElement() ?? "?"
//           
//            }
//            
//            emoji[card] = randomEmoji
//        }
//        
//        return emoji[card] ?? "?"
//    }

  
    private func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            emoji[card.identifier] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
        return emoji[card.identifier] ?? "?"
    }
  
//
//    private func emoji(for card: Card) -> String {
//        if emoji[card] == nil, emojiThemes.count > 0 {
//            // Get a random index from the emojiThemes array
//            let randomIndex = Int.random(in: 0..<emojiThemes.count)
//
//            // Get the random EmojiCollections instance at the random index
//            let randomEmojiCollection = emojiThemes[randomIndex]
//            
//        }
//        
//        return emoji[card] ?? "?"
//    }
    
    
    @IBAction private func startNewGame(_ sender: UIButton) {
        game.flipCount = 0
        score = 0
        seenCards = []
        indexTheme =  emojiThemes.count.arc4random
        startNewRound()
    }
    func startNewRound() {
     
        for index in cards.indices  {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
        }
        cards.shuffle()
    }

    
//    func getRandomEmojiTheme() -> EmojiCollections? {
//        let randomIndex = Int.random(in: 0..<emojiThemes.count)
//        return emojiThemes[randomIndex]
//    }
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

extension Array {
    /// тасование элементов  `self` "по месту".
    mutating func shuffle() {
        // пустая коллекция и с одним элементом не тасуются
        if count < 2 { return }
        
        for i in indices.dropLast() {
            let diff = distance(from: i, to: endIndex)
            let j = index(i, offsetBy: diff.arc4random)
            swapAt(i, j)
        }
    }
}
