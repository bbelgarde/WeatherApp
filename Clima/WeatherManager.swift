//
//  WeatherManager.swift
//  Clima
//
//  Created by Bryce Belgarde on 4/1/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=09e3d3d0ee8661e59c644757153a1cee&units=imperial"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        perfromRequest(urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        perfromRequest(urlString)
    }
    
    func perfromRequest(_ urlString: String) {        //this is where code talks to internet
        // 1. Create a URL
        if let url = URL(string: urlString) {
            // 2. Create a URLSession
            let session = URLSession(configuration: .default)
            // 3. Give the session a task
            let task = session.dataTask(with: url) { (data, response, error) in     //using closures
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    print("\(safeData)")
                    if let weather = parseJSON(safeData) {
                        DispatchQueue.main.async {
                            delegate?.didUpdateWeather(self, weather: weather)
                        }        // delegate, cannot perform  ui updates in completion func w/o dispatch queue
                    }
                }
            }
            // 4. Start the task
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {      // (_ name: type) uses external and internal name, reading ease
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionID: id, cityName: name, temp: temp)
            return weather
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }

}
