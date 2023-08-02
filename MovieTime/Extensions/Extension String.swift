//
//  Extension String.swift
//  MovieTime
//
//  Created by Eken Özlü on 26.06.2023.
//

import Foundation

extension String {
    func getYearOfTheDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: self) {
            let calendar = Calendar.current
            let year = calendar.component(.year, from: date)
            return String(year)
        } else {
            return "Invalid date format"
        }
    }
    
    func getProperYearFormat() -> String {
        let originalDateFormatter = DateFormatter()
        originalDateFormatter.dateFormat = "yyyy-MM-dd"

        let formattedDateFormatter = DateFormatter()
        formattedDateFormatter.dateFormat = "dd MMM yyyy"

        if let date = originalDateFormatter.date(from: self) {
            let formattedDateString = formattedDateFormatter.string(from: date)
            return formattedDateString
        } else {
            return "Invalid date format"
        }
    }
    
    func isValidEmail() -> Bool {
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
    
}
