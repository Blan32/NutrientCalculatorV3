//
//  SexView.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/14/22.
//

import SwiftUI

struct SexView: View {
    
    @EnvironmentObject private var viewModel: GlobalUserViewModel
    
    var body: some View {
        VStack {
            Text("We need to know your sex in order to accurately calculate calorie and macronutrient requirements for your specific goal.")
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .padding(.bottom, 20)
            
            SexPicker()
            Spacer()
        }
    }
}

struct SexView_Previews: PreviewProvider {
    static var previews: some View {
        SexView()
            .preferredColorScheme(.dark)
            .environmentObject(dev.globalViewModel)
    }
}
