//
//  OnboardingView.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/10/22.
//

import SwiftUI

struct OnboardingView: View {

    @EnvironmentObject private var viewModel: GlobalUserViewModel
    @Environment(\.colorScheme) var colorScheme
    @State var onboardingState: Int = 0
    @Binding var newUser: Bool

    
    // BUILD TRANSITION ANIMATIONS!!!
    
    var body: some View {
        NavigationView {
            ZStack {
                switch onboardingState {
                case 0:
                    welcomeScreen
                        .navigationTitle("Welcome")
                case 1:
                    HeightView()
                        .navigationTitle("Height")
                case 2:
                    WeightView()
                        .navigationTitle("Weight")
                case 3:
                    AgeView()
                        .navigationTitle("Birthday")
                case 4:
                    SexView()
                        .navigationTitle("Sex")
                case 5:
                    ActivityView()
                        .navigationTitle("Activity")
                case 6:
                    GoalView()
                        .navigationTitle("Goal")
                default:
                    HeightPickerView()
                        .navigationTitle("Current Macros")
                }
                
                bottomButton
            }
            .alert(item: $viewModel.alertItem) { alertItem in
                Alert(title: alertItem.title,
                      message: alertItem.message,
                      dismissButton: alertItem.dismissButton)
            }
            .navigationBarItems(
                leading:
                    Image(systemName: "chevron.left")
                        .opacity(onboardingState > 0 ? 1.0 : 0.0)
                        .onTapGesture {
                            if onboardingState > 0 {
                                onboardingState -= 1
                            }
                        }
            )
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(newUser: .constant(true))
            .preferredColorScheme(.dark)
            .environmentObject(dev.globalViewModel)
    }
}

extension OnboardingView {
    
    private var welcomeScreen: some View {
        VStack {
            Image("HypertroFit")
                .resizable()
                .scaledToFit()
                .frame(width: 200)
                .padding(.top, 20)
                .background(
                    colorScheme == .light ?
                        RoundedRectangle(cornerRadius: 25)
                            .frame(width: 260, height: 260) : nil)
                .padding(.bottom, 80)
                        
            Text("With a few pieces of information we will be able to develop a customized nutrition plan for you that updates each week based on your progress. \n \n Let's begin.")
                .font(.body)
                .multilineTextAlignment(.leading)
                .padding(.horizontal, 20)
                .padding(.vertical, 5)
        }
    }
    
    private var bottomButton: some View {
        VStack {
            Spacer()
            
            Button {
                if onboardingState == 2 && !viewModel.isValidWeight {
                    // Shows invalidWeight Alert from viewModel
                }
                
                else if onboardingState == 6 && !viewModel.isValidGoalWeight {
                    //viewModel.alertItem = AlertContext.invalidFatLossGoal
                }
                // Checking that we haven't reached the final onboardingState
                else if onboardingState <= 7 {
                    onboardingState += 1
                }
            } label: {
                if onboardingState <= 7 {
                    Text("Proceed to Step \(onboardingState + 1)/8")
                        .frame(height: 30)
                        .frame(maxWidth: .infinity)
                } else {
                    Text("Continue")
                        .frame(height: 30)
                        .frame(maxWidth: .infinity)
                }
            }
            .modifier(BottomButtonModifier())
        }
    }
}

