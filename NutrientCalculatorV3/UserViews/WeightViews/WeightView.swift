//
//  WeightView.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/13/22.
//

import SwiftUI

struct WeightView: View {
        
    var body: some View {
        VStack {
            Text("Input your current weight.")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .padding(.bottom, 20)
            
            WeightMeasurementTypeView()
            WeightTextFieldView()
            Spacer()
        }
    }
}

struct WeightView_Previews: PreviewProvider {
    static var previews: some View {
        WeightView()
            .environmentObject(dev.globalViewModel)
    }
}
