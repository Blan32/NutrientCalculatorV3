//
//  CaloriePreferencePickerView.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/30/22.
//

import SwiftUI

struct CaloriePreferencePickerView: View {
    
    @EnvironmentObject private var viewModel: GlobalUserViewModel
    var updateCaloriePreference: Bool
    
    init(updateCaloriePreference: Bool) {
        self.updateCaloriePreference = updateCaloriePreference
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color.accentColor) //changes selected background
        
        let attributes: [NSAttributedString.Key:Any] = [
            .foregroundColor : UIColor(Color.inverseAccentColor)
        ]
        UISegmentedControl.appearance().setTitleTextAttributes(attributes, for: .selected) //changes selected foreground
    }
    
    var body: some View {
        VStack {
            calorieDescription
            caloriePreferencePicker
        }
    }
}

struct CaloriePreferencePickerView_Previews: PreviewProvider {
    static var previews: some View {
        CaloriePreferencePickerView(updateCaloriePreference: false)
            .preferredColorScheme(.dark)
            .environmentObject(dev.globalViewModel)
    }
}

extension CaloriePreferencePickerView {
    
    // MARK: Calorie Description
    private var calorieDescription: some View {
        VStack {
            if updateCaloriePreference {
                // MARK: * Profile View
                if viewModel.user.updateDynamicCalories {
                    VStack {
                        Text("Dynamically adjust calorie and macronutrient amounts throughout the week based on activity levels.")
                        Text("This will set calories higher on training days and lower on off days.")
                            .bold()
                            .italic()
                            .padding(.top)
                    }
                    .padding(.top)
                    .padding(.horizontal)
                    .frame(height: 170, alignment: .top)
                    .frame(maxWidth: .infinity)
                    .background(calorieDescriptionBackground)
                    .padding(.horizontal)
                } else {
                    VStack {
                        Text("Keep calories static throughout the week.")
                        Text("Simplify the process and eat the same amount of calories and macros each day.")
                            .bold()
                            .italic()
                            .padding(.top)
                    }
                    .padding(.top)
                    .padding(.horizontal)
                    .frame(height: 170, alignment: .top)
                    .frame(maxWidth: .infinity)
                    .background(calorieDescriptionBackground)
                    .padding(.horizontal)
                }
            } else {
                // MARK: * Onboarding View
                if viewModel.user.dynamicCalories {
                    VStack {
                        Text("Dynamically adjust calorie and macronutrient amounts throughout the week based on activity levels.")
                        Text("This will set calories higher on training days and lower on off days.")
                            .bold()
                            .italic()
                            .padding(.top)
                    }
                    .padding(.top)
                    .padding(.horizontal)
                    .frame(height: 170, alignment: .top)
                    .frame(maxWidth: .infinity)
                    .background(calorieDescriptionBackground)
                    .padding(.horizontal)
                } else {
                    VStack {
                        Text("Keep calories static throughout the week.")
                        Text("Simplify the process and eat the same amount of calories and macros each day.")
                            .bold()
                            .italic()
                            .padding(.top)
                    }
                    .padding(.top)
                    .padding(.horizontal)
                    .frame(height: 170, alignment: .top)
                    .frame(maxWidth: .infinity)
                    .background(calorieDescriptionBackground)
                    .padding(.horizontal)
                }
            }
        }
    }
    
    // MARK: Calorie Desc. Background
    private var calorieDescriptionBackground: some View {
        RoundedRectangle(cornerRadius: 25)
            .stroke(
//                Color.accentColor.opacity(0.3)
                LinearGradient(
                    colors: [Color.accentColor, Color.inverseAccentColor],
                    startPoint: viewModel.user.dynamicCalories ? .topLeading : .topTrailing,
                    endPoint: viewModel.user.dynamicCalories ? .bottomTrailing : .bottomLeading)
            , lineWidth: 2)
            
    }
    
    // MARK: Calorie Preference Picker
    private var caloriePreferencePicker: some View {
        Picker(selection: updateCaloriePreference ? $viewModel.user.updateDynamicCalories : $viewModel.user.dynamicCalories) {
            Text("Dynamic")
                .tag(true)
            Text("Static")
                .tag(false)
        } label: {
            Text("Calorie Preference")
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding()
    }
}
