//
//  SearchCityCoordinator.swift
//  weatherapp
//
//  Created by Korfant, Tomas on 26/06/2019.
//  Copyright © 2019 Korfant, Tomas. All rights reserved.
//

import UIKit

protocol SearchCityCoordinatorType {
    func configure() -> SearchCityViewController?
    func showDetailWeather(weatherData: WeatherData)
}

final class SearchCityCoordinator: SearchCityCoordinatorType {

    private weak var searchCityViewController: SearchCityViewController?

    func configure() -> SearchCityViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "SearchCityViewController") as? SearchCityViewController else {
            return nil
        }
        let viewModel = SearchCityViewModel(
            useCase: ApplicationContext.shared.useCase.searchCityUseCase,
            coordinator: self
        )
        viewController.viewModel = viewModel
        self.searchCityViewController = viewController

        return viewController
    }

    func showDetailWeather(weatherData: WeatherData) {
        WeatherDetailsCoordinator().start(rootViewController: searchCityViewController, weatherData: weatherData)
    }

}
