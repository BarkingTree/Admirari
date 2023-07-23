//
//  OnboardingDefinition.swift
//  Admirari
//
//  Created by Samuel James House on 12/08/2023.
//

import SwiftUI

struct OnboardingDefinition: View {
    var body: some View {
        VStack {
            Spacer()
            HStack (alignment: .top) {
                Spacer()
                VStack (alignment: .trailing) {
                    Text("Admirari").font(.title).bold()
                    HStack {
                        Text("(verb)").font(.callout)
                    }
                }
                VStack(alignment: .leading) {
                    Text("1. To admire or respect")
                    Text("2. To regard with wonder")
                    Text("3. To be surprised at")
                }
            Spacer()
            }
            Spacer()
        }
    }
}

struct OnboardingDefinition_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingDefinition()
    }
}
