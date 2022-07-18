//
//  WeightView.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/13/22.
//

import SwiftUI

struct WeightView: View {
            
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var viewModel: EnvironmentViewModel
    @State var updateWeight: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                if updateWeight {
                    Text("Select pounds or kilograms.")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .padding(.bottom, 10)
                        .navigationBarHidden(true)
                    Spacer()
                } else {
                    Text("Input your current weight.")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .padding(.bottom, 10)
                        .navigationBarHidden(true)
                }
                
                WeightMeasurementTypeView()
                
                if !updateWeight {
                    WeightTextFieldView()
                }
                
                Spacer()
                
                if updateWeight {
                    HStack {
                        backButton
                        submitButton
                    }
                }
            }
            .navigationBarBackButtonHidden(updateWeight ? true : false)
            .navigationBarItems(
                leading:
                    Image(systemName: "chevron.left")
                        .opacity(updateWeight ? 1.0 : 0.0)
                        .onTapGesture {
                            backButtonPressed()
                        }
            )
        }
    }
}

struct WeightView_Previews: PreviewProvider {
    static var previews: some View {
        WeightView(updateWeight: true)
            .environmentObject(dev.environmentViewModel)
    }
}


extension WeightView {
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
    
    // MARK: func Back Button Pressed
    private func backButtonPressed() {
        presentationMode.wrappedValue.dismiss()
    }
    
    // MARK: func SubmitButtonPressed
    private func submitButtonPressed() {
        viewModel.saveProfile()
        presentationMode.wrappedValue.dismiss()
    }
}

