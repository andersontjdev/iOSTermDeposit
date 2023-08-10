//
//  Enums.swift
//  iOSTermDeposit
//
//  Created by Taylor Anderson on 10/8/2023.
//

import Foundation

enum InvestmentLength: String, CaseIterable, Identifiable {
    case months = "Months"
    case years = "Years"
    
    var id: Self { self }
}

enum InterestPaid: String, CaseIterable, Identifiable {
    case monthly = "Monthly"
    case quarterly = "Quarterly"
    case annually = "Annually"
    case maturity = "At Maturity"
    
    var id: Self { self }
}
