//
//  HomePresenterTests.swift
//  KubikChallengeTests
//
//  Created by nicolas sieiro on 06/02/2023.
//

import XCTest
@testable import KubikChallenge

@MainActor class HomePresenterTests: XCTestCase {

    var sut: HomePresenter!
    var sutDelegate: HomeViewMock!
    var providerMock: HomeProviderMock!
    var timeOut: TimeInterval = 2.0
    
    @MainActor override func setUpWithError() throws {
        sutDelegate = HomeViewMock()
        providerMock = HomeProviderMock()
        sut = HomePresenter(provider: providerMock, delegate: sutDelegate)
    }

    override func tearDownWithError() throws {
        sutDelegate = nil
        providerMock = nil
        sut = nil
    }

    func test_GetRestaurants() async {
        await sut.getRestaurants()
        XCTAssertTrue(!sut.restaurantList.isEmpty)
    }
    
    func test_GetRestaurants_ShouldFail() {
        sutDelegate = HomeViewMock()
        providerMock = HomeProviderMock()
        providerMock.throwError = true
        sutDelegate.expShowError = expectation(description: "loading")
        
        sut = HomePresenter(provider: providerMock, delegate: sutDelegate)
        
        Task {
            await sut.getRestaurants()
        }
        
        waitForExpectations(timeout: timeOut)
        
        XCTAssertTrue(sutDelegate.showErrorWasCalled)
        
    }

}

class HomeViewMock: HomeViewProtocol {
    var showErrorWasCalled = false
    var expShowError: XCTestExpectation?
    
    func showError(_ error: String) {
        showErrorWasCalled = true
        expShowError?.fulfill()
    }
    
    func getData(list: [Item]) {}
}
