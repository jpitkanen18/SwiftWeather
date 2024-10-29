//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Jese on 29.10.2024.
//

import Testing
@testable import WeatherApp

struct WeatherAppTests {

    @Test func example() async throws {
        let weatherAPI = WeatherAPI()
        #expect(weatherAPI.initFail == false)
    }

}
