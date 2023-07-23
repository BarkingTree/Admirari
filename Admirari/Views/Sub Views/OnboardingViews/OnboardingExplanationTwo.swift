//
//  OnboardingExplanation.swift
//  Admirari
//
//  Created by Samuel James House on 12/08/2023.
//

import SwiftUI

struct OnboardingExplanationTwo: View {
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            HStack {
                Spacer()
                Text("Embrace").font(.title2).italic().bold().padding(.vertical, 10)
                Text("Explore").font(.title2).italic().bold().padding(.vertical, 10)
                Text("Discover").font(.title2).italic().bold().padding(.vertical, 10)
                Spacer()
            }
            Text("Explore the world around through the wonder of Wikipedia. View what articles are nearby and explore the surrounding area.").font(.title3).padding(20)
            Spacer()
            
        }
       
        
        
    }
}

struct OnboardingExplanationTwo_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingExplanationTwo()
    }
}
