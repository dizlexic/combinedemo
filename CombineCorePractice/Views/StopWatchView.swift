//
//  StopWatchView.swift
//  CombineCorePractice
//
//  Created by Daniel Moore on 9/19/23.
//

import SwiftUI

struct StopWatchView: View {
    @StateObject private var timer = StopWatchVM()
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Text("\(timer.minutes.formattedTwoDigits)")
                    .font(.system(size: 80))
                    .frame(width: 100)
                Text(":")
                    .font(.system(size: 80))
                Text("\(timer.seconds.formattedTwoDigits)")
                    .font(.system(size: 80))
                    .frame(width: 100)
                Text(":")
                    .font(.system(size: 80))
                Text("\(timer.deciseconds.formattedTwoDigits)")
                    .font(.system(size: 80))
                    .frame(width: 100)
            }
            Button {
                if timer.started {
                    timer.stop()
                } else {
                    timer.start()
                }
            } label: {
                Text(timer.started ? "Stop" : "Start")
                    .foregroundStyle(.white)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 16)
                    .frame(width: 100)
                    .background(timer.started ? Color.red : Color.green)
                    .cornerRadius(5.0)
            }
        }
    }
}

#Preview {
    StopWatchView()
}
