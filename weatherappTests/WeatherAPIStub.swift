//
//  WeatherAPIStub.swift
//  weatherappTests
//
//  Created by Korfant, Tomas on 30/06/2019.
//  Copyright © 2019 Korfant, Tomas. All rights reserved.
//
import Moya
@testable import weatherapp

class WeatherAPIStub: WeatherAPIType {

    public let provider: MoyaProvider<OpenWeatherMap>

    init(appid: String) {
        let endpointClosure = { (target: OpenWeatherMap) -> Endpoint in
            let url = URL(target: target).absoluteString
            return Endpoint(
                url: url,
                sampleResponseClosure: { .networkResponse(200, target.sampleData) },
                method: target.method,
                task: target.task,
                httpHeaderFields: target.headers
            )
        }

        provider = MoyaProvider<OpenWeatherMap>(
            endpointClosure: endpointClosure,
            stubClosure: MoyaProvider.immediatelyStub,
            plugins: [
                NetworkLoggerPlugin(verbose: true),
                AppidPlugin { appid }
            ])
    }

}
