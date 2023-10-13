//
//  EditView.swift
//  Admirari
//
//  Created by Samuel James House on 18/07/2023.
//

import SwiftUI

struct ArticleDetails: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var mapVM: MapVM
    var wikipediaLocation: WikipediaLocation
    var distance: String {
        return String(format: "%.0f", wikipediaLocation.distance)
    }
    
    var body: some View {
       
            HStack {
                VStack(alignment: .leading) {
                    Text(wikipediaLocation.name).font(.title2).multilineTextAlignment(.leading)
                    Text("Distance: \(distance)m")
                    Text("\(wikipediaLocation.coordinates.latitude) | \(wikipediaLocation.coordinates.longitude)")
                }
                Spacer()
                Link(destination: wikipediaLocation.url) {
                    Image(systemName: "safari").font(.largeTitle)
                }
            }
            .padding(.all)
        
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleDetails(mapVM: MapVM(), wikipediaLocation: WikipediaLocation(id: 1, name: "Test", lat: 1, lon: 1, distance: 1))
    }
}
