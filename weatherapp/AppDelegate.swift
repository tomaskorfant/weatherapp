//
//  AppDelegate.swift
//  weatherapp
//
//  Created by Korfant, Tomas on 18/06/2019.
//  Copyright © 2019 Korfant, Tomas. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        DispatchQueue.global().async {
             _ = City.all
        }
        window?.rootViewController = SearchCityCoordinator().configure()

        return true
    }

}

