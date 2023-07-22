//
//  LocationView.swift
//  Admirari
//
//  Created by Samuel James House on 18/07/2023.
//

import SwiftUI

struct LocationMarker: View {
    var mapVM: MapVM
    var location: WikipediaLocation
    var body: some View {
        
        VStack {
           Circle()
               .foregroundColor(.blue)
               .frame(width: 20, height: 20)
               
                   
        }.onTapGesture {
            mapVM.selecctedWikiLocation = location
            mapVM.showDetails.toggle()
        }
    }
}

