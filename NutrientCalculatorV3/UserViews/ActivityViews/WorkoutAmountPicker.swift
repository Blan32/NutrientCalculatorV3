//
//  WorkoutAmountPicker.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/14/22.
//

import SwiftUI

struct WorkoutAmountPicker: View {
    
    @EnvironmentObject private var viewModel: GlobalUserViewModel
    
    var body: some View {
        Picker(selection: $viewModel.user.trainingSessionsPerWeekIntensityScore) {
            ForEach(WorkoutsPerWeek.allCases, id: \.self) { workout in
                Text(workout.rawValue)
                    .tag(workout.workoutIntensityScore())
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
        WorkoutAmountPicker()
            .environmentObject(dev.globalViewModel)
    }
}
