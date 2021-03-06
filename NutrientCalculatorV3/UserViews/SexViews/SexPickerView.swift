//
//  SexPicker.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/14/22.
//

import SwiftUI

struct SexPickerView: View {
    
    @EnvironmentObject private var viewModel: EnvironmentViewModel
    var updateSex: Bool
    
    init(updateSex: Bool) {
        self.updateSex = updateSex
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color.accentColor) //changes selected background
        
        let attributes: [NSAttributedString.Key:Any] = [
            .foregroundColor : UIColor(Color.inverseAccentColor)
        ]
        UISegmentedControl.appearance().setTitleTextAttributes(attributes, for: .selected) //changes selected foreground
    }
    
    var body: some View {
        VStack {
            sexSymbolImage
            sexPicker
        }
    }
}

struct SexPicker_Previews: PreviewProvider {
    static var previews: some View {
        SexPickerView(updateSex: true)
            .environmentObject(dev.environmentViewModel)
    }
}

extension SexPickerView {
    
    private var sexSymbolImage: some View {
        Image(viewModel.user.sex == "Male" ? "MaleSymbol" : "FemaleSymbol")
            .resizable()
            .scaledToFit()
            .frame(height: 220)
    }
    
    private var sexPicker: some View {
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
    }
}
