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
    // Current camera position of the map
    @Published var position = MapCameraPosition.userLocation(fallback: .automatic)
    // Region currently being diplayed to allow for API Calls & Zoom level when returning to current location
    @Published var region: MKCoordinateRegion?
    // Users current location
    var userLocation: MKCoordinateRegion?
    
    // MARK: CoreLocation
    // Location Manager
    let manager = CLLocationManager()
    @Published var authorizationStatus: CLAuthorizationStatus?

    // Called whenever authorisation status regarding accessing the user's location is altered.
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
       case .authorizedWhenInUse:  // Location services are available.
           // Insert code here of what should happen when Location services are authorized
           manager.requestLocation()
           authorizationStatus = .authorizedWhenInUse
           break
           
       case .restricted, .denied:  // Location services currently unavailable.
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
    
    // Called when location changes
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        guard let region = region else { return }
        // Checks user location. Zoom is maintained by calling region of the map that is currently being viewed
        userLocation = MKCoordinateRegion(center: location.coordinate, span: region.span)
        }
    
    // Called when unable to access location 
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print("error: \(error.localizedDescription)")
    }
    
    // MARK: Wikipedia API
    enum WikipediaLoadingState {
        case loading, loaded, failed
    }
    @Published var wikipediaLoadingState: WikipediaLoadingState
    @Published var wikiLocations: [WikipediaLocation] = []
    @Published var selecctedWikiLocation: WikipediaLocation = WikipediaLocation(id: 1, name: "Test", lat: 1, lon: 1, distance: 1)
    
    // Save last location search details
    var lastSearchLocation: CLLocationCoordinate2D?
    var lastSearchRadius: CLLocationDistance?
    
    // Convert lattitude and longitude into metres. Do not display if > 10000 metres
    private func spanDistanceCheck() -> Bool {
        if let region = region {
            var disabled = false
            let span = region.span
            let center = region.center
            let loc1 = CLLocation(latitude: center.latitude - span.latitudeDelta * 0.5, longitude: center.longitude)
            let loc2 = CLLocation(latitude: center.latitude + span.latitudeDelta * 0.5, longitude: center.longitude)
            let loc3 = CLLocation(latitude: center.latitude, longitude: center.longitude - span.longitudeDelta * 0.5)
            let loc4 = CLLocation(latitude: center.latitude, longitude: center.longitude + span.longitudeDelta * 0.5)
            let metersInLatitude = loc1.distance(from: loc2)
            let metersInLongitude = loc3.distance(from: loc4)
            if metersInLatitude > 10000 || metersInLongitude > 10000 {
                disabled = true
            } else {
                disabled = false
            }
            return disabled
        } else {
            return false
        }
    }
    
    // Convert lattitude and longitude into metres for wikipedia API query
    func spanDistanceRadius() -> Int {
        if let region = region {
            var radius: Double = 0
            let span = region.span
            let center = region.center
            let loc1 = CLLocation(latitude: center.latitude - span.latitudeDelta * 0.5, longitude: center.longitude)
            let loc2 = CLLocation(latitude: center.latitude + span.latitudeDelta * 0.5, longitude: center.longitude)
            let loc3 = CLLocation(latitude: center.latitude, longitude: center.longitude - span.longitudeDelta * 0.5)
            let loc4 = CLLocation(latitude: center.latitude, longitude: center.longitude + span.longitudeDelta * 0.5)
            
            let metersInLatitude = loc1.distance(from: loc2)
            let metersInLongitude = loc3.distance(from: loc4)
            
            if metersInLatitude > metersInLongitude {
                radius = metersInLatitude / 2.0
            } else if metersInLongitude > metersInLatitude {
                radius = metersInLongitude / 2.0
            }
            return Int(radius)
        } else {
            return 0
        }
    }
    
    func fetchNearbyPlaces() async {
        // Search for a list of articles by coordinates and radius.
        guard let region = region else { return }
        // Update last search locations and radius to allow for display on map
        lastSearchLocation = region.center
        lastSearchRadius = CLLocationDistance(spanDistanceRadius())
        let urlString = "https://en.wikipedia.org/w/api.php?action=query&format=json&prop=&list=geosearch&titles=Wikimedia%20Foundation&formatversion=2&gscoord=\(region.center.latitude)%7C\(region.center.longitude)&gsradius=\(spanDistanceRadius())&gslimit=200"
          
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
                self.wikiLocations = items.query.geosearch.map { WikipediaLocation(id: $0.pageid, name: $0.title, lat: $0.lat, lon: $0.lon, distance: $0.dist) }
                self.wikiLocations.sort {
                    $0.distance < $1.distance
                }
                self.wikipediaLoadingState = .loaded
            }

        } catch {
            // if we're still here it means the request failed somehow
            DispatchQueue.main.async {
                self.wikipediaLoadingState = .failed
            }
        }
    }
    
    // MARK: Button Controls States
    // Sheet Controllers
    @Published var showListOfArticles: Bool = false
    @Published var showArticleDetails: Bool = false
    
    // State of button to get users current location
    var getCurrentLocationButtonState: Bool {
        switch position.positionedByUser {
        case true:
            return false
        case false:
            return true
        }
    }
    // State of button to show articles
    var listOfArticlesButtonState: Bool {
        if wikiLocations.count == 0 {
            return true
        } else {
            return false
        }
    }
    
    // Function to determine if searching for nearby articles is active
    func searchForArticlesButtonState() -> Bool {
        var value = false
        var wikipediaStatusLoadingDisabled: Bool {
            switch wikipediaLoadingState {
            case .loaded:
                return false
            case .failed:
                return false
            case .loading:
                return true
            }
        }
        if spanDistanceCheck() == false && wikipediaStatusLoadingDisabled == false {
            value = false
        }
        if spanDistanceCheck() == true && wikipediaStatusLoadingDisabled == false {
            value = true
        }
        if spanDistanceCheck() == false && wikipediaStatusLoadingDisabled == true {
            value = true
        }
        if spanDistanceCheck() == true && wikipediaStatusLoadingDisabled == true {
            value = true
        }
        return value
    }
    
    override init() {
            wikipediaLoadingState = .loaded
            super.init()
            manager.delegate = self
            // Ensure manager is tracking current location.
            manager.startUpdatingLocation()
        }
}

