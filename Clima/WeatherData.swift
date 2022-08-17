//
//  WeatherData.swift
//  Clima
//
//  Created by Bryce Belgarde on 4/5/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]        //json stores an array of weather items here
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
}
