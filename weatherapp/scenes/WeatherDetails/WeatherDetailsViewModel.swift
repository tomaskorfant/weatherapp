//
//  WeatherDetailsViewModel.swift
//  weatherapp
//
//  Created by Korfant, Tomas on 25/06/2019.
//  Copyright © 2019 Korfant, Tomas. All rights reserved.
//

import RxSwift
import RxCocoa

final class WeatherDetailsViewModel: ViewModelType {

    private let weatherData: WeatherData
    private let coordinator: WeatherDetailsCoordinator

    init(weatherData: WeatherData, coordinator: WeatherDetailsCoordinator) {
        self.weatherData = weatherData
        self.coordinator = coordinator
    }

    func transform(input: Input) -> Output {
        let temperature = weatherData.main?.temp?.tempValue ?? "-"
        let city = weatherData.name ?? "-"
        let maxMinTemperature = "\(weatherData.main?.temp_min?.tempValue ?? "-") / \(weatherData.main?.temp_max?.tempValue ?? "-")"
        let sky = weatherData.weather?.first?.main ?? "-"

        let goBack = input.goBack
            .do(onNext: { [coordinator] in
                coordinator.goBack()
            })

        return Output(
            temperature: .just(temperature),
            city: .just(city),
            maxMinTemperature: .just(maxMinTemperature),
            sky: .just(sky),
            goBack: goBack
        )
    }

}

extension WeatherDetailsViewModel {

    struct Input {
        let goBack: Driver<Void>
    }

    struct Output {
        let temperature: Driver<String>
        let city: Driver<String>
        let maxMinTemperature: Driver<String>
        let sky: Driver<String>
        let goBack: Driver<Void>
    }

}

private extension Float {

    var tempValue: String {
        return "\(Int(self.rounded()))°"
    }
}
