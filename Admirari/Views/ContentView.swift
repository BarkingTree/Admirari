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
                // Marker
               
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
                
              
                
                    switch mapVM.locationButtonDisabled {
                    case true:
                        EmptyView()
                    case false:
                        
                    Image(systemName: "magnifyingglass")
                   .ignoresSafeArea()
                }
                    
                
            case .restricted, .denied:
                // Link to settings
                VStack {
                    Text("Please allow access to your location so that nearby articles can be displayed").multilineTextAlignment(.center).padding()
                    Link("Application Settings", destination: URL(string: UIApplication.openSettingsURLString)!).padding()
                }
            case .notDetermined:
                // Authorization not determined yet.
                VStack {
                    Text("Finding your location...")
                    ProgressView()
                }
                
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
                        ShowNearbyBtn(mapVM: mapVM).disabled(mapVM.wikipediaLocationsBtnDisabled)
                        LocationListBtn(mapVM: mapVM).disabled(mapVM.locationButtonDisabled)
                }.padding(.bottom, 20)
        }.sheet(isPresented: $mapVM.showDetails) {
            LocationDetail(mapVM: mapVM, wikipediaLocation: mapVM.selecctedWikiLocation)
                .presentationDetents([.fraction(0.4)])
                
                
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
