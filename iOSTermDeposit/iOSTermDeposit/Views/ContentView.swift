//
//  ContentView.swift
//  iOSTermDeposit
//
//  Created by Taylor Anderson on 10/8/2023.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = ContentViewModel()
    
    @State var depositAmount: Double?
    @State var interestRate: Double?
    @State var investmentTermValue: Double?
    @State var investmentTermLength: InvestmentLength = .months
    @State var interestPaid: InterestPaid = .monthly
    
    @State private var isButtonDisabled = true
    
    var body: some View {
        VStack {
            // Title and Logo
            HStack {
                Image(systemName: Constants.treeImage)
                    .imageScale(.large)
                    .foregroundColor(.green)
                Text(Constants.titleText)
            }
            .padding()
            
            // Deposit Fields
            VStack {
                Text(Constants.depositLabel)
                    .padding(.horizontal, 10)
                TextField(Constants.dollarSign, value: $depositAmount, format: .number)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal, 20)
            }
            .padding(.horizontal)
            
            // Interest Rate
            VStack {
                Text(Constants.interestLabel)
                    .padding(.horizontal, 10)
                TextField(Constants.percentageSign, value: $interestRate, format: .percent)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal, 20)
            }
            .padding(.horizontal)
            
            // Investment Term
            VStack {
                Text(Constants.termLabel)
                    .padding(.horizontal, 10)
                HStack {
                    TextField(Constants.termPlaceholder, value: $investmentTermValue, format: .number)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(.roundedBorder)
                    Picker(String(), selection: $investmentTermLength) {
                        ForEach(InvestmentLength.allCases) { length in
                            Text(length.rawValue)
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.horizontal)
            }
            .padding(.horizontal)
            
            // Interest Paid
            VStack {
                Text(Constants.interestPaidLabel)
                    .padding(.horizontal, 10)
                Picker(String(), selection: $interestPaid) {
                    ForEach(InterestPaid.allCases) { length in
                        Text(length.rawValue)
                    }
                }
                .pickerStyle(.segmented)
            }
            .padding([.horizontal, .bottom])
            
            // Submit Button and Final Balance
            VStack {
                Button(Constants.calculateButtonLabel) {
                    viewModel.calculateTermDeposit(depositAmount: depositAmount!, interestRate: interestRate!, investmentTerm: investmentTermValue!, investmentLength: investmentTermLength, interestPaid: interestPaid)
                }
                .buttonStyle(.borderedProminent)
                .padding(.bottom)
                .disabled(isButtonDisabled)
                
                HStack {
                    Text(Constants.finalBalanceLabel)
                        .padding(.horizontal, 10)
                    Text(String(format: "$%.2f", viewModel.finalBalance))
                }
            }
            
            Spacer()
        }
        .onChange(of: depositAmount, perform: checkIsFieldEmpty)
        .onChange(of: interestRate, perform: checkIsFieldEmpty)
        .onChange(of: investmentTermValue, perform: checkIsFieldEmpty)
    }
    
    private func checkIsFieldEmpty(value: Double?) {
        // If any of the three TextFields are empty, the user cannot submit.
        isButtonDisabled = depositAmount ?? 0 <= 0 ||
                            interestRate ?? 0 <= 0 ||
                        investmentTermValue ?? 0 <= 0   
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewLayout(.fixed(width: 320, height: 568))
    }
}
