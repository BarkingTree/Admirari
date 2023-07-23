//
//  LocationLust.swift
//  Admirari
//
//  Created by Samuel James House on 22/07/2023.
//

import SwiftUI

struct LocationList: View {
    @StateObject var mapVM: MapVM
   
    var body: some View {
        NavigationView {
            Form {
                ForEach(mapVM.wikiLocations) { location in
                    HStack {
                        Link(location.name, destination: location.url)
                        Spacer()
                        Text("\(String(format: "%.0f", location.distance))m")
                    }
                }
            }.navigationTitle("Nearby Locations")
        }
        
    }
}

