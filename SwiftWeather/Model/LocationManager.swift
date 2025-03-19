//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Jese on 19.3.2025.
//

import Foundation
import CoreLocation
import Combine

final class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {

    @Published var lastKnownLocation: CLLocationCoordinate2D?
    var manager = CLLocationManager()

    override init() {
        super.init()
        manager.delegate = self
    }

    func startUpdatingLocation() {
        manager.startUpdatingLocation()

        switch manager.authorizationStatus {
            case .notDetermined:
                manager.requestWhenInUseAuthorization()
            case .authorizedWhenInUse, .authorizedAlways:
                lastKnownLocation = manager.location?.coordinate
            case .denied, .restricted: break
            @unknown default:
                print("Location service disabled")
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.first?.coordinate
    }
}
