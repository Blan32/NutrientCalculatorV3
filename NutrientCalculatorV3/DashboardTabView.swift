//
//  DashboardTabView.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/10/22.
//

import SwiftUI

struct DashboardTabView: View {
    
    @EnvironmentObject private var viewModel: GlobalUserViewModel
    @AppStorage("new_user") var newUser: Bool = true
    
    var body: some View {
        ZStack {
            TabView {
                DashboardView()
                    .tabItem {
                        Label("", systemImage: "house")
                    }
                Text("Weigh-Ins")
                    .tabItem {
                        Label("", systemImage: "square.and.pencil")
                    }
                AccountView()
                    .tabItem {
                        Label("", systemImage: "person")
                    }
            }
            .fullScreenCover(isPresented: $newUser) {
                OnboardingView(newUser: $newUser)
            }
            .alert(item: $viewModel.alertItem) { alertItem in
                Alert(title: alertItem.title,
                      message: alertItem.message,
                      dismissButton: alertItem.dismissButton)
            }
        }
    }
}

struct DashboardTabView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardTabView()
            .environmentObject(dev.globalViewModel)
    }
}
