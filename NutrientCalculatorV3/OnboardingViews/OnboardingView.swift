//
//  OnboardingView.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 6/10/22.
//

import SwiftUI
import CoreData

struct OnboardingView: View {

    @Environment(\.managedObjectContext) var moc
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject private var viewModel: GlobalUserViewModel
    
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
                    HeightView(updateHeight: false)
                        .transition(transition)
                        .navigationTitle("Height")
                case 2:
                    WeightView()
                        .transition(transition)
                        .navigationTitle("Weight")
                case 3:
                    AgeView(updateAge: false)
                        .transition(transition)
                        .navigationTitle("Birthday")
                case 4:
                    SexView(updateSex: false)
                        .transition(transition)
                        .navigationTitle("Sex")
                case 5:
                    ActivityView(updateActivity: false)
                        .transition(transition)
                        .navigationTitle("Activity")
                case 6:
                    GoalView(updateGoalWeight: false)
                        .transition(transition)
                        .navigationTitle("Goal")
                case 7:
                    InputCurrentMacrosView()
                        .transition(transition)
                        .navigationTitle("Current Macros")
                case 8:
                    CaloriePreferenceView(updateCaloriePreference: false)
                        .transition(transition)
                        .navigationTitle("Calorie Preference")
                case 9:
                    AdjustedCalorieDaysView(updateTrainingDays: false)
                        .transition(transition)
                        .navigationTitle("High Calorie Days")
                default:
                    OnboardingUserInfoSummaryView()
                        .transition(transition)
                        .navigationTitle("Summary")
                }
                
                VStack {
                    Spacer()
                    Rectangle()
                        .fill(colorScheme == .light ? Color.white : Color.black)
                        .ignoresSafeArea()
                        .frame(height: 60)
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
                            if onboardingState == 10 && !viewModel.user.dynamicCalories {
                                onboardingState -= 2
                            } else if onboardingState > 0 {
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
    
    //MARK: Welcome Screen
    private var welcomeScreen: some View {
        VStack {
            Image("HypertroFit")
                .resizable()
                .scaledToFit()
                .frame(width: 200)
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
                if onboardingState == 7 {
                    Text("Proceed to Step \(onboardingState + 1)/9")
                        .frame(height: 30)
                        .frame(maxWidth: .infinity)
                } else if onboardingState == 8 && viewModel.user.dynamicCalories {
                    Text("Proceed to Step \(onboardingState)b/9")
                        .frame(height: 30)
                        .frame(maxWidth: .infinity)
                } else if onboardingState <= 8 {
                    Text("Proceed to Step \(onboardingState + 1)/9")
                        .frame(height: 30)
                        .frame(maxWidth: .infinity)
                } else if onboardingState == 9 {
                    Text("Proceed to Step \(onboardingState)/9")
                        .frame(height: 30)
                        .frame(maxWidth: .infinity)
                } else {
                    Text("Submit Profile")
                        .frame(height: 30)
                        .frame(maxWidth: .infinity)
                }
            }
            .modifier(UserInfoSubmitButtonModifier())
        }
    }
    
    //MARK: func buttonPressed
    private func buttonPressed() {
        if onboardingState == 2 && !viewModel.isValidWeight() {
            // Shows invalidWeight Alert from viewModel
        } else if onboardingState == 6 && !viewModel.isValidGoalWeight() {
            // Shows invalidGoalWeight Alert from viewModel
        } else if onboardingState == 6 && viewModel.user.goalType == .maintenance {
            viewModel.user.inputGoalWeight = ""
            withAnimation(.easeInOut) {
                onboardingState += 1
            }
        } else if onboardingState == 7 && !viewModel.isValidCurrentMacros() {
            // Shows invalidMacros Alert from viewModel
        } else if onboardingState == 8 && !viewModel.user.dynamicCalories {
            withAnimation(.easeInOut) {
                onboardingState += 2
            }
        } else if onboardingState <= 9 {
            withAnimation(.easeInOut) {
                onboardingState += 1
            }
        } else {
            completeAccountCreation()
        }
    }
    
    // MARK: func completeAccount
    private func completeAccountCreation() {
        CheckInDataService().addWeighIn(
            date: Date(),
            weight: viewModel.user.startingWeight,
            context: moc)
        
        CheckInDataService().addCheckIn(
            averageWeight: viewModel.user.startingWeight,
            calories: 2500,
            fats: 90,
            carbs: 200,
            protein: 200,
            context: moc)
        
        viewModel.saveProfile()
    }
}

