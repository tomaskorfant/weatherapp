//
//  String+Extension.swift
//  weatherapp
//
//  Created by Korfant, Tomas on 19/06/2019.
//  Copyright © 2019 Korfant, Tomas. All rights reserved.
//

extension String {

    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
}
