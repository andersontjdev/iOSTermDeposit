//
//  ContentViewModel.swift
//  iOSTermDeposit
//
//  Created by Taylor Anderson on 10/8/2023.
//

import Foundation

protocol IContentViewModel {
    
    func calculateTermDeposit(depositAmount: Double,
                              interestRate: Double,
                              investmentTerm: Double,
                              investmentLength: InvestmentLength,
                              interestPaid: InterestPaid)
}

class ContentViewModel: ObservableObject, IContentViewModel {
    
    @Published var finalBalance = 0.0
    
    private let calculationHelper = CalculationHelper()
    
    func calculateTermDeposit(depositAmount: Double,
                              interestRate: Double,
                              investmentTerm: Double,
                              investmentLength: InvestmentLength,
                              interestPaid: InterestPaid) {
        
        finalBalance = calculationHelper.calculateTermDeposit(depositAmount: depositAmount,
                                                              interestRate: interestRate,
                                                              investmentTerm: investmentTerm,
                                                              investmentLength: investmentLength,
                                                              interestPaid: interestPaid)
    }
    
}
