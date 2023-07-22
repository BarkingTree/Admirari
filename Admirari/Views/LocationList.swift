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
        Form {
        ForEach(mapVM.wikiLocations) { location in
           
                Text(location.name)
            }
        }
    }
}

