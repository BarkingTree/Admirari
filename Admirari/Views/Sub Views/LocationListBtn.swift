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
           
        }, label: {
            Image(systemName: "list.bullet")
        })
        .frame(width: 30, height: 30)
        .padding()
        .background(.black.opacity(mapVM.locationListDisabled ? 0.25 : 0.75))
        .foregroundColor(.white)
        .font(.title)
        .clipShape(Circle())
        .padding(.trailing)
      
    }
}


