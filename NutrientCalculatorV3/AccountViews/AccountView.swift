//
//  SettingsView.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/24/22.
//

import SwiftUI

struct AccountView: View {
        
    var body: some View {
        ScrollView {
            profileView
        }
        .padding(.top, 8)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
            .environmentObject(dev.environmentViewModel)
    }
}

extension AccountView {
    
    // MARK: Profile View
    private var profileView: some View {
        NavigationLink {
            ProfileView()
                .navigationTitle("Profile")
        } label: {
            HStack {
                Image(systemName: "person")
                    .padding(.leading, 50)
                Text("Profile")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .modifier(AccountInfoViewModifier())
    }
}
