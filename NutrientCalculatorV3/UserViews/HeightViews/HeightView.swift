//
//  HeightView.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/10/22.
//

import SwiftUI

struct HeightView: View {
    
    var body: some View {
        VStack {
            Text("Select your height.")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .padding(.bottom, 20)
            
            HeightMeasurementTypeView()
            HeightPickerView()
            Spacer()
        }
    }
}

struct HeightView_Previews: PreviewProvider {

    static var previews: some View {
        HeightView()
            .preferredColorScheme(.dark)
            .environmentObject(dev.globalViewModel)
    }
}
