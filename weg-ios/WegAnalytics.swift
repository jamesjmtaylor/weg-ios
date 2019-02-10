//
//  WegAnalytics.swift
//  weg-ios
//
//  Created by James Taylor on 2/10/19.
//  Copyright © 2019 James JM Taylor. All rights reserved.
//

import Foundation
import Firebase

func saveQuizResults(categories: String, score: Int, difficulty: Difficulty) {
    var difficultyInt = -1
    switch difficulty {
    case Difficulty.EASY: difficultyInt = 0
    case Difficulty.MEDIUM: difficultyInt = 1
    case Difficulty.HARD: difficultyInt = 2
    }
    Analytics.logEvent(AnalyticsEventPostScore, parameters: [
        AnalyticsParameterCharacter:categories,
        AnalyticsParameterScore:score,
        AnalyticsParameterLevel:difficultyInt,
        ])
}

func saveUserSearch(searchQuery: String, resultCount: Int) {
    Analytics.logEvent(AnalyticsEventSearch, parameters: [
        AnalyticsParameterSearchTerm:searchQuery,
        AnalyticsParameterNumberOfNights:resultCount
        ])
}

func saveEquipmentView(equipmentName: String, category: String) {
    Analytics.logEvent(AnalyticsEventViewItem, parameters: [
        AnalyticsParameterItemCategory:category,
        AnalyticsParameterItemName:equipmentName
        ])
}

func saveTabView(tabName: String) {
    Analytics.logEvent(AnalyticsEventViewItemList, parameters: [
        AnalyticsParameterItemCategory:tabName
        ])
}
