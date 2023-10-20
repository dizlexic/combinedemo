//
//  ContentView.swift
//  CombineCorePractice
//
//  Created by Daniel Moore on 9/19/23.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        VStack {
            CombineLocationView()
            StopWatchView()
            SignupView()
            WeatherView()
        }
    }
}

#Preview {
    ContentView()
}
