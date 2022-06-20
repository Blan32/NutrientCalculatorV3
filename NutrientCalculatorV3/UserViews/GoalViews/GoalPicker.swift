//
//  GoalPicker.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/16/22.
//

import SwiftUI

struct GoalPicker: View {
    
    @EnvironmentObject private var viewModel: GlobalUserViewModel
    @Environment(\.colorScheme) var colorScheme
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color.black) //changes selected background
        
        let attributes: [NSAttributedString.Key:Any] = [
            .foregroundColor : UIColor.white
        ]
        UISegmentedControl.appearance().setTitleTextAttributes(attributes, for: .selected) //changes selected foreground
    }
    
    var body: some View {
        
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
        
        if viewModel.user.goalType == .fatloss || viewModel.user.goalType == .muscleGrowth {
            
        }
        VStack {
            Text("Goal Weight:")
            if viewModel.user.weightInPounds {
                HStack {
                    TextField("Goal Weight", text: $viewModel.user.goalWeightLbs)
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

struct GoalPicker_Previews: PreviewProvider {
    static var previews: some View {
        GoalPicker()
            .environmentObject(dev.globalViewModel)
    }
}
