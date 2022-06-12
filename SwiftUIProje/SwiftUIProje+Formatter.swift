//
//  SwiftUIProje+Formatter.swift
//  SwiftUIProje
//
//  Created by BusranurOK on 12.06.2022.
//

import Foundation

struct Formatters {
    
    static let dollarFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        //Currency para birimi formatlar
        formatter.numberStyle = .currency
        formatter.currencySymbol = "$"
        formatter.currencyCode = "USD"
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        return formatter    }()
    
}
