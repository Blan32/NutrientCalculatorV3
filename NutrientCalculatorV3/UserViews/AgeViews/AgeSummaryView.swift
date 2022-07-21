//
//  AgeSummaryView.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/24/22.
//

import SwiftUI

struct AgeSummaryView: View {
    
    @EnvironmentObject private var viewModel: EnvironmentViewModel
    
    var body: some View {
        HStack {
            Text("Age: ")
                .bold()
            Spacer()
            Text("\(viewModel.user.age) years old")
                .padding(.trailing, 50)
        }
        .modifier(UserInfoViewModifier())
    }
}

struct AgeSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        AgeSummaryView()
            .environmentObject(dev.environmentViewModel)
    }
}
