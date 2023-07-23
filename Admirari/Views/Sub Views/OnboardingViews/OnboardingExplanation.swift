//
//  OnboardingExplanation.swift
//  Admirari
//
//  Created by Samuel James House on 12/08/2023.
//

import SwiftUI

struct OnboardingExplanation: View {
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                VStack(alignment: .leading) {
                    Text("Embrace").font(.title2).italic().bold().padding(.vertical, 10)
                    Text("Explore").font(.title2).italic().bold().padding(.vertical, 10)
                    Text("Discover").font(.title2).italic().bold().padding(.vertical, 10)
                }
                Text("the world around you").font(.title2).multilineTextAlignment(.leading)
                Spacer()
            }
        Spacer()
        }
        
    }
}

struct OnboardingExplanation_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingExplanation()
    }
}
