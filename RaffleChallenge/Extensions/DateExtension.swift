//
//  DateExtension.swift
//  RaffleChallenge
//
//  Created by Gregory Keeley on 5/30/21.
//

import Foundation

extension Date {
    static func convertStringISO8601ToFormattedString(strDate:String) -> String {
        let formatter = DateFormatter()
        let timeToConvert = "2021-05-30T22:27:36.349Z"
        let convertedTime = formatter.date(from: timeToConvert)
        let formatter2 = DateFormatter()
        formatter2.dateFormat = "MMM d, h:mm a"
        let formattedTime = formatter2.string(from: convertedTime ?? Date())
        
        return formattedTime
    }
}
