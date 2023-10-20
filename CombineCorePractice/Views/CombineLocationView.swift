//
//  CombineLocationView.swift
//  CombineCorePractice
//
//  Created by Daniel Moore on 9/19/23.
//

import SwiftUI

struct CombineLocationView: View {
    @StateObject var locationVM: CombineLocationVM = CombineLocationVM()
    
    var body: some View {
        Group {
            if locationVM.thereIsAnError {
                Text("Location Service terminated with error: \(locationVM.errorMessage)")
            } else {
                Text("Status: \(locationVM.statusDescription)")
                HStack {
                    Text("Latitude \(locationVM.latitude)")
                    Text("Longitude \(locationVM.longitude)")
                }
            }
        }
        .padding(.horizontal, 24)
        .task {
            print("running task :D")
            locationVM.startUpdating()
        }
    }
}

#Preview {
    CombineLocationView()
}
