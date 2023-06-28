//
//  Metric Extension.swift
//  MovieTime
//
//  Created by Eken Özlü on 26.06.2023.
//

import Foundation

extension Double {
    private static var valueFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    func formattedValue() -> String {
        let number = NSNumber(value: self)
        return Self.valueFormatter.string(from: number)!
    }
}
