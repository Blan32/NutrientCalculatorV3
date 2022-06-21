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
    @FocusState private var focusedTextField: Bool

    let transition: AnyTransition = .asymmetric(insertion: .move(edge: .trailing),
                                                removal: .move(edge: .leading))

    
    //MARK: View
    var body: some View {
        NavigationView {
            ZStack {
                switch onboardingState {
                case 0:
                    welcomeScreen
                        .transition(transition)
                        .navigationTitle("Welcome")
                case 1:
                    HeightView()
                        .transition(transition)
                        .navigationTitle("Height")
                case 2:
                    WeightView()
                        .transition(transition)
                        .navigationTitle("Weight")
                case 3:
                    AgeView()
                        .transition(transition)
                        .navigationTitle("Birthday")
                case 4:
                    SexView()
                        .transition(transition)
                        .navigationTitle("Sex")
                case 5:
                    ActivityView()
                        .transition(transition)
                        .navigationTitle("Activity")
                case 6:
                    GoalView()
                        .transition(transition)
                        .navigationTitle("Goal")
                case 7:
                    CurrentMacrosView()
                        .transition(transition)
                        .navigationTitle("Current Macros")
                default:
                    GoalView()
                        .transition(transition)
                        .navigationTitle("Goal")
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
                               //withAnimation(.easeInOut) {
                                    onboardingState -= 1
                               // }
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
    
    //MARK: Welcome Screen
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
    
    //MARK: Bottom Button
    private var bottomButton: some View {
        VStack {
            Spacer()
            
            Button {
                buttonPressed()
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
    
    //MARK: Button Pressed Func
    private func buttonPressed() {
        if onboardingState == 2 && !viewModel.isValidWeight {
            // Shows invalidWeight Alert from viewModel
        } else if onboardingState == 6 && !viewModel.isValidGoalWeight {
            // Shows invalidGoalWeight Alert from viewModel
        } else if onboardingState == 6 && viewModel.user.goalType == .maintenance {
            viewModel.user.goalWeightLbs = ""
            viewModel.user.goalWeightKgs = ""
            withAnimation(.easeInOut) {
                onboardingState += 1
            }
        } else if onboardingState == 7 && !viewModel.isValidCurrentMacros() {
            // Shows invalidMacros Alert from viewModel
        } else if onboardingState <= 7 {
            withAnimation(.easeInOut) {
                onboardingState += 1
            }
        }
    }
}

