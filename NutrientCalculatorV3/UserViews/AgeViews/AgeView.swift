//
//  OnboardingAgeView.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/14/22.
//

import SwiftUI

struct AgeView: View {
    
    @EnvironmentObject private var viewModel: GlobalUserViewModel
    
    var body: some View {
        VStack {
            Text("Enter your date of birth.")
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .padding(.bottom, 20)
            
            BirthdayPickerView()
            Spacer()
        }
    }
}

struct OnboardingAgeView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            AgeView()
        }
        .environmentObject(dev.globalViewModel)
    }
}
