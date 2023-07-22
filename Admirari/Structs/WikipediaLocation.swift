//
//  WikipediaItem.swift
//  Admirari
//
//  Created by Samuel James House on 21/07/2023.
//

import Foundation
import MapKit

struct WikipediaLocation: Identifiable {
    let id: Int
    let name: String
    let coordinates: CLLocationCoordinate2D
    let distance: Double
    let url: URL
    
    init(id: Int, name: String, lat: Double, lon: Double, distance: Double) {
        self.id = id
        self.name = name
        self.coordinates = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        self.distance = distance
        self.url = URL(string: "http://en.m.wikipedia.org/?curid=\(id)")!
    }
}
