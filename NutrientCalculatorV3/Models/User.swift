//
//  User.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/13/22.
//

import Foundation
import SwiftUI

final class User: ObservableObject, Codable {
    
    private var poundsToKgs = 0.453592
    private var kgsToPounds = 2.20462
    private var inchesToCm = 2.54
    private var cmToInches = 0.393701
    
    var name: String = ""
    var email: String = ""

    // MARK: Height
    // We show the user an option to list their height in imperial or metric, but the height variable is calculated in inches regardless
    var heightInFeetAndInches: Bool = true
    var heightIn: Int = 68
    var heightCm: Int = 173
    var height: Int {
        if heightInFeetAndInches {
            return heightIn
        } else {
            let inches = Int((Double(heightCm) * cmToInches).rounded())
            return inches
        }
    }
    
    // MARK: Weight
    // We show the user an option to list their weight in imperial or metric, but the startingWeight variable is calculated in pounds regardless
    var weightInPounds: Bool = true
    var inputWeightLbs: String = ""
    var inputWeightKgs: String = ""
    var startingWeight: Double {
        if weightInPounds {
            return Double(inputWeightLbs) ?? 0.0
        } else {
            return (Double(inputWeightKgs) ?? 0.0) * kgsToPounds
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
    
    // MARK: Goal / Goal Weight
    var goalType: Goal = .fatloss
    var inputGoalWeightLbs: String = ""
    var inputGoalWeightKgs: String = ""
    var goalWeight: Double {
        if goalType == .maintenance {
            return startingWeight
        }
        if weightInPounds {
            return Double(inputGoalWeightLbs) ?? 0.0
        } else {
            return (Double(inputGoalWeightKgs) ?? 0.0)
        }
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
                return inputWeightChange / 4
            } else {
                return inputWeightChange * kgsToPounds / 4           // Divide by 4 to get weight change per week from the month weight change
            }
        }
    }
    
    // MARK: Calorie Preference
    var dynamicCalories: Bool = true
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
    
    // MARK: High Calorie Days
    var monday: Bool = false
    var tuesday: Bool = false
    var wednesday: Bool = false
    var thursday: Bool = false
    var friday: Bool = false
    var saturday: Bool = false
    var sunday: Bool = false
    
    //MARK: BMR, TDEE, Macros
    var maleBMR: Double { // height & weight must be converted to metric
        let weight = startingWeight * poundsToKgs * 10
        let height = Double(height) * inchesToCm * 6.25
        let age = Double(age ?? 0) * 5
        return weight + height - age + 5
    }
    
    var femaleBMR: Double { // height & weight must be converted to metric
        let weight = startingWeight * poundsToKgs * 10
        let height = Double(height) * inchesToCm * 6.25
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
            case 3.0 ... 500: // gaining 3+ lbs per week - reduce by 20%, will be reduced further in calorie calc
                return 0.8
            case 1.0 ..< 3.0: // gaining 1-3lbs per week - reduce by 10%, will be reduced further in calorie calc
                return 0.9
            case -1.0 ..< 1.0: // losing/gaining 0-1lb per week - effectively maintenance
                return 1.0
            case -3.0 ..< -1.0: // calories are where they should be to start (so we increase them here to account for fat loss multiplier)
                return 1.15
            default: // calories are too low - losing more than 4lbs per week (increase by 10%)
                return 1.3
            }
            
        // MARK: NEED THESE!!!!!!!!
        case .muscleGrowth:
            return 0.0
        case .maintenance:
            return 0.0
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
    var startingCalories: Double {
        switch goalType {
        case .fatloss:
            return maintenanceCalories * 0.875
        case .muscleGrowth:
            return maintenanceCalories * 1.125
        case .maintenance:
            return maintenanceCalories
        }
    }
    
    //MARK: Fats
    var fats: Double {
        switch inputCalories {
        case "":
            switch startingWeight {
            case 0.0..<200.0:
                return startingWeight * poundsToKgs * 1.1
            case 200.0..<250.0:
                return startingWeight * poundsToKgs * 1.05
            case 250.0..<300.0:
                return startingWeight * poundsToKgs * 0.975
            case 300.0..<350.0:
                return startingWeight * poundsToKgs * 0.925
            default:
                return startingWeight * poundsToKgs * 0.875
            }
        default:
            return startingCalories * 0.25 / 9
        }
        
    }
    
    //MARK: Carbs
    var carbs: Double {
        return (startingCalories - (9 * fats) - (4 * protein)) / 4
    }
    
    //MARK: Protein
    var protein: Double {
        switch activityLevel {
        case .none:
            switch startingWeight {
            case 0.0..<200.0:
                return startingWeight * 0.95
            case 200.0..<250.0:
                return startingWeight * 0.9
            case 250.0..<300.0:
                return startingWeight * 0.8
            case 300.0..<350.0:
                return startingWeight * 0.7
            default:
                return startingWeight * 0.6
            }
        case .low:
            switch startingWeight {
            case 0.0..<200.0:
                return startingWeight * 0.975
            case 200.0..<250.0:
                return startingWeight * 0.95
            case 250.0..<300.0:
                return startingWeight * 0.825
            case 300.0..<350.0:
                return startingWeight * 0.725
            default:
                return startingWeight * 0.625
            }
        case .moderate:
            switch startingWeight {
            case 0.0..<200.0:
                return startingWeight * 1
            case 200.0..<250.0:
                return startingWeight * 1
            case 250.0..<300.0:
                return startingWeight * 0.875
            case 300.0..<350.0:
                return startingWeight * 0.75
            default:
                return startingWeight * 0.65
            }
        case .high:
            switch startingWeight {
            case 0.0..<200.0:
                return startingWeight * 1.05
            case 200.0..<250.0:
                return startingWeight * 1.025
            case 250.0..<300.0:
                return startingWeight * 0.9
            case 300.0..<350.0:
                return startingWeight * 0.775
            default:
                return startingWeight * 0.675
            }
        case .extreme:
            switch startingWeight {
            case 0.0..<200.0:
                return startingWeight * 1.1
            case 200.0..<250.0:
                return startingWeight * 1.05
            case 250.0..<300.0:
                return startingWeight * 0.925
            case 300.0..<350.0:
                return startingWeight * 0.8
            default:
                return startingWeight * 0.7
            }
        }
    }
}
