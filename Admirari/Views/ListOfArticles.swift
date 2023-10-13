//
//  LocationLust.swift
//  Admirari
//
//  Created by Samuel James House on 22/07/2023.
//

import SwiftUI

struct ListOfArticles: View {
    @StateObject var mapVM: MapVM
    @State private var searchText = ""
    @State private var sortBy = true
    
    var searchResults: [WikipediaLocation] {
        if searchText.isEmpty {
            return mapVM.wikiLocations
        } else {
            return mapVM.wikiLocations.filter { $0.name.lowercased().contains(searchText) }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                List(searchResults) { location in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(location.name)
                            Text("\(location.distance , specifier: "%.0f")m")
                        }
                        Spacer()
                        Link(destination: location.url, label: {
                            Image(systemName: "safari")
                        })
                        
                    }
                }.searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            }
            .navigationTitle(" \(mapVM.wikiLocations.count) Nearby Articles")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button {
                        switch sortBy {
                        case true:
                            mapVM.wikiLocations.sort { $1.distance < $0.distance }
                            sortBy.toggle()
                        case false:
                            mapVM.wikiLocations.sort { $0.distance < $1.distance }
                            sortBy.toggle()
                        }
                        
                    } label: {
                        switch sortBy {
                        case true:
                            Image(systemName: "arrow.down.circle")
                        case false:
                            Image(systemName: "arrow.up.circle")
                        }
                        
                    }
                }
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        Button {
                            mapVM.showListOfArticles.toggle()
                        } label: {
                            Text("Cancel")
                        }
                   
                }

            }
        }
    }
  
    
}

struct LocationListView_Previews: PreviewProvider {
    static var previews: some View {
        ListOfArticles(mapVM: MapVM())
    }
}
