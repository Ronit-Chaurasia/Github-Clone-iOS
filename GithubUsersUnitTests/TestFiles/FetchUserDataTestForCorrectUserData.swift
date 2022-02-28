//
//  GithubUsersUnitTests.swift
//  GithubUsersUnitTests
//
//  Created by Ronit Chaurasia on 20/02/22.
//

import XCTest
@testable import GithubUsers

class FetchUserDataTestForCorrectUserData: XCTestCase, GitUserProfileDelegate {
   
    var viewModal: GitUserProfileViewModal!
    var expectation: XCTestExpectation!
    
    override func setUp() {
        super.setUp()
        let repository = MockData("CorrectUserData")
        viewModal = GitUserProfileViewModal(repository: repository)
        viewModal.delegate = self
    }
    
    override func tearDown() {
        super.tearDown()
        viewModal = nil
    }
    
    // MARK: Test for invalid user
    func testFetchUserDataWithCorrectUser() {
        expectation = self.expectation(description: "Waiting for the fetchUserData call to complete.")
        viewModal.fetchUserData(user: "hello")
        waitForExpectations(timeout: 10)
    }
    
    func updateUIAfterFetchUserData() {
        XCTAssertNotNil(self.viewModal.userData)
        XCTAssertEqual(viewModal.userPropertiesData.count, 4)
        XCTAssertEqual(viewModal.userPropertiesData, [67,50,11,43])
        self.expectation.fulfill()
    }
    
    func updateRepoAfterFetchUserData() {
        
    }
    
    func updateUIAfterUserNotFound() {
        
    }
}

class FetchUserDataTestForIncorrectUserData: XCTestCase, GitUserProfileDelegate {
    var viewModal: GitUserProfileViewModal!
    var expectation: XCTestExpectation!
    
    override func setUp() {
        super.setUp()
        let repository = MockData("IncorrectUserData")
        viewModal = GitUserProfileViewModal(repository: repository)
        viewModal.delegate = self
    }
    
    override func tearDown() {
        super.tearDown()
        viewModal = nil
    }
    
    // MARK: Test for invalid user
    func testFetchUserDataWithIncorrectUser() {
        expectation = self.expectation(description: "Waiting for the fetchUserData call to complete.")
        viewModal.fetchUserData(user: "hello")
        waitForExpectations(timeout: 10)
    }
    
    func updateUIAfterFetchUserData() {
        
    }
    
    func updateRepoAfterFetchUserData() {
        
    }
    
    func updateUIAfterUserNotFound() {
        XCTAssertNil(self.viewModal.userData)
        XCTAssertEqual(viewModal.userPropertiesData.count, 0)
        self.expectation.fulfill()
    }
}
