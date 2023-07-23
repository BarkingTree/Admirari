//
//  AdmirariApp.swift
//  Admirari
//
//  Created by Samuel James House on 18/07/2023.
//

import SwiftUI

@main
struct AdmirariApp: App {
    @AppStorage("isOnboarding") var isOnboarding: Bool = true
    var body: some Scene {
        WindowGroup {
            if isOnboarding {
                OnboardingOverview()
            } else {
                ContentView()
            }
        }
    }
}
