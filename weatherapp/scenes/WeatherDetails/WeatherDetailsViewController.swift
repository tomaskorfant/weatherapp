//
//  WeatherDetailsViewController.swift
//  weatherapp
//
//  Created by Korfant, Tomas on 25/06/2019.
//  Copyright © 2019 Korfant, Tomas. All rights reserved.
//

import UIKit
import RxSwift

class WeatherDetailsViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var maxMinTemLabel: UILabel!
    @IBOutlet weak var skyLabel: UILabel!

    private let bag = DisposeBag()
    var viewModel: WeatherDetailsViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateAppearance()
        bindViewController()
        accessibilityInit()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    private func updateAppearance() {
        backButton.imageView?.transform = CGAffineTransform.init(scaleX: -1, y: -1)
    }

    func accessibilityInit () {
        backButton.accessibilityIdentifier = WeatherDetailsAccessibilityID.backButton
        tempLabel.accessibilityIdentifier = WeatherDetailsAccessibilityID.tempLabel
        cityLabel.accessibilityIdentifier = WeatherDetailsAccessibilityID.cityLabel
        maxMinTemLabel.accessibilityIdentifier = WeatherDetailsAccessibilityID.maxMinTempLabel
        skyLabel.accessibilityIdentifier = WeatherDetailsAccessibilityID.skyLabel
    }

    private func bindViewController() {
        let input = WeatherDetailsViewModel.Input(goBack: backButton.rx.tap.asDriver())
        let output = viewModel?.transform(input: input)

        output?.temperature.drive(tempLabel.rx.text).disposed(by: bag)
        output?.city.drive(cityLabel.rx.text).disposed(by: bag)
        output?.maxMinTemperature.drive(maxMinTemLabel.rx.text).disposed(by: bag)
        output?.sky.drive(skyLabel.rx.text).disposed(by: bag)
        output?.goBack.drive().disposed(by: bag)
    }

}
