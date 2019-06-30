//
//  ApplicationContext.swift
//  weatherapp
//
//  Created by Korfant, Tomas on 25/06/2019.
//  Copyright © 2019 Korfant, Tomas. All rights reserved.
//

import UIKit

protocol ApplicationContextType {
    associatedtype Gateway
    associatedtype UseCase

    var gateway: Gateway { get }
    var useCase: UseCase { get }
}

final class ApplicationContext: ApplicationContextType {

    static var shared = ApplicationContext()

    let gateway: Gateway
    let useCase: UseCase
    
    init () {
        gateway = Gateway(weatherApiProvider: WeatherAPI(appid: "7587eaff3affbf8e56a81da4d6c51d06"))
        useCase = UseCase(searchCityUseCase: SearchCityUseCase())
    }

}

extension ApplicationContext {
    
    struct Gateway {
        var weatherApiProvider: WeatherAPIType
    }

    struct UseCase {
        var searchCityUseCase: SearchCityUseCaseType
    }
    
}
