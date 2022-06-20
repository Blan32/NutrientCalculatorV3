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
    
    let fiftyPounds = 22.6796
    let oneThousandPounds = 453.592
    
    // Checking to make sure user entered a valid weight between 55.0 and 1000.0 pounds on WeightView (453.592kg = 1000lbs)
    var isValidWeight: Bool {
        if user.weightLbs.isEmpty && user.weightKgs.isEmpty || user.startingWeight < fiftyPounds || user.startingWeight > oneThousandPounds {
            alertItem = AlertContext.invalidWeight
            return false
        }
        return true
    }
    
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
}
