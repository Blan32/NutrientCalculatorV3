//
//  WeightMeasurementTypeView.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/13/22.
//

import SwiftUI

struct WeightMeasurementTypeView: View {
    
    @EnvironmentObject private var viewModel: GlobalUserViewModel
    
    // Purely for changing the color of the selected Metrics Buttons as a picker
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color.black) //changes selected background
        
        let attributes: [NSAttributedString.Key:Any] = [
            .foregroundColor : UIColor.white
        ]
        UISegmentedControl.appearance().setTitleTextAttributes(attributes, for: .selected) //changes selected foreground
    }

    var body: some View {
        Picker(selection: $viewModel.user.weightInPounds) {
            Text("Pounds")
                .tag(true)
            Text("Kilograms")
                .tag(false)
        } label: {
            Text("Weight in pounds?")
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding()
        .padding(.bottom, 80)
    }
}

struct WeightMeasurementTypeView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            WeightMeasurementTypeView()
        }
        .environmentObject(dev.globalViewModel)
    }
}
