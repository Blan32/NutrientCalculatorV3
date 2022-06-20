//
//  StepPicker.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/14/22.
//

import SwiftUI

struct StepPicker: View {
    
    @EnvironmentObject private var viewModel: GlobalUserViewModel
        
    var body: some View {
        VStack {
            Picker(selection: $viewModel.user.stepsPerDayIntensityScore) {
                ForEach(StepAmounts.allCases, id: \.self) { item in
                    Text(item.rawValue)
                        .tag(item.stepIntensityScore())
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
        StepPicker()
            .environmentObject(dev.globalViewModel)
    }
}
