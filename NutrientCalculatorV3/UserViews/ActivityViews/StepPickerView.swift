//
//  StepPicker.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/14/22.
//

import SwiftUI

struct StepPickerView: View {
    
    @EnvironmentObject private var viewModel: GlobalUserViewModel
    var updateActivity: Bool
        
    var body: some View {
        VStack {
            Picker(selection: updateActivity ? $viewModel.user.updateStepsPerDay : $viewModel.user.stepsPerDay) {
                ForEach(StepAmounts.allCases, id: \.self) { item in
                    Text(item.rawValue)
                        .tag(item)
                }
            } label: {
                Text("Step Amounts")
            }
            .pickerStyle(WheelPickerStyle())
            .labelsHidden()
            .frame(height: 140)
            .clipped()
        }
        
    }
}

struct StepPicker_Previews: PreviewProvider {
    static var previews: some View {
        StepPickerView(updateActivity: true)
            .environmentObject(dev.globalViewModel)
    }
}
