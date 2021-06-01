//
//  DateExtension.swift
//  RaffleChallenge
//
//  Created by Gregory Keeley on 5/30/21.
//

import Foundation

extension Date {
    static func convertStringISO8601ToFormattedString(strDate: String) -> String {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [ .withFullDate, .withColonSeparatorInTime, .withTime, .withSpaceBetweenDateAndTime]
        let convertedTime = formatter.date(from: strDate) ?? Date()
        return formatter.string(from: convertedTime)
    }
}
