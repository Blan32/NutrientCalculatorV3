//
//  SexView.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/14/22.
//

import SwiftUI

struct SexView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var viewModel: GlobalUserViewModel
    @State var updateSex: Bool
    
    var body: some View {
        VStack {
            Text("We need to know your sex in order to accurately calculate calorie and macronutrient requirements for your specific goal.")
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .padding(.bottom, 20)
            
            SexPickerView(updateSex: updateSex)
            Spacer()
            
            if updateSex {
                HStack {
                    backButton
                    submitButton
                }
            }
        }
        .navigationBarBackButtonHidden(updateSex ? true : false)
        .navigationBarItems(
            leading:
                Image(systemName: "chevron.left")
                    .opacity(updateSex ? 1.0 : 0.0)
                    .onTapGesture {
                        backButtonPressed()
                    }
        )
    }
}

struct SexView_Previews: PreviewProvider {
    static var previews: some View {
        SexView(updateSex: true)
            .preferredColorScheme(.dark)
            .environmentObject(dev.globalViewModel)
    }
}

extension SexView {
    
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
            viewModel.user.sex = viewModel.user.updateSex
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
