//
//  RootView.swift
//
//
//  Created by Martin on 01.10.2021.
//

import CitySearch
import InstanceProvider
import SwiftUI

public struct RootView: View {
    
    private let appStart: AppStart
    
    public init(appStart: AppStart) {
        self.appStart = appStart
    }
    
    public var body: some View {
        let instanceProvider: InstanceProvider = appStart.startApp()
        
        instanceProvider.resolve(CitySearchView.self)
    }
}
