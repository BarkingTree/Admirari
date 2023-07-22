//
//  Results.swift
//  Admirari
//
//  Created by Samuel James House on 18/07/2023.
//

import Foundation
import MapKit

struct Result: Codable {
    let query: Query
}

struct Query: Codable {
    let pages: [Page]
    let geosearch: [GeoItem]
}

struct Page: Codable {
    let pageid: Int
    let title: String
    let terms: [String: [String]]?
    
    // Computed variables
    var url: URL {
        return URL(string: "http://en.wikipedia.org/?curid=\(pageid)")!
    }
}

struct GeoItem: Codable {
    let pageid: Int
    let ns: Int
    let title: String
    let lat: Double
    let lon: Double
    let dist: Double
    let primary: Bool
    
    // Computed variables
    var url: URL {
        return URL(string: "http://en.wikipedia.org/?curid=\(pageid)")!
    }
    var coordinates: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: lat, longitude: lon)
    }
}
