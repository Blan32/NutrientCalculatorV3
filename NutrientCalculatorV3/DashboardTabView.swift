//
//  DashboardTabView.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/10/22.
//

import SwiftUI

struct DashboardTabView: View {
    
    @StateObject var viewModel = GlobalUserViewModel()
    @State var newUser: Bool = true
    
    var body: some View {
        ZStack {
            TabView {
                Text("hi")
            }
            .fullScreenCover(isPresented: $newUser) {
                OnboardingView(newUser: $newUser)
            }
        }
        .environmentObject(viewModel)
    }
}

struct DashboardTabView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardTabView()
            .environmentObject(dev.globalViewModel)
    }
}
