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
    
    var body: some View {
        VStack {
            Text(wikipediaLocation.name)
            Text("\(wikipediaLocation.coordinates.latitude) | \(wikipediaLocation.coordinates.longitude)")
            Text("\(wikipediaLocation.id)")
            Link("Web Link", destination: wikipediaLocation.url)
        }
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        LocationDetail(mapVM: MapVM(), wikipediaLocation: WikipediaLocation(id: 1, name: "Test", lat: 1, lon: 1, distance: 1))
    }
}
