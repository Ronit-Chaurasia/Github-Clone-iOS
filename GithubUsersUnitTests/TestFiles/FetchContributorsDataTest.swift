//
//  GithubUsersUnitTests.swift
//  GithubUsersUnitTests
//
//  Created by Ronit Chaurasia on 20/02/22.
//

import XCTest
@testable import GithubUsers

class FetchContributorDataTestForCorrectData: XCTestCase, ContributorsViewModalDelegate {

    var viewModal: ContributorsViewModal!
    var expectation: XCTestExpectation!
    
    override func setUp() {
        super.setUp()
        let repository = MockData("CorrectContributorsData")
        viewModal = ContributorsViewModal(contributors: repository)
        viewModal.delegate = self
    }
    
    override func tearDown() {
        super.tearDown()
        viewModal = nil
    }
    
    // MARK: Test for invalid user
    func testFetchUserDataWithCorrectData() {
        expectation = self.expectation(description: "Waiting for the fetchUserData call to complete.")
        viewModal.fetchUserContributorsData(user: "Hello", repo: "xyz")
        waitForExpectations(timeout: 10)
    }
    
    func updateContributorsAfterFetchUserData() {
        XCTAssertNotNil(self.viewModal.contributorsList)
        XCTAssertEqual(self.viewModal.contributorsList.count, 10)
        self.expectation.fulfill()
    }
    
    func updateContributorsAfterContributorsNotFound() {
        
    }

}

class FetchContributorDataTestForIncorrectData: XCTestCase, ContributorsViewModalDelegate {
    var viewModal: ContributorsViewModal!
    var expectation: XCTestExpectation!
    
    override func setUp() {
        super.setUp()
        let repository = MockData("IncorrectContributorsData")
        viewModal = ContributorsViewModal(contributors: repository)
        viewModal.delegate = self
    }
    
    override func tearDown() {
        super.tearDown()
        viewModal = nil
    }
    
    // MARK: Test for invalid user
    func testFetchUserDataWithCorrectUser() {
        expectation = self.expectation(description: "Waiting for the fetchUserData call to complete.")
        viewModal.fetchUserContributorsData(user: "Hello", repo: "xyz")
        waitForExpectations(timeout: 10)
    }
    
    func updateContributorsAfterFetchUserData() {
       
    }
    
    func updateContributorsAfterContributorsNotFound() {
        XCTAssertTrue(viewModal.errorInFetchingList)
        XCTAssertEqual(viewModal.contributorsList.count, 0)
        self.expectation.fulfill()
    }
}
