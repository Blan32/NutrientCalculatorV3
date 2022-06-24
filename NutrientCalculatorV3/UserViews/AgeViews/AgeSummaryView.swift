//
//  AgeSummaryView.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/24/22.
//

import SwiftUI

struct AgeSummaryView: View {
    
    @EnvironmentObject private var viewModel: GlobalUserViewModel
    
    var body: some View {
        HStack {
            Text("Age: ")
                .bold()
            Text("\(viewModel.user.age ?? 0) years old")
        }
        .modifier(UserInfoViewModifier())
    }
}

struct AgeSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        AgeSummaryView()
            .environmentObject(dev.globalViewModel)
    }
}
