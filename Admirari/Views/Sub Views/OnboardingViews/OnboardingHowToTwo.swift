//
//  OnboardingExplanation.swift
//  Admirari
//
//  Created by Samuel James House on 12/08/2023.
//

import SwiftUI

struct OnboardingHowToTwo: View {
    @StateObject var mapVM: MapVM = MapVM()
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            
            HStack(spacing: 30.0) {
            
            Image(systemName: "magnifyingglass")
            .frame(width: 30, height: 30)
            .padding()
            .background(.black.opacity(0.75))
            .foregroundColor(.white)
            .font(.title)
            .clipShape(Circle())
               
                VStack(spacing: 20.0) {
                    Text("Maximum search radius 5000m").font(.title3).multilineTextAlignment(.leading)
                    Text("A maximum of 200 articles can be displayed at once").font(.title3).multilineTextAlignment(.leading)
                }
                Spacer()
                
            }
            
            HStack(spacing: 30.0) {
                
                Image(systemName: "list.bullet")
                .frame(width: 30, height: 30)
                .padding()
                .background(.black.opacity(0.75))
                .foregroundColor(.white)
                .font(.title)
                .clipShape(Circle())
               
                Text("View a list of nearby Wikipedia articles").font(.title3).multilineTextAlignment(.leading)
                Spacer()
                
            }
            
        Spacer()
        }.padding()
        
    }
}

struct OnboardingHowToTwo_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingHowToTwo()
    }
}
