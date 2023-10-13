//
//  LocationView.swift
//  Admirari
//
//  Created by Samuel James House on 18/07/2023.
//

import SwiftUI

struct ArticleMarker: View {
    var mapVM: MapVM
    var location: WikipediaLocation
    var body: some View {
        
        VStack {
       Image(systemName: "w.circle")
                .foregroundColor(.black)
                .padding(2)
                .background(.white)
                .clipShape(Circle())
                   
        }.onTapGesture {
            mapVM.selecctedWikiLocation = location
            mapVM.showArticleDetails.toggle()
        }
    }
}

