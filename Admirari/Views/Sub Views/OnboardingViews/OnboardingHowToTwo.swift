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
            HStack {
                
                Image(systemName: "location")
                .frame(width: 30, height: 30)
                .padding()
                .background(.black.opacity(0.25))
                .foregroundColor(.white)
                .font(.title)
                .clipShape(Circle())
                Spacer()
                Text("Already showing current location").font(.title3)
                Spacer()
                
            }
            HStack {
            
            Image(systemName: "eye")
            .frame(width: 30, height: 30)
            .padding()
            .background(.black.opacity(0.25))
            .foregroundColor(.white)
            .font(.title)
            .clipShape(Circle())
                Spacer()
                Text("Zoom in to enable search").font(.title3)
                Spacer()
                
            }
            HStack {
                
                Image(systemName: "list.bullet")
                .frame(width: 30, height: 30)
                .padding()
                .background(.black.opacity(0.25))
                .foregroundColor(.white)
                .font(.title)
                .clipShape(Circle())
                Spacer()
                Text("No list of articles available").font(.title3)
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
