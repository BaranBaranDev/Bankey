//
//  DecimalUtils.swift
//  Bankey
//
//  Created by Baran Baran on 11.03.2024.
//

import Foundation



extension Decimal {
    var doubleValue: Double {
        return NSDecimalNumber(decimal:self).doubleValue
    }
}


