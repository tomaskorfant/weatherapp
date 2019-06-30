//
//  OpenWeatherMap.swift
//  weatherapp
//
//  Created by Korfant, Tomas on 19/06/2019.
//  Copyright © 2019 Korfant, Tomas. All rights reserved.
//

import Moya

public enum OpenWeatherMap {
    case weather(Int)
}

extension OpenWeatherMap: TargetType {

    public var baseURL: URL { return URL(string: "http://api.openweathermap.org/data/2.5")! }

    public var path: String {
        switch self {
        case .weather:
            return "/weather"
        }
    }

    public var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }

    public var task: Task {
        switch self {
        case .weather(let cityID):
            return .requestParameters(parameters: ["id": cityID, "units": "metric"], encoding: URLEncoding.default)
        }
    }

    public var sampleData: Data {
        switch self {
        case .weather(let cityID):
            return "{\"coord\":{\"lon\":15.53,\"lat\":50.18},\"weather\":[{\"id\":520,\"main\":\"Rain\",\"description\":\"light intensity shower rain\",\"icon\":\"09d\"}],\"base\":\"stations\",\"main\":{\"temp\":296.04,\"pressure\":1010,\"humidity\":50,\"temp_min\":293.71,\"temp_max\":299.26},\"visibility\":10000,\"wind\":{\"speed\":4.1,\"deg\":280},\"clouds\":{\"all\":40},\"dt\":1560964085,\"sys\":{\"type\":1,\"id\":6844,\"message\":0.0076,\"country\":\"CZ\",\"sunrise\":1560912436,\"sunset\":1560971460},\"timezone\":7200,\"id\":\(cityID),\"name\":\"Kosice\",\"cod\":200}".data(using: String.Encoding.utf8)!
        }
    }

    public var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }

}
