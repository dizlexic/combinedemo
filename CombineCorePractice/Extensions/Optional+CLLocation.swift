//
//  Optional+CLocation.swift
//  CombineCorePractice
//
//  Created by Daniel Moore on 9/19/23.
//

import CoreLocation

extension Optional where Wrapped == CLLocation {
    var latitudeDescription: String {
        guard let self = self else { return "-" }
        return String(format: "%0.4f", self.coordinate.latitude)
    }
    
    var longitudeDescription: String {
        guard let self = self else { return "-" }
        return String(format: "%0.4f", self.coordinate.longitude)
    }
}


