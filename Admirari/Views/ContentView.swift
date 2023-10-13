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
                // If location is authorised display Map.
                Map(position:  $mapVM.position)
                {
                // Display user location
                UserAnnotation()
                // Iterate through wikipedia articles and display annotations on the map
                    ForEach(mapVM.wikiLocations) { location in
                        
                        Annotation(location.name, coordinate: location.coordinates, anchor: .zero) {
                            ArticleMarker(mapVM: mapVM, location: location)
                            }.annotationTitles(.hidden)
                        }
                        
                    // Mark search location and overlay a circle of the radius that has been searched
                    if let lastSearchLocation = mapVM.lastSearchLocation {
                    Marker(" Search Radius \(mapVM.lastSearchRadius!, specifier: "%.0f")m \(lastSearchLocation.latitude) | \(lastSearchLocation.longitude)", systemImage: "magnifyingglass", coordinate: lastSearchLocation).tint(.blue)
                    MapCircle(center: lastSearchLocation, radius: mapVM.lastSearchRadius!).mapOverlayLevel(level: .aboveRoads).foregroundStyle(.blue.opacity(0.15)).stroke(lineWidth: 10)
                    }
                }
                    
                    // Map Controls
                    .mapControls({
                        MapUserLocationButton().mapControlVisibility(.hidden)
                        MapCompass().mapControlVisibility(.automatic)
                        MapScaleView(anchorEdge: .leading).mapControlVisibility(.automatic)
                    })
                    
                    // Customise Map Style
                    .mapStyle(.standard(elevation: .flat, emphasis: .automatic, pointsOfInterest: .excludingAll, showsTraffic: false))
                    
                    // On change in Map Position update mapVM region to ensure any API calls are using the correct location. This is new in iOS 17
                    .onMapCameraChange(frequency: .continuous) { mapCameraUpdateContext in
                        mapVM.region = mapCameraUpdateContext.region
                    }
                  
                    
                
            case .restricted, .denied:
                // Link to settings
                VStack {
                    Text("Please allow access to your location so that wikipedia articles nearby can be displayed").multilineTextAlignment(.center).padding()
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
                    GetCurrentLocationButton(mapVM: mapVM).disabled(mapVM.getCurrentLocationButtonState)
                }
                HStack {
                    Spacer()
                    SearchForArticlesNearbyButton(mapVM: mapVM).disabled(mapVM.searchForArticlesButtonState())
                    ShowListOfArticlesButton(mapVM: mapVM).disabled(mapVM.listOfArticlesButtonState)
            }
            
        }
        .padding(.bottom)
        .ignoresSafeArea(.all)
        .sheet(isPresented: $mapVM.showArticleDetails) {
            ArticleDetails(mapVM: mapVM, wikipediaLocation: mapVM.selecctedWikiLocation)
                .presentationBackgroundInteraction(.enabled)
                .presentationDetents([.fraction(0.2)])
                .presentationBackground(.regularMaterial)
                
                
                
        }.sheet(isPresented: $mapVM.showListOfArticles) {
            ListOfArticles(mapVM: mapVM)
            .presentationBackground(.ultraThickMaterial)
        }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
