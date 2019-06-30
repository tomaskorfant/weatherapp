//
//  SearchCityViewController.swift
//  weatherapp
//
//  Created by Korfant, Tomas on 18/06/2019.
//  Copyright © 2019 Korfant, Tomas. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class SearchCityViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    private let bag = DisposeBag()
    var viewModel: SearchCityViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateAppearance()
        bindViewController()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    private func updateAppearance() {
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = .white
    }

    private func bindViewController() {
        guard let viewModel = viewModel else { return }
        let input = SearchCityViewModel.Input(
            searchCity: searchBar.rx.text.asDriver(),
            selectedCity: tableView.rx.modelSelected(City.self).asDriver()
        )
        let output = viewModel.transform(input: input)

        output.cities.drive(tableView.rx.items) { table, index, model in
            let cell = table.dequeueReusableCell(withIdentifier: "cityCell", for: IndexPath(row: index, section: 0))
            cell.textLabel?.text = model.name
            return cell
            }
            .disposed(by: bag)

        output.showDetails.drive().disposed(by: bag)
    }

}
