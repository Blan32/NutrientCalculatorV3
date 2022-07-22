//
//  HeightView.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/10/22.
//

import SwiftUI

struct OLDHeightView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var viewModel: EnvironmentViewModel
    @State var updateHeight: Bool
    
    
    var body: some View {
        VStack {
            Text("Select your height.")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .padding(.bottom, 20)
            
            OLDHeightMeasurementTypeView()
                .padding(.bottom)
            OLDHeightPickerView()
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

struct OLDHeightView_Previews: PreviewProvider {

    static var previews: some View {
        OLDHeightView(updateHeight: true)
            .preferredColorScheme(.dark)
            .environmentObject(dev.environmentViewModel)
    }
}

extension OLDHeightView {
    
    // MARK: Back Button
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
    
    // MARK: Submit Button
    private var submitButton: some View {
        Button {
            submitButtonPressed()
        } label: {
            Text("Update")
                .frame(height: 30)
                .frame(maxWidth: .infinity)
        }
        .modifier(UserInfoSubmitButtonModifier())
    }
    
    // MARK: func BackButtonPressed
    private func backButtonPressed() {
        presentationMode.wrappedValue.dismiss()
    }
    
    // MARK: func SubmitButtonPressed
    private func submitButtonPressed() {
        viewModel.saveProfile()
        presentationMode.wrappedValue.dismiss()
    }
}
