//
//  City.swift
//  weatherapp
//
//  Created by Korfant, Tomas on 26/06/2019.
//  Copyright © 2019 Korfant, Tomas. All rights reserved.
//

import Foundation

struct City: Decodable {

    static let all: [City] = {
        guard
            let path = Bundle.main.url(forResource: "citylist", withExtension: "json"),
            let countries = try? JSONDecoder().decode([City].self, from: Data(contentsOf: path))
            else { return [] }

        return countries
    }()

    let id: Int
    let name: String
    let country: String
    let coord: Coord

}

extension City {

    struct Coord: Decodable {
        let lon: Float
        let lat: Float
    }

}
