//
//  Weather_clean_archApp.swift
//  Weather-clean-arch
//
//  Created by Martin on 29.11.2021.
//

import AppStart
import SwiftUI

@main
struct MainApp: App {
    
    let appStart = AppStart()
    
    var body: some Scene {
        WindowGroup {
            RootView(appStart: appStart)
        }
    }
}
