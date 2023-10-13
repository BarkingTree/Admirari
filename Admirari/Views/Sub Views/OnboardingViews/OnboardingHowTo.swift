//
//  OnboardingExplanation.swift
//  Admirari
//
//  Created by Samuel James House on 12/08/2023.
//

import SwiftUI

struct OnboardingHowTo: View {
    @StateObject var mapVM: MapVM = MapVM()
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            HStack(spacing: 10.0) {
                
                Image(systemName: "location")
                .frame(width: 30, height: 30)
                .padding()
                .background(.black.opacity(0.75))
                .foregroundColor(.white)
                .font(.title)
                .clipShape(Circle())
                
                
                Text("Current location").font(.title3).multilineTextAlignment(.leading)
                Spacer()
                
            }
            HStack(spacing: 10.0) {
            
            Image(systemName: "magnifyingglass")
            .frame(width: 30, height: 30)
            .padding()
            .background(.black.opacity(0.75))
            .foregroundColor(.white)
            .font(.title)
            .clipShape(Circle())
               
                VStack(alignment: .leading) {
                    Text("View nearby wikipedia articles").font(.title3).multilineTextAlignment(.leading)
                    
                }
                
                Spacer()
                
            }
            
            HStack(spacing: 10.0) {
                
                Image(systemName: "list.bullet")
                .frame(width: 30, height: 30)
                .padding()
                .background(.black.opacity(0.75))
                .foregroundColor(.white)
                .font(.title)
                .clipShape(Circle())
               
                Text("List of nearby articles").font(.title3).multilineTextAlignment(.leading)
                Spacer()
                
            }
            
        Spacer()
            Text("Maximum search radius 5000m. Search radius will alter automatically depending on zoom level. Up to 200 articles can be displayed at once. If more than 200 articles are present in the searched area only the closest will be displayed.").font(.caption)
        }.padding()
        
    }
}

struct OnboardingHowTo_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingHowTo()
    }
}
