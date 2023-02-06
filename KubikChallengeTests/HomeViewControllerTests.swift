//
//  HomeViewControllerTests.swift
//  KubikChallengeTests
//
//  Created by nicolas sieiro on 06/02/2023.
//

import XCTest
@testable import KubikChallenge

@MainActor
class HomeViewControllerTests: XCTestCase {
    var sut: HomeViewController!
    var provider : HomeProviderProtocol!
    
    override func setUpWithError() throws {
        provider = HomeProviderMock()
        sut = HomeViewController()
        sut.presenter = HomePresenter(provider: provider, delegate: sut)
        sut.loadViewIfNeeded()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        provider = nil
    }
    
    func test_ValidateTableViewCellContent() {
        let tableView = sut.tableView
        let indexPath0 = IndexPath(item: 0, section: 0)
        
        let expLadingData = expectation(description: "loading")
        
        DispatchQueue.main.asyncAfter(deadline: .now()+1.0) {
            expLadingData.fulfill()
        }
        waitForExpectations(timeout: 1.0)
        
        guard let cell0 = sut.tableView(tableView, cellForRowAt: indexPath0) as? RestaurantCell else {
            XCTFail("The first position should be a RestaurantCell")
            return
        }

        XCTAssertNotNil(cell0.restTitleLabel.text)
        XCTAssertNotNil(cell0.restRatingLabel.text)
        XCTAssertNotNil(cell0.restImageView)
    }
    
}
