//
//  AppidPlugin.swift
//  weatherapp
//
//  Created by Korfant, Tomas on 24/06/2019.
//  Copyright © 2019 Korfant, Tomas. All rights reserved.
//

import Moya

public struct AppidPlugin: PluginType {

    public let appidClosure: () -> String

    public init(appidClosure: @escaping () -> String) {
        self.appidClosure = appidClosure
    }

    public func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var request = request
        request.url = request.url?.appending("appid", value: appidClosure())
        return request
    }

}
