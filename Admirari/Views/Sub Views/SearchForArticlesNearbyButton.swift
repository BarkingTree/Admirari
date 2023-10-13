//
//  AddLocation.swift
//  Admirari
//
//  Created by Samuel James House on 18/07/2023.
//

import SwiftUI

struct SearchForArticlesNearbyButton: View {
    @StateObject var mapVM: MapVM
    
    var body: some View {
        Spacer()
        Button {
            // Button disabled whilst waiting API to response
            mapVM.wikipediaLoadingState = .loading
            Task {
                await mapVM.fetchNearbyPlaces()
            }
        } label: {
            switch mapVM.wikipediaLoadingState {
            case .loading:
                ProgressView()
                    .frame(width: 30, height: 30)
                    .padding()
                    .background(.black.opacity(0.25))
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .font(.title)
            default:
                Image(systemName: "magnifyingglass")
                    .frame(width: 30, height: 30)
                    .padding()
                    .background(.black.opacity(mapVM.searchForArticlesButtonState() ? 0.25: 0.75))
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .font(.title)
            }
        }
    }
}
