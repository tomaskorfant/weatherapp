//
//  ViewModelType.swift
//  weatherapp
//
//  Created by Korfant, Tomas on 25/06/2019.
//  Copyright © 2019 Korfant, Tomas. All rights reserved.
//

protocol ViewModelType {

    associatedtype Input
    associatedtype Output

    func transform(input: Input) -> Output

}
