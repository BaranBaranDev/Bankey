//
//  CurrencyFormatter.swift
//  Bankey
//
//  Created by Baran Baran on 11.03.2024.
//


import UIKit

struct CurrencyFormatter {
    // Para miktarını biçimlendirilmiş bir NSAttributedString olarak döndürür
    func makeAttributedCurrency(_ amount: Decimal) -> NSMutableAttributedString {
        // Para miktarını dolar ve sent olarak ayırır ve biçimlendirilmiş bir NSAttributedString olarak döndürür
        let tuple = breakIntoDollarsAndCents(amount)
        return makeBalanceAttributed(dollars: tuple.0, cents: tuple.1)
    }
    
    // Para miktarını dolar ve sent olarak ayırır
    func breakIntoDollarsAndCents(_ amount: Decimal) -> (String, String) {
        // Para miktarını Double türüne dönüştürür ve dolar ve sent olarak ayırır
        let tuple = modf(amount.doubleValue)
        
        // Dolar ve sent olarak ayrılmış miktarı String'e dönüştürür
        let dollars = convertDollar(tuple.0)
        let cents = convertCents(tuple.1)
        
        return (dollars, cents)
    }
    
    // Dolar kısmını biçimlendirir
    private func convertDollar(_ dollarPart: Double) -> String {
        // Dolar kısmını biçimlendirilmiş bir şekilde geri döndürür
        let dollarsWithDecimal = dollarsFormatted(dollarPart) // Örn: "$929,466.00"
        let formatter = NumberFormatter()
        let decimalSeparator = formatter.decimalSeparator! // Decimal ayracını alır (varsayılan olarak ".")
        let dollarComponents = dollarsWithDecimal.components(separatedBy: decimalSeparator) // Örn: ["$929,466", "00"]
        var dollars = dollarComponents.first! // "$929,466"
        dollars.removeFirst() // "929,466"

        return dollars
    }
    
    // Sent kısmını biçimlendirir
    private func convertCents(_ centPart: Double) -> String {
        // Sent kısmını biçimlendirilmiş bir şekilde geri döndürür
        let cents: String
        if centPart == 0 {
            cents = "00"
        } else {
            cents = String(format: "%.0f", centPart * 100)
        }
        return cents
    }
    
    // Dolar kısmını biçimlendirir
    func dollarsFormatted(_ dollars: Double) -> String {
        // Dolar kısmını biçimlendirilmiş bir şekilde geri döndürür
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.usesGroupingSeparator = true
        
        if let result = formatter.string(from: dollars as NSNumber) {
            return result
        }
        
        return ""
    }
    
    // Dolar ve sent kısmını biçimlendirilmiş bir NSAttributedString olarak döndürür
    private func makeBalanceAttributed(dollars: String, cents: String) -> NSMutableAttributedString {
        // Dolar işareti, dolar miktarı ve sent miktarını içeren bir NSAttributedString oluşturur
        let dollarSignAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .callout), .baselineOffset: 8]
        let dollarAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .title1)]
        let centAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .callout), .baselineOffset: 8]
        
        let rootString = NSMutableAttributedString(string: "$", attributes: dollarSignAttributes)
        let dollarString = NSAttributedString(string: dollars, attributes: dollarAttributes)
        let centString = NSAttributedString(string: cents, attributes: centAttributes)
        
        // Tüm parçaları birleştirerek bir NSAttributedString oluşturur ve geri döndürür
        rootString.append(dollarString)
        rootString.append(centString)
        
        return rootString
    }
}
