//
//  LocationVM.swift
//  CombineCorePractice
//
//  Created by Daniel Moore on 9/19/23.
//

import CoreLocation
import Combine

class CombineLocationVM: ObservableObject {
    
    // These can be private because we only need to rerender the UI when they change
    // The UI doesn't directly access them
    @Published private var status: CLAuthorizationStatus = .notDetermined
    @Published private var currentLocation: CLLocation?

    @Published var errorMessage = ""

    private let locationManager = LocationManager()
    private var cancellableSet: Set<AnyCancellable> = []

    init() {
        locationManager
            .statusPublisher
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { completion in
                switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        self.errorMessage = error.rawValue
                }
            } receiveValue: { self.status = $0 }
            .store(in: &cancellableSet)

        locationManager
            .locationPublisher
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .removeDuplicates(by: lessThanOneMeter)
            .assign(to: \.currentLocation, on: self)
            .store(in: &cancellableSet)
        }

    private func lessThanOneMeter(_ lhs: CLLocation?, _ rhs: CLLocation?) -> Bool {
        if lhs == nil && rhs == nil {
            return true
        }
        guard let lhr = lhs, let rhr = rhs else { return false }
        return lhr.distance(from: rhr) < 1
    }

    var thereIsAnError: Bool {
        !errorMessage.isEmpty
    }

    var latitude: String {
        currentLocation.latitudeDescription
    }

    var longitude: String {
        currentLocation.longitudeDescription
    }

    var statusDescription: String {
        switch status {
            case .notDetermined: return "notDetermined"
            case .authorizedWhenInUse: return "authorizedWhenInUse"
            case .authorizedAlways: return "authorizedAlways"
            case .restricted: return "restricted"
            case .denied: return "denied"
            @unknown default:
                return "unknown"
        }
    }

    func startUpdating() {
        print("starting update")
        locationManager.start()
    }
}
