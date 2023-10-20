//
//  CurrentWeatherView.swift
//  CombineCorePractice
//
//  Created by Daniel Moore on 9/19/23.
//

import SwiftUI


struct WeatherView: View {
    @StateObject var weatherService = WeatherService()

    var body: some View {
        VStack {
            Text(weatherService.errorMessage)
                .font(.largeTitle)
            if let current = weatherService.current {
                VStack {
                    CurrentWeatherView(current: current)
                    List(weatherService.forecast) {
                        WeatherRow(weather: $0)
                    }
                    .listStyle(.plain)
                }
            }
        }
        .task {
            weatherService.load(latitude: 51.5074, longitude: 0.1278)
        }
    }
}

struct CurrentWeatherView: View {
    let current: Weather
    var body: some View {
        VStack(spacing: 28) {
            Text(current.time.formatted(date: .long, time: .standard))
            HStack {
                Image(systemName: current.icon.weatherIcon)
                    .font(.system(size: 98))
                Text("\(current.temperature.formatted)º")
                    .font(.system(size: 46))
            }
            Text("\(current.summary)")
        }
    }
}

struct WeatherRow: View {
    let weather: Weather
    var body: some View {
        HStack {
            Image(systemName: weather.icon.weatherIcon)
                .frame(width: 40)
                .font(.system(size: 28))
            VStack {
                Text(weather.summary)
                Text(weather.time.formatted(date: .long, time: .standard))
                    .font(.system(.footnote))
            }
            Spacer()
            Text("\(weather.temperature.formatted)º ")
                .frame(width: 40)
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    WeatherView()
}
