//
//  ContentView.swift
//  WeSplit
//
//  Created by Razvan Dumitriu on 20.03.2022.
//

import SwiftUI

struct ContentView: View {
    @FocusState private var amountIsFocused: Bool
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        let people = Double(numberOfPeople + 2)
        let tip = Double(tipPercentage)
        
        let tipValue = Double(checkAmount * tip / 100)
        let total = checkAmount + tipValue
        
        return total / people
    }
    
    var totalPlusTip: Double {
        let tip = Double(tipPercentage)
        let tipValue = Double(checkAmount * tip / 100)
        
        return checkAmount + tipValue
    }
    
    func currency() -> FloatingPointFormatStyle<Double>.Currency {
        return .currency(code: Locale.current.currencyCode ?? "USD")
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: currency())
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                } header: {
                    Text("Check amount")
                }
                Section {
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2 ..< 100) {
                            Text("\($0) people")
                        }
                    }
                } header: {
                    Text("Number of people")
                }
                .pickerStyle(.wheel)
                Section {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Tip Percentage")
                }
                Section {
                    Text(totalPlusTip, format: currency())
                } header: {
                    Text("Total including tip")
                }
                Section {
                    Text(totalPerPerson, format: currency())
                } header: {
                    Text("Total per Person")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
