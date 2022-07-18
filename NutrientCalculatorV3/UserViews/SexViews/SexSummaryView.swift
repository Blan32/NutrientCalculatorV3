//
//  SexSummaryView.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/24/22.
//

import SwiftUI

struct SexSummaryView: View {
    
    @EnvironmentObject private var viewModel: EnvironmentViewModel
    
    var body: some View {
        HStack {
            Text("Biological Sex: ")
                .bold()
            Spacer()
            HStack {
                Text(viewModel.user.sex)
                if viewModel.user.sex == "Male" {
                    Text("♂︎")
                } else {
                    Text("♀︎")
                }
            }
            .foregroundColor(viewModel.user.sex == "Male" ? .blue : .pink)
            .padding(.trailing, 50)
        }
        .modifier(UserInfoViewModifier())
    }
}

struct SexSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        SexSummaryView()
            .environmentObject(dev.environmentViewModel)
    }
}
