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
    private var incorrectGuesses = 0
    private var totalGuesses = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createGuessRows()
        updateUi()
    }
    private func updateUi() {
        let current = getCurrentCardNumber().toString()
        let total = deckSize.toString()
        cardCountTextView.text = "${current} of ${total}"
        if (nildifficulty?.equals(Difficulty.EASY)??true){
            timeRemainingTextView.visibility = View.GONE
        }
//        Glide.with(this)
//            .load(baseUrl + nilcorrectCard?.photoUrl)
//            .apply(RequestOptions()
//                .diskCacheStrategy(DiskCacheStrategy.ALL)
//                .centerInside())
//            .into(equipmentImageView)
        populateGuessButtons()
    }
    func createGuessRows() {
        for i in 0 ..< difficulty?.ordinal ?? 0 {
            let inflater = LayoutInflater.from(activity)
            let guessRow = inflater.inflate(R.layout.row_cards, nil, false)
            let choice0 = guessRow.findViewById<Button>(R.id.choice0)
            let choice1 = guessRow.findViewById<Button>(R.id.choice1)
            let choice2 = guessRow.findViewById<Button>(R.id.choice2)
            choice0.setOnClickListener(guessClickListener)
            choice1.setOnClickListener(guessClickListener)
            choice2.setOnClickListener(guessClickListener)
            guessLinearLayout.addView(guessRow)
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
            let guess = button?.text.toString()
            if ((nilcheckGuessAndIncrementTotal(guess) ?? false)||button==nil){ //Go to next card
                reactivateGuessButtons()
                if (nilisEnd() ?? false){ //Last answer
                    nilstopTimer()
                    let percentage = nilcalculateCorrectPercentage() ?? 0
                    let builder = AlertDialog.Builder(context, android.R.style.Theme_Material_Dialog_Alert)
                    builder.setTitle("Quiz Completed")
                        .setMessage("You got ${percentage}% correct.")
                        .setPositiveButton("Restart Quiz") { dialog, which ->
                            nilresetTest()
                            updateUi()
                        }
                        .setNegativeButton("Change Quiz") { dialog, which ->
                            activity?.fragmentFrameLayout?.id?.let {
                                let cardsSetupFragment = CardsSetupFragment()
                                let transaction = activity?.supportFragmentManager
                                transaction?.beginTransaction()?.replace(it, cardsSetupFragment, cardsSetupFragment.TAG)?.commit()
                            }
                        }
                        .show()
                } else { //Not last answer
                    nilsetNextCardGetChoicesResetTimer()
                    updateUi()
                }
            } else {//Incorrect answer
                button?.isEnabled = false
            }
        }
    }
    let timeObserver = Observer<Int> { timeRemaining ->
        let timeText = "00:${String.format("%02d", timeRemaining)} Remaining"
        timeRemainingTextView.text = timeText
        if (timeRemaining != nil && timeRemaining < 1) {
            guessClickListener.onClick(nil)
        }
    }
    
    func getCurrentCardNumber()->Int{
        return currentDeckIndex + 1
        //return totalGuesses - incorrectGuesses + 1
    }
    private func generateCards(){
        let possibleCards = equipment.letue?.filter { selectedTypes.contains(it.type) }
        if (deckSize > possibleCards?.size ?? 0){
            cards.addAll(0,possibleCards as? Collection<Equipment> ?? return)
            deckSize = possibleCards.size
        } else {
            Collections.shuffle(possibleCards)
            for (i in 0 ..< deckSize) {
                let card = possibleCards?.get(i)
                cards.add(card ?? return)
            }
        }
    }
    private func generateChoices(correctCard: Equipment?){
        let possibleCards = equipment.letue ?? ArrayList<Equipment>()
        Collections.shuffle(possibleCards)
        var i = -1
        choices.removeAll{true}
        while (choices.size < difficulty.choices && i < possibleCards.lastIndex){
            i++
            if (possibleCards.get(i).name.equals(correctCard?.name)) continue //Don't add correct answer yet
            choices.add(shorten(possibleCards.get(i).name))
        }
        correctChoiceIndex = (0 .. difficulty.choices).random()
        choices[correctChoiceIndex] = (shorten(correctCard?.name??"")) //choices fully generated
    }
    func checkGuessAndIncrementTotal(selectedAnswer: String)->Bool{
        let correct = selectedAnswer == choices.get(correctChoiceIndex)
        totalGuesses = totalGuesses + 1
        if !correct {incorrectGuesses = incorrectGuesses + 1
        return correct
    }
    func setNextCardGetChoicesResetTimer(){
        currentDeckIndex++
        if (currentDeckIndex >= cards.size) return
        correctCard = cards.get(currentDeckIndex)
        generateChoices(correctCard)
        resetTimer()
    }
    func isEnd()->Bool{
        return (currentDeckIndex >= cards.lastIndex)
    }
    func calculateCorrectPercentage()-> Int{
        return (((totalGuesses - incorrectGuesses).toDouble()) / (totalGuesses.toDouble()) * 100).toInt()
    }
    func resetTest(){
        totalGuesses = 0
        incorrectGuesses = 0
        currentDeckIndex = -1
        cards = ArrayList()
        generateCards()
        setNextCardGetChoicesResetTimer()
    }
    private var timer = Timer()
    func stopTimer(){
        timer.cancel()
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
        when (difficulty) {
            Difficulty.EASY -> timeRemaining = 999
            Difficulty.MEDIUM -> timeRemaining = 11
            Difficulty.HARD -> timeRemaining = 6
        }
    }
    
    // A helper method to take the string returned by toString and shorten it
    private func shorten(longName: String)-> String {
        let descriptionStart = longName.indexOf(";")
        return if (descriptionStart > 0) {
            longName.substring(0, descriptionStart)
        } else {
            longName
        }
    }
}
