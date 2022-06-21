//
//  GoalView.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/16/22.
//

import SwiftUI

struct GoalView: View {
    
    var body: some View {
        
        VStack {
            Text("Select your goal.")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .padding(.bottom, 10)
            
            GoalPicker()
            Spacer()
        }
    }
}

struct GoalView_Previews: PreviewProvider {
    static var previews: some View {
        GoalView()
            .environmentObject(dev.globalViewModel)
    }
}
