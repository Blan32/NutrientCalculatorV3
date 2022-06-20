//
//  Alert.swift
//  NutrientCalculatorV2
//
//  Created by Kyle Blandford on 2/7/22.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
}

struct AlertContext {
    //MARK: - Network Alerts
    static let invalidData =        AlertItem(title: Text("Server Error 1"),
                                              message: Text("The data recevied from the server was invalid, please contact support"),
                                              dismissButton: .default(Text("OK")))
    
    static let invalidResponse =    AlertItem(title: Text("Server Error 2"),
                                              message: Text("Invalid Response from server. Please try again later or contact support."),
                                              dismissButton: .default(Text("OK")))
    
    static let invalidURL =         AlertItem(title: Text("Server Error 3"),
                                              message: Text("There was an issue connecting to the server."),
                                              dismissButton: .default(Text("OK")))
    
    static let unableToComplete =   AlertItem(title: Text("Server Error 4"),
                                              message: Text("Unable to complete your request at this time, please check your internet connection."),
                                              dismissButton: .default(Text("OK")))
    
    //MARK: - App Alerts
    static let invalidSignUp =        AlertItem(title: Text("Missing Info"),
                                              message: Text("Please make sure the entire profile section is filled in so we can build the most effective program possible."),
                                              dismissButton: .default(Text("OK")))
    
    static let invalidWeight =        AlertItem(title: Text("Invalid Weight"),
                                              message: Text("Please input a valid weight: \n\n (50-1000 lbs) \n or \n (23-453 kgs)"),
                                              dismissButton: .default(Text("OK")))
    
    static let invalidFatLossGoal =        AlertItem(title: Text("Invalid Fat Loss Goal"),
                                              message: Text("For a fat loss goal, please input a goal weight that is lower than your current weight and at least 50 lbs or 23 kgs."),
                                              dismissButton: .default(Text("OK")))
    
    static let invalidMuscleGrowthGoal =        AlertItem(title: Text("Invalid Muscle Growth Goal"),
                                              message: Text("For a muscle growth goal, please input a goal weight that is higher than your current weight and under 1000 lbs or 453 kgs."),
                                              dismissButton: .default(Text("OK")))
    
    static let invalidEmail =       AlertItem(title: Text("Invalid Email"),
                                              message: Text("Please ensure your email is correct."),
                                              dismissButton: .default(Text("OK")))
    
    static let userSaveSuccess =    AlertItem(title: Text("Weight Saved"),
                                              message: Text("Your weight was saved successfully."),
                                              dismissButton: .default(Text("OK")))
    
    static let invalidUserData =    AlertItem(title: Text("Profile Error"),
                                              message: Text("There was an error saving or retrieving your profile."),
                                              dismissButton: .default(Text("OK")))
    
    static let invalidMacros =    AlertItem(title: Text("Invalid Macros"),
                                              message: Text("You must fill in at least the calorie totals or you can skip this section."),
                                              dismissButton: .default(Text("OK")))
}

