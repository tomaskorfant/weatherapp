//
//  weatherappTests.swift
//  weatherappTests
//
//  Created by Korfant, Tomas on 18/06/2019.
//  Copyright © 2019 Korfant, Tomas. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa
import RxTest
@testable import weatherapp

class weatherappTests: XCTestCase {

    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!
    var useCase: SearchCityUseCaseType!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
        useCase = SearchCityUseCase()

        ApplicationContext.shared.gateway.weatherApiProvider = WeatherAPIStub(appid: "")
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSearchCityUseCase() {
        // 1
        let cityList = scheduler.createObserver(Bool.self)
        let searchSubject = PublishSubject<String>()

        // 2
        searchSubject.flatMap(useCase.search)
            .map { $0.isEmpty }
            .asDriver(onErrorDriveWith: .empty())
            .drive(cityList)
            .disposed(by: disposeBag)

        // 3
        scheduler.createColdObservable([
            .next(10, ""),
            .next(20, "Kosice"),
            .next(30, "Brat"),
            .next(40, "xxx")])
            .bind(onNext: searchSubject.onNext)
            .disposed(by: disposeBag)

        // 4
        scheduler.start()

        // 5
        XCTAssertEqual(cityList.events, [
            .next(10, true),
            .next(20, false),
            .next(30, false),
            .next(40, true)
            ])
    }

    func testSearchCityUseCase2() {
        // 1
        let cityList = scheduler.createObserver(Int.self)
        let searchSubject = PublishSubject<String>()

        // 2
        searchSubject.flatMap(useCase.search)
            .map { $0.count }
            .asDriver(onErrorDriveWith: .empty())
            .drive(cityList)
            .disposed(by: disposeBag)

        // 3
        scheduler.createColdObservable([
            .next(10, ""),
            .next(20, "Kosi"),
            .next(30, "Vienna"),
            .next(40, "xxx")])
            .bind(onNext: searchSubject.onNext)
            .disposed(by: disposeBag)

        // 4
        scheduler.start()

        // 5
        XCTAssertEqual(cityList.events, [
            .next(10, 0),
            .next(20, 10),
            .next(30, 13),
            .next(40, 0)
            ])
    }

    func testDataMaping() {
        // 1
        let weatherData = scheduler.createObserver(Int.self)
        let searchSubject = PublishSubject<String>()

        // 2
        searchSubject.flatMap(useCase.search)
            .map { $0.first }
            .filterNil()
            .flatMap(useCase.weather)
            .map { $0.id }
            .asDriver(onErrorDriveWith: .empty())
            .drive(weatherData)
            .disposed(by: disposeBag)

        // 3
        scheduler.createColdObservable([
            .next(10, ""),
            .next(20, "Kosi")])
            .bind(onNext: searchSubject.onNext)
            .disposed(by: disposeBag)

        // 4
        scheduler.start()

        // 5
        XCTAssertEqual(weatherData.events, [
            .next(20, 544123),
            ])
    }

}
