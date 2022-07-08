//
//  GlobalUserViewModel.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/13/22.
//

import SwiftUI

class GlobalUserViewModel: ObservableObject {
        
    @AppStorage("user") private var userData: Data?
    @AppStorage("new_user") var newUser: Bool = true
    
    @Published var user = User()
    @Published var alertItem: AlertItem?
    
    //MARK: Save Profile / Sign In
    func saveProfile() {
        do {
            let data = try JSONEncoder().encode(user)
            userData = data
            signIn()
        } catch {
            alertItem = AlertContext.invalidUserData
        }
    }
    
    func signIn() {
        newUser = false
    }
    
    func signOut() {
        newUser = true
    }
    
    // MARK: Retrieve User
    func retrieveUser() {
        guard let userData = userData else {
            return
        }
        
        do {
            user = try JSONDecoder().decode(User.self, from: userData)
        } catch {
            alertItem = AlertContext.invalidUserData
        }
    }
    
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
    
    //MARK: * validate goal weight
    func isValidGoalWeight() -> Bool {
        if user.goalWeight < fiftyPounds || user.goalWeight > oneThousandPounds {
            alertItem = AlertContext.invalidWeight
            return false
        }
        if user.goalType == .fatloss && Double(user.goalWeight) > user.currentWeight - 0.1 {
            alertItem = AlertContext.invalidFatLossGoal
            return false
        }

        if user.goalType == .muscleGrowth && Double(user.goalWeight) < user.currentWeight + 0.1 {
            alertItem = AlertContext.invalidMuscleGrowthGoal
            return false
        }
        
        return true
    }
    
    //MARK: * validate new goal weight
    func isValidUpdateGoalWeight() -> Bool {
        // Check if textfield is empty
        if user.updateGoalWeight.isEmpty && user.goalType != .maintenance {
            alertItem = AlertContext.invalidWeight
            return false
        }
        
        // Check if updateGoalWeight is less than 50lbs or greater than 1000lbs (which would be invalid)
        if user.weightInPounds {
            if (Double(user.updateGoalWeight) ?? 0) * poundsToKgs < fiftyPounds || (Double(user.updateGoalWeight) ?? 0) * poundsToKgs > oneThousandPounds {
                alertItem = AlertContext.invalidWeight
                return false
            }
        } else if !user.weightInPounds {
            if (Double(user.updateGoalWeight) ?? 0) < fiftyPounds || (Double(user.updateGoalWeight) ?? 0) > oneThousandPounds {
                alertItem = AlertContext.invalidWeight
                return false
            }
        }
        
        // Check if updateGoalWeight makes sense based on goalType (less for fatloss, more for muscle growth) if weightInPounds convert updateGoalWeight to Kg before comparison
        if user.weightInPounds {
            if user.goalType == .fatloss && (Double(user.updateGoalWeight) ?? 0.0) * poundsToKgs > user.currentWeight - 0.1 {
                alertItem = AlertContext.invalidFatLossGoal
                return false
            } else if user.goalType == .muscleGrowth && (Double(user.updateGoalWeight) ?? 0.0) * poundsToKgs < user.currentWeight + 0.1 {
                alertItem = AlertContext.invalidMuscleGrowthGoal
                return false
            }
        } else {
            if user.goalType == .fatloss && (Double(user.updateGoalWeight) ?? 0.0) > user.currentWeight - 0.1 {
                alertItem = AlertContext.invalidFatLossGoal
                return false
            } else if user.goalType == .muscleGrowth && (Double(user.updateGoalWeight) ?? 0.0) < user.currentWeight + 0.1 {
                alertItem = AlertContext.invalidMuscleGrowthGoal
                return false
            }
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
