//
//  CurrentLocationBtn.swift
//  Admirari
//
//  Created by Samuel James House on 20/07/2023.
//

import SwiftUI
import CoreLocationUI
import MapKit

struct GetCurrentLocationButton: View {
@StateObject var mapVM: MapVM
    var body: some View {
        Button(action: {
            guard let region = mapVM.userLocation else { return }
            mapVM.position = .region(region)
        }, label: {
            Image(systemName: "location")
        })
        .frame(width: 30, height: 30)
        .padding()
        .background(.black.opacity(mapVM.getCurrentLocationButtonState ? 0.25: 0.75))
        .foregroundColor(.white)
        .font(.title)
        .clipShape(Circle())
        .padding(.trailing)
    }
}


