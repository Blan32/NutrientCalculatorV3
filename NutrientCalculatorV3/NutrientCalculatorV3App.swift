//
//  NutrientCalculatorV3App.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/10/22.
//

import SwiftUI

@main
struct NutrientCalculatorV3App: App {
    
    @StateObject var checkInDataService = CheckInDataService()
    @StateObject var viewModel = GlobalUserViewModel()
    
    var body: some Scene {
        WindowGroup {
            DashboardTabView()
                .environmentObject(viewModel)
                .environment(\.managedObjectContext, checkInDataService.container.viewContext)
        }
    }
}
