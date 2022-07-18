//
//  StepPicker.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/14/22.
//

import SwiftUI

struct StepPickerView: View {
    
    @EnvironmentObject private var viewModel: EnvironmentViewModel
        
    var body: some View {
        VStack {
            Picker(selection: $viewModel.user.stepsPerDay) {
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
        StepPickerView()
            .environmentObject(dev.environmentViewModel)
    }
}
