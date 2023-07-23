//
//  EditView.swift
//  Admirari
//
//  Created by Samuel James House on 18/07/2023.
//

import SwiftUI

struct LocationDetail: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var mapVM: MapVM
    var wikipediaLocation: WikipediaLocation
    var distance: String {
        return String(format: "%.0f", wikipediaLocation.distance)
    }
    
    var body: some View {
        VStack {
            Link(wikipediaLocation.name, destination: wikipediaLocation.url).font(.title).padding().multilineTextAlignment(.center)
            
            Text("Latitude: \(wikipediaLocation.coordinates.latitude) | Longitude: \(wikipediaLocation.coordinates.longitude)").padding().multilineTextAlignment(.center)
            Text("Distance: \(distance)m")
        }
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        LocationDetail(mapVM: MapVM(), wikipediaLocation: WikipediaLocation(id: 1, name: "Test", lat: 1, lon: 1, distance: 1))
    }
}
