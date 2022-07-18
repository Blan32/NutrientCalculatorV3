//
//  HeightPickerView.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/13/22.
//

import SwiftUI

struct HeightPickerView: View {
    
    @EnvironmentObject var viewModel: EnvironmentViewModel
    
    var body: some View {
        VStack {
            Text(viewModel.user.heightInFeetAndInches ? "Height: \(viewModel.user.heightIn / 12) ft \(viewModel.user.heightIn % 12) in" : "Height: \(viewModel.user.heightCm) cm")
                .bold()
                .font(.title2)
            if viewModel.user.heightInFeetAndInches {
                heightInFeetPicker
            } else {
                heightInCmPicker
            }
        }
    }
}

struct HeightPickerView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            HeightPickerView()
        }
        .environmentObject(dev.environmentViewModel)
    }
}


extension HeightPickerView {
    
    // MARK: heightInFeetPicker
    private var heightInFeetPicker: some View {
        Picker(selection: $viewModel.user.heightIn) {
            ForEach(0..<97) { inch in
                Text("\(inch / 12)' \(inch % 12)\"")
                    .bold()
                    .tag("\(inch)")
            }
        } label: {
            Text("Height in inches")
        }
        .pickerStyle(WheelPickerStyle())
    }
    
    // MARK: heightInCmPicker
    private var heightInCmPicker: some View {
        Picker(selection: $viewModel.user.heightCm) {
            ForEach(0..<245) { cm in
                Text("\(cm) cm")
                    .bold()
                    .tag("\(cm)")
            }
        } label: {
            Text("Height in inches")
        }
        .pickerStyle(WheelPickerStyle())
    }
}
