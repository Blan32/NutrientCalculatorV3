//
//  SexPicker.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/14/22.
//

import SwiftUI

struct SexPickerView: View {
    
    @EnvironmentObject private var viewModel: GlobalUserViewModel
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color.accentColor) //changes selected background
        
        let attributes: [NSAttributedString.Key:Any] = [
            .foregroundColor : UIColor(Color.inverseAccentColor)
        ]
        UISegmentedControl.appearance().setTitleTextAttributes(attributes, for: .selected) //changes selected foreground
    }
    
    var body: some View {
        
        if viewModel.user.sex == "Male" {
            Image("MaleSymbol")
                .resizable()
                .scaledToFit()
                .frame(height: 220)
        } else if viewModel.user.sex == "Female" {
            Image("FemaleSymbol")
                .resizable()
                .scaledToFit()
                .frame(height: 220)
        } else {
            Image("MaleSymbol")
                .resizable()
                .scaledToFit()
                .frame(height: 220)
                .opacity(0)
        }
        
        Picker(selection: $viewModel.user.sex) {
            Text("Male")
                .tag("Male")
            Text("Female")
                .tag("Female")
        } label: {
            Text("Sex")
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding()
        .padding(.top, 20)
        .padding(.bottom, 80)
    }
}

struct SexPicker_Previews: PreviewProvider {
    static var previews: some View {
        SexPickerView()
            .environmentObject(dev.globalViewModel)
    }
}
