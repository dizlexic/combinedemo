//
//  String.swift
//  CombineCorePractice
//
//  Created by Daniel Moore on 9/19/23.
//

import Foundation

extension String {
    var isStrong: Bool {
        containsACharacter(from: .lowercaseLetters) &&
        containsACharacter(from: .uppercaseLetters) &&
        containsACharacter(from: .decimalDigits) &&
        containsACharacter(from: .alphanumerics.inverted)
    }
    
    var weatherIcon: String {
        switch self {
            case "01d": return "sun.max"
            case "02d": return "cloud.sun"
            case "03d": return "cloud"
            case "04d": return "cloud.fill"
            case "09d": return "cloud.rain"
            case "10d": return "cloud.sun.rain"
            case "11d": return "cloud.bolt"
            case "13d": return "cloud.snow"
            case "50d": return "cloud.fog"
            case "01n": return "moon"
            case "02n": return "cloud.moon"
            case "03n": return "cloud"
            case "04n": return "cloud.fill"
            case "09n": return "cloud.rain"
            case "10n": return "cloud.moon.rain"
            case "11n": return "cloud.bolt"
            case "13n": return "cloud.snow"
            case "50n": return "cloud.fog"
            default: return "icloud.slash"
        }
    }
    
    private func containsACharacter(from set: CharacterSet) -> Bool {
        rangeOfCharacter(from: set) != nil
    }
 }
