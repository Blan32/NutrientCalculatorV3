//
//  StepAmountsEnum.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/14/22.
//

import Foundation
import SwiftUI

//MARK: Step Amounts
enum StepAmounts: String, CaseIterable, Codable {        // Relative intensity weightings:
    case none =     "0 - 3,000"                 // 1
    case low =      "3,000 - 6,000"             // 2
    case moderate = "6,000 - 9,000"             // 3
    case high =     "9,000 - 12,000"            // 4
    case extreme =  "12,000+"                   // 5
    
    // Relative intensity weighting for total activity level calculation
    func stepIntensityScore() -> Int {
        switch self {
        case .none:
            return 1
        case .low:
            return 2
        case .moderate:
            return 3
        case .high:
            return 4
        case .extreme:
            return 5
        }
    }
    
    func stepIntensityColor() -> Color {
        switch self {
        case .none:
            return Color.accentColor
        case .low:
            return Color.blue
        case .moderate:
            return Color.green
        case .high:
            return Color.yellow
        case .extreme:
            return Color.red
        }
    }
}

//MARK: Workouts Per Week
enum WorkoutsPerWeek: String, CaseIterable, Codable {    // Relative intensity weightings:
    case none =     "Little to none"     // 1
    case low =      "1 - 2"         // 3
    case moderate = "3 - 5"         // 5
    case high =     "6 - 7"         // 8
    case extreme =  "8+"           // 10
    
    // Relative intensity weighting for total activity level calculation
    func workoutIntensityScore() -> Int {
        switch self {
        case .none:
            return 1
        case .low:
            return 3
        case .moderate:
            return 5
        case .high:
            return 8
        case .extreme:
            return 10
        }
    }
    
    func workoutIntensityColor() -> Color {
        switch self {
        case .none:
            return Color.accentColor
        case .low:
            return Color.blue
        case .moderate:
            return Color.green
        case .high:
            return Color.yellow
        case .extreme:
            return Color.red
        }
    }
}

//MARK: Activity Level
enum ActivityLevel: String {
    case none =     "Little to None"    //"2 - 4 / 15"
    case low =      "Low"               //"5 - 6 / 15"
    case moderate = "Moderate"          //"7 - 9 / 15"
    case high =     "High"              //"10 - 12 / 15"
    case extreme =  "Extreme"           //"13 - 15 / 15"
    
    func intensityColor() -> Color {
        switch self {
        case .none:
            return Color.accentColor
        case .low:
            return Color.blue
        case .moderate:
            return Color.green
        case .high:
            return Color.yellow
        case .extreme:
            return Color.red
        }
    }
}

//MARK: Total Intensity Score Range
// Total intensity score ranges (steps + workouts)
// 2 - 4 = none
// 5 - 6 = low
// 7 - 9 = moderate
// 10 - 12 = High
// 13 - 15 = extreme
