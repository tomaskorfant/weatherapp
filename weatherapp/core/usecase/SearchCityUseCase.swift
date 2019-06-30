//
//  SearchCityUseCase.swift
//  weatherapp
//
//  Created by Korfant, Tomas on 26/06/2019.
//  Copyright © 2019 Korfant, Tomas. All rights reserved.
//

import RxSwift
import RxCocoa

protocol SearchCityUseCaseType {
    func search(term: String) -> Observable<[City]>
    func weather(city: City) -> Observable<WeatherData>
}

final class SearchCityUseCase: SearchCityUseCaseType {

    func search(term: String) -> Observable<[City]> {
        return .just(City.all.filter { $0.name.localizedCaseInsensitiveContains(term) })
    }

    func weather(city: City) -> Observable<WeatherData> {
        return ApplicationContext.shared.gateway
            .weatherApiProvider
            .weather(id: city.id)
            .asObservable()
    }

}
