//
//  User.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/13/22.
//

import Foundation
import SwiftUI

final class User: ObservableObject, Codable {
    
    
    var name: String = ""

    // MARK: Height
    // We show the user an option to list their height in imperial or metric, but the height variable is calculated in centimeters regardless
    var heightInFeetAndInches: Bool = true
    var heightCm: Int = 173
    var heightIn: Int = 68
    var height: Int {
        let inchesToCm = 2.54
            if heightInFeetAndInches {
                let cm = Int((Double(heightIn) * inchesToCm).rounded())
                return cm
            } else {
                return heightCm
            }
        }
    
    // MARK: Weight
    // We show the user an option to list their weight in imperial or metric, but the startingWeight variable is calculated in kgs regardless
    var weightInPounds: Bool = true
    var inputWeight: String = ""
    var updateInputWeight: String = ""
    var startingWeight: Double {
        let poundsToKgs = 0.453592
        if weightInPounds {
            return (Double(inputWeight) ?? 0.0) * poundsToKgs
        } else {
            return Double(inputWeight) ?? 0.0
        }
    }

    // MARK: Age
    // User inputs birthdate, we calculate age. Default age is 30
    var birthday: Date = Calendar.current.date(byAdding: .year, value: -30, to: Date()) ?? Date()
    var age: Int? {
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: birthday, to: Date())
        return ageComponents.year
    }
    
    // MARK: Sex
    var sex: String = "Male"
    
    
    // MARK: Activity
    var stepsPerDay: StepAmounts = .moderate // Possiblities: 1,2,3,4,5 (none, low, moderate, high, extreme)
    var trainingSessionsPerWeek: WorkoutsPerWeek = .moderate // Possibilites: 1,3,5,8,10 (none, low, moderate, high, extreme)

    var totalIntensityScore: Int {
        return (stepsPerDay.stepIntensityScore() + trainingSessionsPerWeek.workoutIntensityScore()) // 15 is the heighest possible intensity score
    }
    
    var activityLevel: ActivityLevel {
        switch totalIntensityScore {
        case 2..<5:
            return .none
        case 5..<7:
            return .low
        case 7..<10:
            return .moderate
        case 10..<13:
            return .high
        case 13..<16:
            return .extreme
        default:
            return .none
        }
    }
    
    // MARK: Goal    
    var goalType: Goal = .fatloss
    var goalWeightLbs: String = ""
    var goalWeightKgs: String = ""
    var goalWeight: Double {
        if goalType == .maintenance {
            return startingWeight
        }
        if weightInPounds {
            let poundsToKgs = 0.453592
            return (Double(goalWeightLbs) ?? 1) * poundsToKgs
        } else {
            return Double(goalWeightKgs) ?? 1.0
        }
    }
    
    // MARK: Current Macros
    // Used in onboarding screens
    var inputFats: String = ""
    var inputCarbs: String = ""
    var inputProtein: String = ""
    var inputCalories: String = ""
    var inputWeightChange: Double = 0.0
    
}
