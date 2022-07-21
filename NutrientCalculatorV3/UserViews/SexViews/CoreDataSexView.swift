//
//  CoreDataSexView.swift
//  NutrientCalculatorV3
//
//  Created by Kyle Blandford on 7/19/22.
//

import SwiftUI
import CoreData


struct CoreDataSexView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var viewModel: EnvironmentViewModel
    
    private var user: [TheUser]
    
    @State var sexSelection: String
    @State var updateSex: Bool
    
    init (viewModel: EnvironmentViewModel, updateSex: Bool, moc: NSManagedObjectContext ) {
        self.user = viewModel.coreDataUser
        self._updateSex = State(wrappedValue: updateSex)
        
        if user.count > 0 {
            self._sexSelection = State(initialValue: user.first?.sex ?? "n/a")
        } else {
            self._sexSelection = State(initialValue: "Male")//TheUser(context: moc).sex ?? "n/a")
        }

        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color.accentColor) //changes selected background

        let attributes: [NSAttributedString.Key:Any] = [
            .foregroundColor : UIColor(Color.inverseAccentColor)
        ]
        UISegmentedControl.appearance().setTitleTextAttributes(attributes, for: .selected) //changes selected foreground
    }

// Working solution with @FetchRequest
/*
    
//    @Environment(\.presentationMode) var presentationMode
//    @EnvironmentObject private var viewModel: EnvironmentViewModel
//    @FetchRequest(sortDescriptors: []) private var user: FetchedResults<TheUser>
//
//    @State var sexSelection: String
//    @State var updateSex: Bool
//
//    init (moc: NSManagedObjectContext, updateSex: Bool) {
//        let fetchRequest: NSFetchRequest<TheUser> = TheUser.fetchRequest()
//        fetchRequest.sortDescriptors = []
//        fetchRequest.predicate = NSPredicate(value: true)
//        self._user = FetchRequest(fetchRequest: fetchRequest)
//        self._updateSex = State(wrappedValue: updateSex)
//
//        do {
//            let theUser = try moc.fetch(fetchRequest)
//            if theUser.count > 0 {
//                self._sexSelection = State(initialValue: theUser[0].sex ?? "Male")
//            } else {
//                self._sexSelection = State(initialValue: TheUser(context: moc).sex ?? "n/a")
//            }
//
//        } catch {
//            fatalError("init problem")
//        }
//
//        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color.accentColor) //changes selected background
//
//        let attributes: [NSAttributedString.Key:Any] = [
//            .foregroundColor : UIColor(Color.inverseAccentColor)
//        ]
//        UISegmentedControl.appearance().setTitleTextAttributes(attributes, for: .selected) //changes selected foreground
//    }
    
*/
    
    var body: some View {
        VStack {
            Text("We need to know your biological sex in order to accurately calculate calorie and macronutrient requirements for your specific goal.")
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .padding(.bottom, 20)
            
            sexSymbolImage
            sexPicker
            
            Spacer()
            
            if updateSex {
                HStack {
                    backButton
                    submitButton
                }
            }
        }
        .onDisappear {
            if !updateSex {
                viewModel.updateUser(entity: user.first!, sex: sexSelection)
            }
        }
    }
}

struct CoreDataSexView_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataSexView(viewModel: dev.environmentViewModel, updateSex: true, moc: dev.environmentViewModel.manager.context)
            .environmentObject(dev.environmentViewModel)
    }
}

extension CoreDataSexView {
    
    private var sexSymbolImage: some View {
        Image(sexSelection == "Male" ? "MaleSymbol" : "FemaleSymbol")
            .resizable()
            .scaledToFit()
            .frame(height: 220)
    }
    
    private var sexPicker: some View {
        Picker(selection: $sexSelection) {
            Text("Male")
                .tag("Male")
            Text("Female")
                .tag("Female")
        } label: {
            Text("Sex")
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding()
        .padding(.top, 20)
    }
    
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
        viewModel.updateUser(entity: user.first!, sex: sexSelection)
        presentationMode.wrappedValue.dismiss()
    }
}
