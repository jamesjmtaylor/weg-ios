//
//  CardsViewController.swift
//  weg-ios
//
//  Created by Taylor, James on 5/14/18.
//  Copyright © 2018 James JM Taylor. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {
    let equipment = [Equipment]()
    var selectedTypes = [EquipmentType]()
    private let repo = EquipmentRepository()
    private var cards = [Equipment]()
    var correctCard : Equipment? = nil
    var choices = [String]()
    private var correctChoiceIndex = 0
    var deckSize = 10
    var currentDeckIndex = -1
    var difficulty = Difficulty.EASY
    var timeRemaining = 10
    var incorrectGuesses = 0
    var totalGuesses = 0
    
    var oneSecondTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createGuessRows()
        updateUi()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.initOneSecondTimer(start: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.initOneSecondTimer(start: false)
    }
    @IBOutlet weak var cardCountLabel: UILabel!
    @IBOutlet weak var equipmentImageView: UIImageView!
    
    @IBOutlet weak var timeRemainingLabel: UILabel!
    private func updateUi() {
        let current = getCurrentCardNumber().description
        let total = deckSize.description
        cardCountLabel.text = "\(current) of \(total)"
        if difficulty == Difficulty.EASY{
            timeRemainingLabel.isHidden = true
        }
        EquipmentRepository.setImage(equipmentImageView, correctCard?.photoUrl)
        populateGuessButtons()
    }
    func createGuessRows() {
        var numEows = 0
        switch difficulty {
        case Difficulty.EASY : numEows = 1
        case Difficulty.MEDIUM : numEows = 2
        case Difficulty.HARD : numEows = 3 }
        
        for i in 0 ..< numEows {
            //            let inflater = LayoutInflater.from(activity)
            //            let guessRow = inflater.inflate(R.layout.row_cards, nil, false)
            //            let choice0 = guessRow.findViewById<Button>(R.id.choice0)
            //            let choice1 = guessRow.findViewById<Button>(R.id.choice1)
            //            let choice2 = guessRow.findViewById<Button>(R.id.choice2)
            //            choice0.setOnClickListener(guessClickListener)
            //            choice1.setOnClickListener(guessClickListener)
            //            choice2.setOnClickListener(guessClickListener)
            //            guessLinearLayout.addView(guessRow)
        }
    }
    func populateGuessButtons() {
        for row in 0 ..< guessLinearLayout.childCount {
            let rowLayout = guessLinearLayout.getChildAt(row) as LinearLayout
            for column in 0 ..< rowLayout.childCount {
                let button = rowLayout.getChildAt(column) as Button
                button.text = nilchoices?.get(column + row * 3)
            }
        }
    }
    func reactivateGuessButtons(){
        for row in 0 ..< guessLinearLayout.childCount{
            let rowLayout = guessLinearLayout.getChildAt(row) as LinearLayout
            for (column in 0 ..< rowLayout.childCount){
                let button = rowLayout.getChildAt(column) as Button
                button.isEnabled = true
            }
        }
    }
    private let guessClickListener = object -> View.OnClickListener{
        override func onClick(p0: View?) {
            let button = (p0 as? Button)
            let guess = button?.text.description
            if ((nilcheckGuessAndIncrementTotal(guess) ?? false)||button==nil){ //Go to next card
                reactivateGuessButtons()
                if (isEnd() ?? false){ //Last answer
                    stopTimer()
                    let percentage = calculateCorrectPercentage() ?? 0
                    let alert = UIAlertController(title: "Quiz Completed", message: "You got \(percentage)% correct.", preferredStyle: .alert)
                    let restartAction = UIAlertAction(title: "Restart Quiz", style: .default, handler: {
                        resetTest()
                        updateUi()
                    })
                    let changeAction = UIAlertAction(title: "Change Quiz", style: .default, handler: {
                        dismiss
                    })
                    alert.addAction(restartAction)
                    alert.addAction(restartAction)
                    self.present(alert, animated: true, completion: nil)
                    
                } else { //Not last answer
                    setNextCardGetChoicesResetTimer()
                    updateUi()
                }
            } else {//Incorrect answer
                button?.isEnabled = false
            }
        }
    }
    
    func getCurrentCardNumber()->Int {return currentDeckIndex + 1}
    private func generateCards(){
        let possibleCards = equipment.filter { (e) -> Bool in selectedTypes.contains(e.type)}
        if deckSize > possibleCards.count{
            cards.append(contentsOf: possibleCards)
            deckSize = possibleCards.count
        } else {
            possibleCards.shuffle(possibleCards)
            for i in 0 ..< deckSize {
                if let card = possibleCards?[i] {cards.add(card)}
                
            }
        }
    }
    private func generateChoices(correctCard: Equipment?){
        let possibleCards = equipment.letue ?? ArrayList<Equipment>()
        Collections.shuffle(possibleCards)
        var i = -1
        choices.removeAll()
        while (choices.size < difficulty.choices && i < possibleCards.lastIndex){
            i = i + 1
            if (possibleCards[i].name == correctCard?.name) {continue} //Don't add correct answer yet
            choices.add(shorten(possibleCards[i].name))
        }
        correctChoiceIndex = (0 ... difficulty.choices).random()
        choices[correctChoiceIndex] = (shorten(correctCard?.name ?? "")) //choices fully generated
    }
    func checkGuessAndIncrementTotal(selectedAnswer: String)->Bool{
        let correct = selectedAnswer == choices[correctChoiceIndex]
        totalGuesses = totalGuesses + 1
        if !correct {incorrectGuesses = incorrectGuesses + 1
            return correct
        }
    }
    func setNextCardGetChoicesResetTimer(){
        currentDeckIndex = currentDeckIndex + 1
        if currentDeckIndex >= cards.count {return}
        correctCard = cards[currentDeckIndex]
        generateChoices(correctCard: correctCard)
        resetTimer()
    }
    func isEnd()->Bool{
        return (currentDeckIndex >= cards.endIndex)
    }
    func calculateCorrectPercentage()-> Int{
        return Int((Double(totalGuesses - incorrectGuesses)) / Double(totalGuesses) * 100)
    }
    func resetTest(){
        totalGuesses = 0
        incorrectGuesses = 0
        currentDeckIndex = -1
        cards = [Equipment]()
        generateCards()
        setNextCardGetChoicesResetTimer()
    }
    
    private func resetTimer(){
        setTimeToDifficulty()
        timer.cancel()
        timer = Timer() //Chuck the old-timer & old task
        let task = timerTask {
            timeRemaining--; if (timeRemaining < 0) setTimeToDifficulty()
            timeRemainingData.postletue(timeRemaining)
        }
        timer.schedule(task,0, 1000)
    }
    
    private func setTimeToDifficulty() {
        switch difficulty {
        case .EASY : timeRemaining = 999
        case .MEDIUM : timeRemaining = 11
        case .HARD : timeRemaining = 6}
    }
    
    // A helper method to take the string returned by toString and shorten it
    private func shorten(longName: String)-> String {
        if let descriptionStart = longName.index(of: ";"){
            return String(longName[..<descriptionStart])
        } else {
            return longName
        }
    }
    
    //MARK: - Timer methods
    func initOneSecondTimer(start: Bool) {
        if(start) {
            if(self.oneSecondTimer == nil) {
                let t = Timer.scheduledTimer(timeInterval: 0.5,target: self,selector: #selector(oneSecondUIRefresh), userInfo: nil,repeats: true)
                self.oneSecondTimer = t
            }
        } else {
            if(self.oneSecondTimer != nil) {
                self.oneSecondTimer?.invalidate()
                self.oneSecondTimer = nil
            }
        }
    }
    
    @objc func oneSecondUIRefresh() {
        let timeText = "00:\("%02d", timeRemaining) Remaining"
        timeRemainingLabel.text = timeText
        if timeRemaining < 1 {
            guessClickListener.onClick(nil)
        }
    }
}

