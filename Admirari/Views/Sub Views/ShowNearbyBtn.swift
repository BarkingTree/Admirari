//
//  AddLocation.swift
//  Admirari
//
//  Created by Samuel James House on 18/07/2023.
//

import SwiftUI

struct ShowNearbyBtn: View {
    @StateObject var mapVM: MapVM
    var body: some View {
        Spacer()
        Button {
            Task {
                await mapVM.fetchNearbyPlaces()
            }
        } label: {
            Image(systemName: "eye")
        }
        .padding()
        .background(.black.opacity(mapVM.wikipediaStatus ? 0.25: 0.75))
        .foregroundColor(.white)
        .font(.title)
        .clipShape(Circle())
        
        
        
        
    }
}
