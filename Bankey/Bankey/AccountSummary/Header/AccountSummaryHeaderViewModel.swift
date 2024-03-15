//
//  AccountSummaryHeaderViewModel.swift
//  Bankey
//
//  Created by Baran Baran on 15.03.2024.
//

import Foundation


struct AccountSummaryHeaderViewModel {
    let welcomeMessage: String
    let name: String
    let date: Date
    
    var dateFormatted: String {
        return date.monthDayYearString
    }
}
