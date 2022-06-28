//
//  InputCurrentMacrosSummaryView.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/24/22.
//

import SwiftUI

struct InputCurrentMacrosSummaryView: View {
    
    @EnvironmentObject private var viewModel: GlobalUserViewModel

    var body: some View {
        HStack(spacing: 5) {
            Text("Prior Macros:")
                .bold()
            
            Spacer()
            
            VStack {
                Text("F")
                Text(viewModel.user.inputFats == "" ? "n/a" : viewModel.user.inputFats)
            }
            .foregroundColor(Color.green)
            .frame(width: 35, height: 30)
            
            VStack {
                Text("C")
                Text(viewModel.user.inputCarbs == "" ? "n/a" : viewModel.user.inputCarbs)
            }
            .foregroundColor(Color.blue)
            .frame(width: 35, height: 30)
            
            VStack {
                Text("P")
                Text(viewModel.user.inputProtein == "" ? "n/a" : viewModel.user.inputProtein)
            }
            .foregroundColor(Color.red)
            .frame(width: 35, height: 30)
            
            VStack {
                Text("Cal")
                Text(viewModel.user.inputCalories == "" ? "n/a" : viewModel.user.inputCalories)
            }
            .frame(width: 55, height: 30)
        }
        .padding(.trailing, 45)
        .modifier(UserInfoViewModifier())
    }
}

struct InputCurrentMacrosSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        InputCurrentMacrosSummaryView()
            .environmentObject(dev.globalViewModel)
    }
}
