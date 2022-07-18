//
//  GoalPicker.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/16/22.
//

import SwiftUI

struct GoalPickerView: View {
    
    @EnvironmentObject private var viewModel: EnvironmentViewModel
    @Environment(\.colorScheme) var colorScheme
    @FocusState private var focusedTextField: Bool
    var updateGoalWeight: Bool

    init(updateGoalWeight: Bool) {
        self.updateGoalWeight = updateGoalWeight
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color.accentColor) //changes selected background
        
        let attributes: [NSAttributedString.Key:Any] = [
            .foregroundColor : UIColor(Color.inverseAccentColor)
        ]
        UISegmentedControl.appearance().setTitleTextAttributes(attributes, for: .selected) //changes selected foreground
    }
    
    //MARK: View
    var body: some View {
        NavigationView {
            VStack {
                goalImage
                goalPicker
                goalWeight
                Spacer()
                
                if focusedTextField {
                    Rectangle()
                        .opacity(0.0)
                        .frame(height: 300)
                }
            }
            .navigationBarHidden(true)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    KeyboardDismissButton(focusedTextField: $focusedTextField)
                    Spacer()
                }
            }
        }
    }
}

struct GoalPicker_Previews: PreviewProvider {
    static var previews: some View {
        GoalPickerView(updateGoalWeight: true)
            .environmentObject(dev.environmentViewModel)
    }
}


extension GoalPickerView {
    
    //MARK: Goal Image
    private var goalImage: some View {
        VStack {
            if viewModel.user.goalType == .fatloss {
                if viewModel.user.sex == "Male" {
                    Image(colorScheme == .light ? "FatlossBlack" : "FatlossWhite")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 220)
                } else {
                    Image(colorScheme == .light ? "FemaleFatlossBlack" : "FemaleFatlossWhite")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 220)
                }
            } else if viewModel.user.goalType == .muscleGrowth {
                if viewModel.user.sex == "Male" {
                    Image(colorScheme == .light ? "MuscleGrowthGraphicBlack" : "MuscleGrowthGraphicWhite")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 220)
                } else {
                    Image(colorScheme == .light ? "FemaleMuscleGrowthBlack" : "FemaleMuscleGrowthWhite")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 220)
                }
            } else if viewModel.user.goalType == .maintenance {
                Image(colorScheme == .light ? "BalanceScaleDetailWhite" : "BalanceScaleDetailBlack")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 220)
            } else {
                Image(colorScheme == .light ? "FatLossBlack" : "FatLossWhite")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 220)
                    .opacity(0)
            }
        }
    }
    
    //MARK: Goal Picker
    private var goalPicker: some View {
        Picker(selection: $viewModel.user.goalType) {
            ForEach(Goal.allCases, id: \.self) { item in
                Text(item.rawValue)
                    .tag(item)
            }
        } label: {
            Text("Goal")
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding()
        .padding(.top, 20)
        .padding(.bottom, 20)
    }
    
    //MARK: Goal Weight
    private var goalWeight: some View {
        VStack {
            Text("Goal Weight:")
            HStack {
                if viewModel.user.weightInPounds {
                    TextField(viewModel.user.inputGoalWeightLbs == "" ? "Goal Weight" : viewModel.user.inputGoalWeightLbs, text: $viewModel.user.inputGoalWeightLbs)
                        .keyboardType(.decimalPad)
                        .focused($focusedTextField)
                } else {
                    TextField(viewModel.user.inputGoalWeightKgs == "" ? "Goal Weight" : viewModel.user.inputGoalWeightKgs, text: $viewModel.user.inputGoalWeightKgs)
                        .keyboardType(.decimalPad)
                        .focused($focusedTextField)
                }
                Text(viewModel.user.weightInPounds ? "lbs" : "kgs")
            }
            .font(.body)
            .padding()
            .padding(.horizontal, 20)
            .background(
                Capsule()
                    .fill(colorScheme == .light ? Color.black.opacity(0.1) : Color.white.opacity(0.1))
                    .padding(.horizontal)
            )
        }
        .opacity(viewModel.user.goalType == .fatloss || viewModel.user.goalType == .muscleGrowth ? 1.0 : 0.0)
    }
}
