//
//  WorkoutAmountPicker.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/14/22.
//

import SwiftUI

struct WorkoutAmountPickerView: View {
    
    @EnvironmentObject private var viewModel: EnvironmentViewModel
    
    var body: some View {
        Picker(selection: $viewModel.user.trainingSessionsPerWeek) {
            ForEach(WorkoutsPerWeek.allCases, id: \.self) { workout in
                Text(workout.rawValue)
                    .tag(workout)
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

struct WorkoutAmountPicker_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutAmountPickerView()
            .environmentObject(dev.environmentViewModel)
    }
}
