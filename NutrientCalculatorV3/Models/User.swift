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
    var email: String = ""

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
    var updateHeightInFeetAndInches: Bool = true
    var updateHeightCm: Int {
        get { heightCm }
        set { heightCm = newValue }
    }
    var updateHeightIn: Int {
        get { heightIn }
        set { heightIn = newValue }
    }
    
    // MARK: Weight
    // We show the user an option to list their weight in imperial or metric, but the startingWeight variable is calculated in kgs regardless
    var weightInPounds: Bool = true
    var inputWeight: String = ""
    var startingWeight: Double {
        let poundsToKgs = 0.453592
        if weightInPounds {
            return (Double(inputWeight) ?? 0.0) * poundsToKgs
        } else {
            return Double(inputWeight) ?? 0.0
        }
    }
    var currentWeight: Double {
        startingWeight
    }

    // MARK: Age
    // User inputs birthdate, we calculate age. Default age is 30
    var birthday: Date = Calendar.current.date(byAdding: .year, value: -30, to: Date()) ?? Date()
    var age: Int? {
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: birthday, to: Date())
        return ageComponents.year
    }
    var updateBirthday: Date {
        get { birthday }
        set { birthday = newValue }
    }
    
    // MARK: Sex
    var sex: String = "Male"
    var updateSex: String {
        get { sex }
        set { sex = newValue }
    }
    
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
    
    var updateStepsPerDay: StepAmounts {
        get { stepsPerDay }
        set { stepsPerDay = newValue }
    }
    var updateTrainingSessionsPerWeek: WorkoutsPerWeek {
        get { trainingSessionsPerWeek }
        set { trainingSessionsPerWeek = newValue }
    }
    var updateTotalIntensityScore: Int {
        return (updateStepsPerDay.stepIntensityScore() + updateTrainingSessionsPerWeek.workoutIntensityScore())
    }
    var updateActivityLevel: ActivityLevel {
        switch updateTotalIntensityScore {
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
    
    // MARK: Goal / Goal Weight
    var goalType: Goal = .fatloss
    var inputGoalWeight: String = ""
    var goalWeight: Double {
        if goalType == .maintenance {
            return startingWeight
        }
        if weightInPounds {
            let poundsToKgs = 0.453592
            return (Double(inputGoalWeight) ?? 0.0) * poundsToKgs
        } else {
            return Double(inputGoalWeight) ?? 0.0
        }
    }
    var updateGoalType: Goal {
        get { goalType }
        set { goalType = newValue }
    }
    var updateGoalWeight: String {
        get { inputGoalWeight }
        set { inputGoalWeight = newValue }
    }
    
    // MARK: Input Macros (Onboarding)
    var inputFats: String = ""
    var inputCarbs: String = ""
    var inputProtein: String = ""
    var inputCalories: String = ""
    var inputWeightChange: Double = 0.0
    var weeklyInputWeightChange: Double {
        if inputWeightChange == 0.0 {
            return 0.0
        } else {
            if weightInPounds {
                let poundsToKgs = 0.453592
                return inputWeightChange * poundsToKgs / 4           // Divide by 4 to get weight change per week from the month weight change
            } else {
                return inputWeightChange / 4
            }
        }
    }
    
    // MARK: Calorie Preference
    var dynamicCalories: Bool = true
    var updateDynamicCalories: Bool {
        get { dynamicCalories }
        set { dynamicCalories = newValue }
    }
    var dynamicCalorieVariance: Double = 15
    var dynamicCalorieVarianceDescription: String {
        if dynamicCalorieVariance <= 11 {
            return "Low"
        } else if dynamicCalorieVariance <= 18 {
            return "Moderate"
        } else if dynamicCalorieVariance <= 25 {
            return "High"
        } else {
            return "n/a"
        }
    }
    var dynamicCalorieVarianceDescriptionTextColor: Color {
        if dynamicCalorieVarianceDescription == "Low" {
            return Color.blue
        } else if dynamicCalorieVarianceDescription == "Moderate" {
            return Color.green
        } else if dynamicCalorieVarianceDescription == "High" {
            return Color.red
        } else {
            return Color.accentColor
        }
    }
    var updateDynamicCalorieVariance: Double {
        get { dynamicCalorieVariance }
        set { dynamicCalorieVariance = newValue }
    }
    
    // MARK: High Calorie Days
    var monday: Bool = false
    var tuesday: Bool = false
    var wednesday: Bool = false
    var thursday: Bool = false
    var friday: Bool = false
    var saturday: Bool = false
    var sunday: Bool = false
    var updateMonday: Bool {
        get { monday }
        set { monday = newValue }
    }
    var updateTuesday: Bool {
        get { tuesday }
        set { tuesday = newValue }
    }
    var updateWednesday: Bool {
        get { wednesday }
        set { wednesday = newValue }
    }
    var updateThursday: Bool {
        get { thursday }
        set { thursday = newValue }
    }
    var updateFriday: Bool {
        get { friday }
        set { friday = newValue }
    }
    var updateSaturday: Bool {
        get { saturday }
        set { saturday = newValue }
    }
    var updateSunday: Bool {
        get { sunday }
        set { sunday = newValue }
    }
    
    //MARK: BMR, TDEE, Macros
    var maleBMR: Double {
        let weight = startingWeight * 10
        let height = Double(height) * 6.25
        let age = Double(age ?? 0) * 5
        return weight + height - age + 5
    }
    
    var femaleBMR: Double {
        let weight = startingWeight * 10
        let height = Double(height) * 6.25
        let age = Double(age ?? 0) * 5
        return weight + height - age - 161
    }
    
    var activityMultiplier: Double {
        switch activityLevel {
        case .none:
            return 1.2
        case .low:
            return 1.375
        case .moderate:
            return 1.55
        case .high:
            return 1.725
        case .extreme:
            return 1.9
        }
    }
    
    var inputCalorieMultiplier: Double {
        switch goalType {
        case .fatloss:
            switch weeklyInputWeightChange {
            case 3.0 ... 1000: // gaining 3+ lbs per week - reduce by 15%, will be reduced further in calorie calc
                return 0.8
            case 1.0 ..< 3.0: // gaining 1-3lbs per week - reduce by 7.5%, will be reduced further in calorie calc
                return 0.9
            case -1.0 ..< 1.0: // losing/gaining 0-1lb per week - effectively maintenance
                return 1.0
            case -3.0 ..< -1.0: // calories are where they should be to start (so we increase them here to account for fat loss multiplier)
                return 1.15
            default: // calories are too low - losing more than 4lbs per week (increase by 10%)
                return 1.3
            }
        case .muscleGrowth:
            <#code#>
        case .maintenance:
            <#code#>
        }
        
        
        case "Fat Loss":
            
        //Add Maintenance
        //Add Muscle Growth
        default:
            return 1.0
        }
    }
    
    var maintenanceCalories: Double { //switch on inputCalories
        switch inputCalories {
        case "": // if no input calories are entered, use regular calculations
            if sex == "Male" {
                return maleBMR * activityMultiplier
            } else {
                return femaleBMR * activityMultiplier
            }
        default: // if input calories are entered calculate off of those
            return inputCalorieMultiplier * (Double(inputCalories) ?? 0)
        }
    }
    // MARK: Starting Calories/Macros
    var startingCalories: Double
}
