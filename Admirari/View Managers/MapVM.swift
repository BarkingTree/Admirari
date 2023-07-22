//
//  MapVM.swift
//  Admirari
//
//  Created by Samuel James House on 18/07/2023.
//

import Foundation
import MapKit
import SwiftUI
import CoreLocation

class MapVM: NSObject, ObservableObject, CLLocationManagerDelegate {
    // MARK: MapKit
    @Published var tracking:MapUserTrackingMode = .follow
    var locationButtonDisabled: Bool {
        switch tracking {
        case .none:
            return false
        case .follow:
            return true
        @unknown default:
            return false
        }
    }
    
    @Published var region = MKCoordinateRegion(
        center:  CLLocationCoordinate2D(
          latitude: 61.94992065,
          longitude:-143.16013602
        ),
        span: MKCoordinateSpan(
          latitudeDelta: 0.05,
          longitudeDelta: 0.05
       )
    )
    
    // MARK: CoreLocation
    let manager = CLLocationManager()
    @Published var authorizationStatus: CLAuthorizationStatus?
    @Published var showDetails: Bool = false
    
    
    override init() {
            wikipediaLoadingState = .loading
            super.init()
            manager.delegate = self
        }

        // Called whenever authorisation status regarding accessing the user's location is altered.
        func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
           switch manager.authorizationStatus {
           case .authorizedWhenInUse:  // Location services are available.
               // Insert code here of what should happen when Location services are authorized
               manager.requestLocation()
               authorizationStatus = .authorizedWhenInUse
               break
               
           case .restricted, .denied:  // Location services currently unavailable.
               // Insert code here of what should happen when Location services are NOT authorized
               authorizationStatus = .restricted
               break
               
           case .notDetermined:        // Authorization not determined yet.
               manager.requestWhenInUseAuthorization()
               authorizationStatus = .notDetermined
               break
               
           default:
               break
           }
       }
    
    // Called when new location data is available. Note that the MKCoordinate region is the region that is currently being displayed by the Map view. It does not relate to the location currently being displayed by the map and does not relate to current location.
    // To do relate longitude delta and MKCoordinate span related to wikipedia api query regarding area to display for.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locations.last.map {
            region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: $0.coordinate.latitude, longitude: $0.coordinate.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            )
        }
    }
    
    // Called when unable to access location 
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print("error: \(error.localizedDescription)")
    }
    
    func returnToUserLocation() {

    }
    
    // MARK: Fetch from Wikipedia API
    enum WikipediaLoadingState {
        case loading, loaded, failed
    }
    @Published var wikipediaLoadingState: WikipediaLoadingState
    @Published var showLocationList: Bool = false
    @Published var wikiLocations: [WikipediaLocation] = []
    @Published var selecctedWikiLocation: WikipediaLocation = WikipediaLocation(id: 1, name: "Test", lat: 1, lon: 1, distance: 1)
    var wikipediaStatus: Bool {
        return spanDistanceCheck()
    }
    
    // Convert lattitude and longitude into metres. Do not display if > 5000 metres
    private func spanDistanceCheck() -> Bool {
        var disabled = false
        let span = region.span
        let center = region.center
        let loc1 = CLLocation(latitude: center.latitude - span.latitudeDelta * 0.5, longitude: center.longitude)
        let loc2 = CLLocation(latitude: center.latitude + span.latitudeDelta * 0.5, longitude: center.longitude)
        let loc3 = CLLocation(latitude: center.latitude, longitude: center.longitude - span.longitudeDelta * 0.5)
        let loc4 = CLLocation(latitude: center.latitude, longitude: center.longitude + span.longitudeDelta * 0.5)
        
        let metersInLatitude = loc1.distance(from: loc2)
        let metersInLongitude = loc3.distance(from: loc4)
        if metersInLatitude > 2500 || metersInLongitude > 2500 {
            disabled = true
        } else {
            disabled = false
        }
        return disabled
    }
    
    // Convert lattitude and longitude into metres for wikipedia API query
    private func spanDistanceRadius() -> Int {
        var radius: Double = 0
        let span = region.span
        let center = region.center
        let loc1 = CLLocation(latitude: center.latitude - span.latitudeDelta * 0.5, longitude: center.longitude)
        let loc2 = CLLocation(latitude: center.latitude + span.latitudeDelta * 0.5, longitude: center.longitude)
        let loc3 = CLLocation(latitude: center.latitude, longitude: center.longitude - span.longitudeDelta * 0.5)
        let loc4 = CLLocation(latitude: center.latitude, longitude: center.longitude + span.longitudeDelta * 0.5)
        
        let metersInLatitude = loc1.distance(from: loc2)
        let metersInLongitude = loc3.distance(from: loc4)
        print("Meters in Lattitude: \(metersInLatitude)")
        print("Meters in Longitude: \(metersInLongitude)")
        if metersInLatitude > metersInLongitude {
            radius = metersInLatitude / 2.0
        } else if metersInLongitude > metersInLatitude {
            radius = metersInLongitude / 2.0
        }
        return Int(radius)
    }
    
    
    func fetchNearbyPlaces() async {
        let urlString = "https://en.wikipedia.org/w/api.php?action=query&format=json&prop=&list=geosearch&titles=Wikimedia%20Foundation&formatversion=2&gscoord=\(region.center.latitude)%7C\(region.center.longitude)&gsradius=\(spanDistanceRadius())&gslimit=1000"
            print(urlString)
        guard let url = URL(string: urlString) else {
            print("Bad URL: \(urlString)")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let items = try JSONDecoder().decode(Result.self, from: data)
            // Convert items to array of results that are nearby
            // Avoid publishing off background thread
            DispatchQueue.main.async {
                self.wikiLocations = []
                self.wikiLocations = items.query.geosearch.map { WikipediaLocation(id: $0.pageid, name: $0.title, lat: $0.lat, lon: $0.lon, distance: $0.dist) }
                self.wikipediaLoadingState = .loaded
                print(self.wikiLocations)
                print("Displaying \(self.wikiLocations.count)")
            }
            
        } catch {
            // if we're still here it means the request failed somehow
            DispatchQueue.main.async {
                self.wikipediaLoadingState = .failed
            }
        }
    }
}


