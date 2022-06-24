//
//  WeightView.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/13/22.
//

import SwiftUI

struct WeightView: View {
            
    var body: some View {
        NavigationView {
            VStack {
                Text("Input your current weight.")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .padding(.bottom, 10)
                    .navigationBarHidden(true)
                WeightMeasurementTypeView()
                WeightTextFieldView()
                Spacer()
            }
        }
    }
}

struct WeightView_Previews: PreviewProvider {
    static var previews: some View {
        WeightView()
            .environmentObject(dev.globalViewModel)
    }
}


