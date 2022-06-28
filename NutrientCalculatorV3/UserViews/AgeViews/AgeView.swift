//
//  OnboardingAgeView.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/14/22.
//

import SwiftUI

struct AgeView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var viewModel: GlobalUserViewModel
    @State var updateAge: Bool
    
    var body: some View {
        VStack {
            Text("Enter your date of birth.")
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .padding(.bottom, 20)
            
            BirthdayPickerView(updateAge: updateAge)
            Spacer()
            
            if updateAge {
                HStack {
                    backButton
                    submitButton
                }
            }
        }
        .navigationBarBackButtonHidden(updateAge ? true : false)
        .navigationBarItems(
            leading:
                Image(systemName: "chevron.left")
                    .opacity(updateAge ? 1.0 : 0.0)
                    .onTapGesture {
                        backButtonPressed()
                    }
        )
    }
}

struct OnboardingAgeView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            AgeView(updateAge: true)
        }
        .environmentObject(dev.globalViewModel)
    }
}

extension AgeView {
    
    // MARK: func Back Button Pressed
    private func backButtonPressed() {
        presentationMode.wrappedValue.dismiss()
    }
    
    // MARK: Back Button View
    private var backButton: some View {
        Button {
            backButtonPressed()
        } label: {
            Text("Go Back")
                .frame(height: 30)
                .frame(maxWidth: .infinity)
        }
        .modifier(UserInfoBackButtonModifier())
    }
    
    // MARK: Submit Button View
    private var submitButton: some View {
        Button {
            viewModel.user.birthday = viewModel.user.updateBirthday
            viewModel.saveProfile()
            presentationMode.wrappedValue.dismiss()
        } label: {
            Text("Update")
                .frame(height: 30)
                .frame(maxWidth: .infinity)
        }
        .modifier(UserInfoSubmitButtonModifier())
    }
}
