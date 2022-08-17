//
//  WeatherModel.swift
//  Clima
//
//  Created by Bryce Belgarde on 4/5/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let conditionID: Int
    let cityName: String
    let temp: Double
    
    var tempString: String {
        return String(format: "%.0f", temp)
    }
    
    var conditionName: String {
        switch conditionID {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        default:
            return "cloud"
        }
    }
    
}
