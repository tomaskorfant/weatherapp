//
//  WeatherDetailsCoordinator.swift
//  weatherapp
//
//  Created by Korfant, Tomas on 27/06/2019.
//  Copyright © 2019 Korfant, Tomas. All rights reserved.
//

import UIKit

protocol WeatherDetailsCoordinatorType {
    func start(rootViewController: UIViewController?, weatherData: WeatherData)
    func goBack()
}

final class WeatherDetailsCoordinator: WeatherDetailsCoordinatorType {

    private weak var rootViewController: UIViewController?

    func start(rootViewController: UIViewController?, weatherData: WeatherData) {
        self.rootViewController = rootViewController

        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "WeatherDetailsViewController") as? WeatherDetailsViewController else {
            return
        }
        viewController.viewModel = WeatherDetailsViewModel(
            weatherData: weatherData,
            coordinator: self
        )

        rootViewController?.present(viewController, animated: true, completion: nil)
    }

    func goBack() {
        rootViewController?.dismiss(animated: true, completion: nil)
    }

}
