//
//  CurrentLocationBtn.swift
//  Admirari
//
//  Created by Samuel James House on 20/07/2023.
//

import SwiftUI
import CoreLocationUI

struct LocationListBtn: View {
@StateObject var mapVM: MapVM
    var body: some View {
        Button(action: {
            mapVM.showLocationList.toggle()
            print(mapVM.region.center)
            print(mapVM.spanDistanceRadius())
        }, label: {
            Image(systemName: "list.bullet")
        })
        .padding()
        .background(.black.opacity(0.75))
        .foregroundColor(.white)
        .font(.title)
        .clipShape(Circle())
        .padding(.trailing)
    }
}


