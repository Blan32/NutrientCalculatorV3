//
//  CaloriePreferencePickerView.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/30/22.
//

import SwiftUI

struct CaloriePreferencePickerView: View {
    
    @EnvironmentObject private var viewModel: EnvironmentViewModel
    
    init() {
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
            dynamicCalorieVarianceSlider
        }
    }
}

struct CaloriePreferencePickerView_Previews: PreviewProvider {
    static var previews: some View {
        CaloriePreferencePickerView()
            .preferredColorScheme(.dark)
            .environmentObject(dev.environmentViewModel)
    }
}

extension CaloriePreferencePickerView {
    
    // MARK: Calorie Description
    private var calorieDescription: some View {
        VStack {
            if viewModel.user.dynamicCalories {
                VStack(alignment: .leading) {
                    Text("Dynamically adjust calorie and macronutrient amounts throughout the week based on activity levels.")
                    Text("This will set calories higher on training days and lower on off days.")
                        .bold()
                        .underline()
                        .padding(.top)
                }
                .padding(.top)
                .padding(.horizontal)
                .frame(height: 170, alignment: .top)
                .frame(maxWidth: .infinity)
                .background(calorieDescriptionBackground)
                .padding(.horizontal)
            } else {
                VStack(alignment: .leading) {
                    Text("Keep calories static throughout the week.")
                    Text("Simplify the process and eat the same amount of calories and macros each day.")
                        .bold()
                        .underline()
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
    
    // MARK: Calorie Desc. Background
    private var calorieDescriptionBackground: some View {
        RoundedRectangle(cornerRadius: 25)
            .stroke(
                LinearGradient(
                    colors: [Color.accentColor, Color.inverseAccentColor],
                    startPoint: viewModel.user.dynamicCalories ? .topLeading : .topTrailing,
                    endPoint: viewModel.user.dynamicCalories ? .bottomTrailing : .bottomLeading)
            , lineWidth: 2)
            
    }
    
    // MARK: Calorie Preference Picker
    private var caloriePreferencePicker: some View {
        Picker(selection: $viewModel.user.dynamicCalories) {
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
    
    // MARK: Variance
    private var dynamicCalorieVarianceSlider: some View {
        VStack {
            VStack(spacing: 5) {
                HStack {
                    Text("Variance: ")
                        .bold()
                    Text("+ \(viewModel.user.dynamicCalorieVariance, specifier: "%.f")%")
                }
                .opacity(viewModel.user.dynamicCalories ? 1.0 : 0.0)
                
                Text(viewModel.user.dynamicCalorieVarianceDescription)
                    .foregroundColor(dynamicCalorieVarianceDescriptionTextColor)
                    .opacity(viewModel.user.dynamicCalories ? 1.0 : 0.0)
            }
            Slider(value: $viewModel.user.dynamicCalorieVariance, in: 5...25, step: 1.0)
                .padding(.bottom)
                .padding(.horizontal)
                .opacity(viewModel.user.dynamicCalories ? 1.0 : 0.0)
            
            Text("Variance refers to how much higher your calories will be on high calorie days relative to the average for the week.")
                .padding(.top)
                .padding(.horizontal)
                .frame(height: 100, alignment: .top)
                .frame(maxWidth: .infinity)
                .background(calorieDescriptionBackground)
                .padding(.horizontal)
                .opacity(viewModel.user.dynamicCalories ? 1.0 : 0.0)
        }
        .padding(.top)
    }
    
    private var dynamicCalorieVarianceDescriptionTextColor: Color {
        if viewModel.user.dynamicCalorieVarianceDescription == "Low" {
            return Color.blue
        } else if viewModel.user.dynamicCalorieVarianceDescription == "Moderate" {
            return Color.green
        } else if viewModel.user.dynamicCalorieVarianceDescription == "High" {
            return Color.red
        } else {
            return Color.accentColor
        }
    }
}
