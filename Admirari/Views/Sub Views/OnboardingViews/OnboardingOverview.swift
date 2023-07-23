//
//  OnboardingView.swift
//  Admirari
//
//  Created by Samuel James House on 12/08/2023.
//

import SwiftUI

struct OnboardingOverview: View {
    @AppStorage("isOnboarding") var isOnboarding: Bool?
    var body: some View {
        VStack {
           
            Text("Welcome to Admirari").font(.largeTitle).bold().padding([.top], 50).multilineTextAlignment(.center)
            TabView {
                OnboardingDefinition().modifier(CardViewModifier())
                OnboardingExplanationTwo().modifier(CardViewModifier())
                OnboardingHowTo().modifier(CardViewModifier())
                
            }
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .always))
            
            Button(action: {
                isOnboarding = false
            }) {
                Text("Start").font(.title)
            }.buttonStyle(.borderedProminent)
                .padding(10)
            
        }
    }
    
    private struct CardViewModifier: ViewModifier {
        func body(content: Content) -> some View {
            content
              
                .background(Material.ultraThin)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .padding(.horizontal, 15)
                .padding(.vertical, 50)
               
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingOverview()
    }
}
