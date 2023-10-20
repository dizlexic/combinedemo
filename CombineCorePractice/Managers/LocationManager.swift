//
//  LocationManager.swift
//  CombineCorePractice
//
//  Created by Daniel Moore on 9/19/23.
//

import CoreLocation
import Combine

class LocationManager: NSObject {
    enum LocationError: String, Error {
        case restricted, denied, unknown
    }
    private let locationManager = CLLocationManager()
    
    let statusPublisher = PassthroughSubject<CLAuthorizationStatus, LocationError>()
    let locationPublisher = PassthroughSubject<CLLocation?, Never>()
        
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    func start() {
        locationManager.startUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
            case .restricted:
                statusPublisher.send(completion: .failure(.restricted))
            case .denied:
                statusPublisher.send(completion: .failure(.denied))
            case .notDetermined, .authorizedAlways, .authorizedWhenInUse:
                statusPublisher.send(manager.authorizationStatus)
            @unknown default:
                statusPublisher.send(completion: .failure(.unknown))
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        locationPublisher.send(location)
    }
}
