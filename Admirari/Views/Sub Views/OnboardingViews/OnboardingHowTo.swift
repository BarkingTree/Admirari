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
            HStack {
                
                Image(systemName: "location")
                .frame(width: 30, height: 30)
                .padding()
                .background(.black.opacity(0.75))
                .foregroundColor(.white)
                .font(.title)
                .clipShape(Circle())
                
                Spacer()
                Text("Current location").font(.title3)
                Spacer()
                
            }
            HStack {
            
            Image(systemName: "magnifyingglass")
            .frame(width: 30, height: 30)
            .padding()
            .background(.black.opacity(0.75))
            .foregroundColor(.white)
            .font(.title)
            .clipShape(Circle())
                Spacer()
                Text("Search for Wikipedia articles nearby").font(.title3)
                Spacer()
                
            }
            HStack {
                
                Image(systemName: "list.bullet")
                .frame(width: 30, height: 30)
                .padding()
                .background(.black.opacity(0.75))
                .foregroundColor(.white)
                .font(.title)
                .clipShape(Circle())
                Spacer()
                Text("View a list of nearby Wikipedia articles").font(.title3)
                Spacer()
                
            }
            
        Spacer()
        }.padding()
        
    }
}

struct OnboardingHowTo_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingHowTo()
    }
}
