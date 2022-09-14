//
//  WeatherData.swift
//  Clima
//
//  Created by Muhammed Burkay Şendoğdu on 6.09.2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import UIKit

struct WeatherData: Codable{
    
    let name: String
    let main: Main
    let weather: [Weather]
}


struct Main: Codable{
    let temp: Double
    
}

struct Weather: Codable{
    let description: String
    let id: Int
}
