//
//  HeightMeasurementTypeView.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/13/22.
//

import SwiftUI

struct HeightMeasurementTypeView: View {
    
    @EnvironmentObject var viewModel: GlobalUserViewModel
    
    // Purely for changing the color of the selected Metrics Buttons as a picker
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color.accentColor) //changes selected background
        
        let attributes: [NSAttributedString.Key:Any] = [
            .foregroundColor : UIColor(Color.inverseAccentColor)
        ]
        UISegmentedControl.appearance().setTitleTextAttributes(attributes, for: .selected) //changes selected foreground
    }
    
    var body: some View {
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
}

struct HeightMeasurementTypeView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            HeightMeasurementTypeView()
        }
        .environmentObject(dev.globalViewModel)
    }
}
