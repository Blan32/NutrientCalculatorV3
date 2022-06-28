//
//  HeightView.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/10/22.
//

import SwiftUI

struct HeightView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var viewModel: GlobalUserViewModel
    @State var updateHeight: Bool
    
    var body: some View {
        VStack {
            Text("Select your height.")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .padding(.bottom, 20)
            
            HeightMeasurementTypeView(updateHeight: updateHeight)
                .padding(.bottom)
            HeightPickerView(updateHeight: updateHeight)
            Spacer()
            
            if updateHeight {
                HStack {
                    backButton
                    submitButton
                }
            }
        }
        .navigationBarBackButtonHidden(updateHeight ? true : false)
        .navigationBarItems(
            leading:
                Image(systemName: "chevron.left")
                    .opacity(updateHeight ? 1.0 : 0.0)
                    .onTapGesture {
                        backButtonPressed()
                    }
        )
    }
}

struct HeightView_Previews: PreviewProvider {

    static var previews: some View {
        HeightView(updateHeight: true)
            .preferredColorScheme(.dark)
            .environmentObject(dev.globalViewModel)
    }
}

extension HeightView {
    
    private func backButtonPressed() {
        presentationMode.wrappedValue.dismiss()
    }
    
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
    
    private var submitButton: some View {
        Button {
            viewModel.user.heightCm = viewModel.user.updateHeightCm
            viewModel.user.heightIn = viewModel.user.updateHeightIn
            viewModel.user.heightInFeetAndInches = viewModel.user.updateHeightInFeetAndInches
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
