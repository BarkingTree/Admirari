//
//  ContentView.swift
//  Admirari
//
//  Created by Samuel James House on 18/07/2023.
//

import SwiftUI
import MapKit
import CoreLocationUI

struct ContentView: View {
@StateObject var mapVM = MapVM()
    var body: some View {
        ZStack {
            switch mapVM.authorizationStatus {
            case .authorizedWhenInUse:
                // Display Map
                Map(
                    coordinateRegion: $mapVM.region,
                    interactionModes: MapInteractionModes.all,
                    showsUserLocation: true,
                    userTrackingMode: $mapVM.tracking,
                    annotationItems: mapVM.wikiLocations
                ) { location in
                    MapAnnotation(coordinate: location.coordinates) {
                        LocationMarker(mapVM: mapVM, location: location)
                    }
                }.ignoresSafeArea()
               
            case .restricted, .denied:
                // Link to settings
                VStack {
                    Text("Please enable location sharing")
                    Link("Application Settings", destination: URL(string: UIApplication.openSettingsURLString)!)
                }
            case .notDetermined:        // Authorization not determined yet.
                Text("Finding your location...")
                ProgressView()
            default:
                ProgressView()
            }
          
        VStack {
                Spacer()
                    HStack{
                        Spacer()
                        CurrentLocationBtn(mapVM: mapVM).disabled(mapVM.locationButtonDisabled)
                    }
                    HStack {
                        Spacer()
                        ShowNearbyBtn(mapVM: mapVM).disabled(mapVM.wikipediaStatus)
                        LocationListBtn(mapVM: mapVM)
                }
        }.sheet(isPresented: $mapVM.showDetails) {
            LocationDetail(mapVM: mapVM, wikipediaLocation: mapVM.selecctedWikiLocation)
        }.sheet(isPresented: $mapVM.showLocationList) {
            LocationList(mapVM: mapVM)
        }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
