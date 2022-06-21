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
    
    //MARK: * valid weight
    // Checking to make sure user entered a valid weight between 55.0 and 1000.0 pounds on WeightView (453.592kg = 1000lbs)
    var isValidWeight: Bool {
        if user.weightLbs.isEmpty && user.weightKgs.isEmpty || user.startingWeight < fiftyPounds || user.startingWeight > oneThousandPounds {
            alertItem = AlertContext.invalidWeight
            return false
        }
        return true
    }
    
    //MARK: * valid goal weight
    var isValidGoalWeight: Bool {
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
        
        if user.inputCalories == "" {
            alertItem = AlertContext.invalidMacros
            return false
        }
        return true
    }
    
    //MARK: Calculate Current Calories --
    func calculateInputCalories() -> String {
        return "\(calculateInputFatCalories() + calculateInputCarbCalories() + calculateInputProteinCalories())"
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
