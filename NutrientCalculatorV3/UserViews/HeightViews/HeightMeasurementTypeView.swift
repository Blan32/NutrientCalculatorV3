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
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color.black) //changes selected background
        
        let attributes: [NSAttributedString.Key:Any] = [
            .foregroundColor : UIColor.white
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
        .padding(.bottom, 80)
        //Custom buttons for metrics that don't work
        /*
//        VStack {
//            HStack {
//                Button {
//                    if viewModel.user.measurementsInImperialSystem == false {
//                        viewModel.user.measurementsInImperialSystem.toggle()
//                    }
//                    viewModel.user.heightIn = 68
//                    viewModel.user.heightCm = 0
//                } label: {
//                    Text("Feet and Inches")
//                        .frame(maxWidth: .infinity)
//                }
//                .frame(width: UIScreen.main.bounds.width * 0.45)
//                .buttonStyle(.bordered)
//                .buttonBorderShape(.capsule)
//                .tint(viewModel.user.measurementsInImperialSystem ? .buttonColor : .accentColor)
//
//                Button {
//                    if viewModel.user.measurementsInImperialSystem == true {
//                        viewModel.user.measurementsInImperialSystem.toggle()
//                    }
//                    viewModel.user.heightIn = 0
//                    viewModel.user.heightCm = 173
//                } label: {
//                    Text("Centimeters")
//                        .frame(maxWidth: .infinity)
//                }
//                .frame(width: UIScreen.main.bounds.width * 0.45)
//                .buttonStyle(.bordered)
//                .buttonBorderShape(.capsule)
//                .tint(!viewModel.user.measurementsInImperialSystem ? .buttonColor : .accentColor)
//
//            }
//            .padding(.horizontal)
//
//            Spacer()
//        }
        */
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
