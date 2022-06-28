//
//  HeightMeasurementTypeView.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/13/22.
//

import SwiftUI

struct HeightMeasurementTypeView: View {
    
    @EnvironmentObject var viewModel: GlobalUserViewModel
    var updateHeight: Bool
    
    // Purely for changing the color of the selected Metrics Buttons as a picker
    init(updateHeight: Bool) {
        self.updateHeight = updateHeight
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color.accentColor) //changes selected background
        
        let attributes: [NSAttributedString.Key:Any] = [
            .foregroundColor : UIColor(Color.inverseAccentColor)
        ]
        UISegmentedControl.appearance().setTitleTextAttributes(attributes, for: .selected) //changes selected foreground
    }
    
    var body: some View {
        if updateHeight {
            profileHeightPicker
        } else {
            onboardingHeightPicker
        }
    }
}

struct HeightMeasurementTypeView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            HeightMeasurementTypeView(updateHeight: true)
        }
        .environmentObject(dev.globalViewModel)
    }
}

extension HeightMeasurementTypeView {
    
    private var onboardingHeightPicker: some View {
        Picker(selection: $viewModel.user.heightInFeetAndInches) {
            Text("Feet and Inches")
                .tag(true)
            Text("Centimeters")
                .tag(false)
        } label: {
            Text("Imperial vs. Metric System")
        }
        .pickerStyle(SegmentedPickerStyle())
        .foregroundColor(Color.buttonColor)
        .padding()
    }
    
    private var profileHeightPicker: some View {
        Picker(selection: $viewModel.user.updateHeightInFeetAndInches) {
            Text("Feet and Inches")
                .tag(true)
            Text("Centimeters")
                .tag(false)
        } label: {
            Text("Imperial vs. Metric System")
        }
        .pickerStyle(SegmentedPickerStyle())
        .foregroundColor(Color.buttonColor)
        .padding()
    }
}
