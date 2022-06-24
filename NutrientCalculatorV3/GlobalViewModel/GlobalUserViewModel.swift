//
//  GlobalUserViewModel.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/13/22.
//

import Foundation


class GlobalUserViewModel: ObservableObject {
    
    @Published var user = User()
    @Published var alertItem: AlertItem?
    
    
    //MARK: Validate Forms ----------
    let fiftyPounds = 22.6796
    let oneThousandPounds = 453.592
    let poundsToKgs = 0.453592
    
    //MARK: * validate weight
    // Checking to make sure user entered a valid weight between 55.0 and 1000.0 pounds on WeightView (453.592kg = 1000lbs)
    func isValidWeight() -> Bool {
        if user.inputWeight.isEmpty || user.startingWeight < fiftyPounds || user.startingWeight > oneThousandPounds {
            alertItem = AlertContext.invalidWeight
            return false
        }
        return true
    }
    
    func isValidUpdateWeight() -> Bool {
        if user.updateInputWeight.isEmpty {
            alertItem = AlertContext.invalidWeight
            return false
        }
        
        if user.weightInPounds {
            if (Double(user.updateInputWeight) ?? 0) * poundsToKgs < fiftyPounds || (Double(user.updateInputWeight) ?? 0) * poundsToKgs > oneThousandPounds {
                alertItem = AlertContext.invalidWeight
                return false
            }
        }
        
        if !user.weightInPounds {
            if (Double(user.updateInputWeight) ?? 0) < fiftyPounds || (Double(user.updateInputWeight) ?? 0) > oneThousandPounds {
                alertItem = AlertContext.invalidWeight
                return false
            }
        }
        
        return true
    }
    
    //MARK: * validate goal weight
    func isValidGoalWeight() -> Bool {
        if user.goalType == .fatloss && user.goalWeight < fiftyPounds {
            alertItem = AlertContext.invalidFatLossGoal
            return false
        }
        if user.goalType == .fatloss && Double(user.goalWeight) > user.startingWeight - 0.1 {
            alertItem = AlertContext.invalidFatLossGoal
            return false
        }
        if user.goalType == .muscleGrowth && user.goalWeight < fiftyPounds {
            alertItem = AlertContext.invalidMuscleGrowthGoal
            return false
        }
        if user.goalType == .muscleGrowth && Double(user.goalWeight) < user.startingWeight + 0.1 {
            alertItem = AlertContext.invalidMuscleGrowthGoal
            return false
        }
        
        return true
    }
    
    //MARK: * validate current macros
    //assigning calculated value of inputCalories if all macros are entered
    func isValidCurrentMacros() -> Bool {
        if user.inputFats != "" && user.inputCarbs != "" && user.inputProtein != "" {
            user.inputCalories = calculateInputCalories()
            return true
        }
        
        if user.inputCalories == "" && (user.inputFats != "" || user.inputCarbs != "" || user.inputProtein != "") {
            alertItem = AlertContext.invalidMacros
            return false
        }
        
        if user.inputCalories == "" {
            user.inputWeightChange = 0.0
        }
        return true
    }
    
    //MARK: Calculate Current Calories --
    func calculateInputCalories() -> String {
        return "\(Int((calculateInputFatCalories() + calculateInputCarbCalories() + calculateInputProteinCalories()).rounded()))"
    }
    
    private func calculateInputFatCalories() -> Double {
        let fats = Double(user.inputFats) ?? 0
        return 9 * fats
    }
    
    private func calculateInputCarbCalories() -> Double {
        let carbs = Double(user.inputCarbs) ?? 0
        return 4 * carbs
    }
    
    private func calculateInputProteinCalories() -> Double {
        let protein = Double(user.inputProtein) ?? 0
        return 4 * protein
    }
}
