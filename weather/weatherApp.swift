//
//  weatherApp.swift
//  weather
// Program bol vytvoreny v rámci kurzu na portali skillmea.sk
//  Created by crow on 20/03/2023.
//

import SwiftUI

@main
struct weatherApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.colorScheme, .dark) //dark mode
        }
    }
}
