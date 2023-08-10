//
//  CalculationHelper.swift
//  iOSTermDeposit
//
//  Created by Taylor Anderson on 10/8/2023.
//

import Foundation

protocol ICalculationHelper {
    
    func calculateTermDeposit(depositAmount: Double,
                              interestRate: Double,
                              investmentTerm: Double,
                              investmentLength: InvestmentLength,
                              interestPaid: InterestPaid) -> Double
    
}

class CalculationHelper: ICalculationHelper {

    func calculateTermDeposit(depositAmount: Double,
                              interestRate: Double,
                              investmentTerm: Double,
                              investmentLength: InvestmentLength,
                              interestPaid: InterestPaid) -> Double {
        
        // Get the total length for the term in months.
        let totalLength = getTotalTermInMonths(investmentTerm: investmentTerm, investmentLength: investmentLength)
        var currentAmount = depositAmount

        // Depending on when interest should be paid, calculate the amount + interest.
        switch interestPaid {
        case .monthly:
            for _ in 1...totalLength {
                currentAmount *= (1 + interestRate / 12)
            }
        case .quarterly:
            for _ in 1...(totalLength / 3) {
                currentAmount *= (1 + interestRate / 4)
            }
        case .annually:
            for _ in 1...(totalLength / 12) {
                currentAmount *= (1 + interestRate)
            }
        case .maturity:
            currentAmount *= (1 + interestRate * Double(totalLength) / 12)
        }
        
        return currentAmount
    }
    
    private func getTotalTermInMonths(investmentTerm: Double, investmentLength: InvestmentLength) -> Int {
        
        let totalLengthInMonths: Int
        
        switch investmentLength {
        case .months:
            totalLengthInMonths = Int(investmentTerm)
        case .years:
            totalLengthInMonths = Int(investmentTerm * 12)
        }
        
        return totalLengthInMonths
    }
    
}
