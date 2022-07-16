//
//  GlobalUserViewModel.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/13/22.
//

import CoreData
import SwiftUI

class GlobalUserViewModel: ObservableObject {
        
    @AppStorage("user") private var userData: Data?
    @AppStorage("new_user") var newUser: Bool = true
    
    let manager = CoreDataManager.instance
    @Published var checkIns: [CheckIn] = []
    @Published var weighIns: [WeighIn] = []
    
    @Published var user = User()
    @Published var alertItem: AlertItem?
    
    private let poundsToKg = 0.453592
    private let kgsToPounds = 2.20462
    private let inchesToCm = 2.54
    private let cmToInches = 0.393701
    
    init() {
        fetchWeighIns()
        fetchCheckIns()
    }
    
    func fetchCheckIns() {
        let request = NSFetchRequest<CheckIn>(entityName: "CheckIn")
        
        do {
            checkIns = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching CheckIns. \(error)")
        }
    }
    
    func fetchWeighIns() {
        let request = NSFetchRequest<WeighIn>(entityName: "WeighIn")
        
        do {
            weighIns = try manager.context.fetch(request)
        } catch let error {
            print("Error fetching WeighIns. \(error)")
        }
    }
    
    func addWeighIn(date: Date, weight: Double) {
        let newWeighIn = WeighIn(context: manager.context)
        newWeighIn.id = UUID()
        newWeighIn.date = date
        newWeighIn.weight = weight
        
        save()
    }
    
    func deleteWeighIn(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let entity = weighIns[index]
        manager.context.delete(entity)
        save()
    }
    
    //    func updateWeighIn(entity: WeighIn) {
    //        let currentWeight = entity.weight ?? 0.0
    //        let currentDate = entity.date ?? Date()
    //        entity.weight =
    //    }
    
    func addCheckIn(averageWeight: Double, calories: Double, fats: Double, carbs: Double, protein: Double) {
        let newCheckIn = CheckIn(context: manager.context)
        newCheckIn.id = UUID()
        newCheckIn.date = Date()
        newCheckIn.averageWeight = averageWeight
        newCheckIn.calories = calories
        newCheckIn.fats = fats
        newCheckIn.carbs = carbs
        newCheckIn.protein = protein
        
        save()
    }
    
    func save() {
        manager.save()
        fetchCheckIns()
        fetchWeighIns()
    }
    
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
    
    //MARK: * validate weight
    // Checking to make sure user entered a valid weight between 50.0 and 1000.0 pounds on WeightView (226.796kg = 500lbs)
    func isValidWeight() -> Bool {
        if user.weightInPounds {
            if user.inputWeightLbs.isEmpty || user.startingWeight < 50 || user.startingWeight > 500 {
                alertItem = AlertContext.invalidWeight
                return false
            }
        } else {
            if user.inputWeightKgs.isEmpty || user.startingWeight < 23 || user.startingWeight > 226 {
                alertItem = AlertContext.invalidWeight
                return false
            }
        }
        
        return true
    }
    
    //MARK: * validate goal weight
    func isValidGoalWeight() -> Bool {
        if user.goalWeight < 50 || user.goalWeight > 500 {
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
        if user.weightInPounds {
            // Check if textfield is empty
            if user.inputGoalWeightLbs.isEmpty && user.goalType != .maintenance {
                alertItem = AlertContext.invalidWeight
                return false
            
            // Check if updateGoalWeight is less than 50lbs or greater than 500lbs (which would be invalid)
            } else if (Double(user.inputGoalWeightLbs) ?? 0) < 50 || (Double(user.inputGoalWeightLbs) ?? 0) > 500 {
                alertItem = AlertContext.invalidWeight
                return false
            
            // Check if updateGoalWeight makes sense based on goalType (less for fatloss, more for muscle growth) if weightInPounds convert updateGoalWeight to Kg before comparison
            } else if user.goalType == .fatloss && (Double(user.inputGoalWeightLbs) ?? 0.0) > user.currentWeight - 0.1 {
                alertItem = AlertContext.invalidFatLossGoal
                return false
            } else if user.goalType == .muscleGrowth && (Double(user.inputGoalWeightLbs) ?? 0.0) < user.currentWeight + 0.1 {
                alertItem = AlertContext.invalidMuscleGrowthGoal
                return false
            }
        } else {
            // Check if textfield is empty
            if user.inputGoalWeightLbs.isEmpty && user.goalType != .maintenance {
                alertItem = AlertContext.invalidWeight
                return false
                
            // Check if updateGoalWeight is less than 50lbs or greater than 500lbs (which would be invalid)
            } else if (Double(user.inputGoalWeightKgs) ?? 0) * kgsToPounds < 50 || (Double(user.inputGoalWeightKgs) ?? 0) * kgsToPounds > 500 {
                alertItem = AlertContext.invalidWeight
                return false
            
            // Check if updateGoalWeight makes sense based on goalType (less for fatloss, more for muscle growth) if weightInPounds convert updateGoalWeight to Kg before comparison
            } else if user.goalType == .fatloss && (Double(user.inputGoalWeightKgs) ?? 0.0) * kgsToPounds > user.currentWeight - 0.1 {
                alertItem = AlertContext.invalidFatLossGoal
                return false
            } else if user.goalType == .muscleGrowth && (Double(user.inputGoalWeightKgs) ?? 0.0) * kgsToPounds < user.currentWeight + 0.1 {
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
    
    // MARK: Input Weights
    // Rounding is done to the 10ths place for all inputWeights / inputGoalWeights
    func setInputWeightKgs() {
        user.inputWeightKgs = String((((Double(user.inputWeightLbs) ?? 0) * poundsToKg) * 10).rounded() / 10)
    }
    
    func setInputWeightLbs() {
        user.inputWeightLbs = String((((Double(user.inputWeightKgs) ?? 0) * kgsToPounds) * 10).rounded() / 10)
    }
    
    // MARK: Input Goal Weights
    func setInputGoalWeightKgs() {
        user.inputGoalWeightKgs = String((((Double(user.inputGoalWeightLbs) ?? 0) * poundsToKg) * 10).rounded() / 10)
    }
    
    func setInputGoalWeightLbs() {
        user.inputGoalWeightLbs = String((((Double(user.inputGoalWeightKgs) ?? 0) * kgsToPounds) * 10).rounded() / 10)
    }
}
