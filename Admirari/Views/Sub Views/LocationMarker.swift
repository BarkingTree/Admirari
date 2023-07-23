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
          Image(systemName: "w.circle")
                .foregroundColor(.blue)
                .frame(width: 30, height: 30)
                .background(.white)
                .clipShape(Circle())
               
                   
        }.onTapGesture {
            mapVM.selecctedWikiLocation = location
            mapVM.showDetails.toggle()
        }
    }
}

