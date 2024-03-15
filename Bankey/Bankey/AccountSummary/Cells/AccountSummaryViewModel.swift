//
//  AccountSummaryViewModel.swift
//  Bankey
//
//  Created by Baran Baran on 11.03.2024.
//

import Foundation


enum AccountType: String, Codable {
    case Banking
    case CreditCard
    case Investment
}


struct AccountSummaryViewModel {
    let accountType: AccountType
    let accountName: String
    let balance: Decimal
    var balanceAsAttributedString: NSAttributedString {
           return CurrencyFormatter().makeAttributedCurrency(balance)
       }
}
