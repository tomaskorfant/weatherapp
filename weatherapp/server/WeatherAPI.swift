//
//  WeatherAPI.swift
//  weatherapp
//
//  Created by Korfant, Tomas on 19/06/2019.
//  Copyright © 2019 Korfant, Tomas. All rights reserved.
//

import Moya
import UIKit
import RxSwift

public protocol WeatherAPIType {
    func weather(id: Int) -> Single<WeatherData>
}

public class WeatherAPI: WeatherAPIType {

    private let provider: MoyaProvider<OpenWeatherMap>

    private static var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        activityIndicator.isHidden = true
        activityIndicator.startAnimating()
        UIApplication.shared.keyWindow?.addSubview(activityIndicator)
        return activityIndicator
    }()

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

        provider = MoyaProvider<OpenWeatherMap>(endpointClosure: endpointClosure, plugins: [
            NetworkLoggerPlugin(verbose: true),
            NetworkActivityPlugin(networkActivityClosure: { state, target in
                WeatherAPI.activityIndicator.isHidden = state == .ended
            }),
            AppidPlugin { appid }
            ])
    }

    public func weather(id: Int) -> Single<WeatherData> {
        return provider.rx
            .request(.weather(id))
            .map(WeatherData.self)
    }

}
