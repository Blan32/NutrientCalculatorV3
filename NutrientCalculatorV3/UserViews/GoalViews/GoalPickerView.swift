//
//  GoalPicker.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/16/22.
//

import SwiftUI

struct GoalPickerView: View {
    
    @EnvironmentObject private var viewModel: GlobalUserViewModel
    @Environment(\.colorScheme) var colorScheme
    @FocusState private var focusedTextField: Bool
    
    init() {
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
        GoalPickerView()
            .environmentObject(dev.globalViewModel)
    }
}


extension GoalPickerView {
    
    //MARK: Goal Image
    private var goalImage: some View {
        VStack {
            if viewModel.user.goalType == .fatloss {
                Image(colorScheme == .light ? "FatlossBlack" : "FatlossWhite")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 220)
            } else if viewModel.user.goalType == .muscleGrowth {
                Image(colorScheme == .light ? "MuscleGrowthGraphicBlack" : "MuscleGrowthGraphicWhite")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 220)
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
                
            if viewModel.user.weightInPounds {
                HStack {
                    TextField("Goal Weight", text: $viewModel.user.goalWeightLbs)
                        .keyboardType(.decimalPad)
                        .focused($focusedTextField)
                    Text("lbs")
                }
                .font(.body)
                .padding()
                .padding(.horizontal, 20)
                .background(
                    Capsule()
                        .fill(colorScheme == .light ? Color.black.opacity(0.1) : Color.white.opacity(0.1))
                        .padding(.horizontal)
                )
            } else {
                HStack {
                    TextField("Goal Weight", text: $viewModel.user.goalWeightKgs)
                        .keyboardType(.decimalPad)
                        .focused($focusedTextField)
                    Text("kgs")
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
        }
        .opacity(viewModel.user.goalType == .fatloss || viewModel.user.goalType == .muscleGrowth ? 1.0 : 0.0)
    }
}
