//
//  WeatherData.swift
//  weatherapp
//
//  Created by Korfant, Tomas on 19/06/2019.
//  Copyright © 2019 Korfant, Tomas. All rights reserved.
//

public struct WeatherData: Decodable {

    let coord: Coord?
    let weather: [Weather]?
    let base: String?
    let main: Main?
    let visibility: Int?
    let wind: Wind?
    let clouds: Clouds?
    let dt: Int?
    let sys: Sys?
    let timezone: Int?
    let id: Int?
    let name: String?
    let cod: Int?

}

extension WeatherData {

    public struct Coord: Decodable {

        let lon: Float
        let lat: Float

    }

    public struct Weather: Decodable {

        let id: Int?
        let main: String?
        let description: String?
        let icon: String?

    }

    public struct Main: Decodable {

        let temp: Float?
        let pressure: Float?
        let humidity: Float?
        let temp_min: Float?
        let temp_max: Float?

    }

    public struct Wind: Decodable {

        let speed: Float?
        let deg: Float?

    }

    public struct Clouds: Decodable {

        let all: Int?

    }

    public struct Sys: Decodable {

        let type: Int?
        let id: Int?
        let message: Float?
        let country: String?
        let sunrise: Int?
        let sunset: Int?

    }

}
