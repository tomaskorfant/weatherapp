//
//  SearchCityViewModel.swift
//  weatherapp
//
//  Created by Korfant, Tomas on 25/06/2019.
//  Copyright © 2019 Korfant, Tomas. All rights reserved.
//

import RxSwift
import RxCocoa
import RxOptional

final class SearchCityViewModel: ViewModelType {

    private let useCase: SearchCityUseCaseType
    private let coordinator: SearchCityCoordinatorType

    init(useCase: SearchCityUseCaseType, coordinator: SearchCityCoordinatorType) {
        self.useCase = useCase
        self.coordinator = coordinator
    }

    func transform(input: Input) -> Output {
        let cities = input.searchCity
            .filterNil()
            .debounce(RxTimeInterval.milliseconds(300))
            .flatMap { [useCase] term -> Driver<[City]> in
                guard term.count > 2 else { return .just([]) }
                return useCase.search(term: term).asDriver(onErrorDriveWith: .empty())
        }

        let showDetails = input.selectedCity
            .flatMap({ [useCase, coordinator] city in
                useCase.weather(city: city)
                    .do(onNext: coordinator.showDetailWeather(weatherData:))
                    .asDriver(onErrorDriveWith: .empty())
            })
            .map { _ in return }

        return Output(cities: cities, showDetails: showDetails)
    }

}

extension SearchCityViewModel {

    struct Input {
        var searchCity: Driver<String?>
        var selectedCity: Driver<City>
    }

    struct Output {
        var cities: Driver<[City]>
        var showDetails: Driver<Void>
    }

}
