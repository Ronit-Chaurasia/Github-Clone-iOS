//
//  FetchRepoDataTest.swift
//  GithubUsersUnitTests
//
//  Created by Ronit Chaurasia on 22/02/22.
//

import XCTest
@testable import GithubUsers

class FetchRepoDataTest: XCTestCase, GitUserProfileDelegate {
    
    var viewModal: GitUserProfileViewModal!
    var expectation: XCTestExpectation!
    
    override func setUp() {
        super.setUp()
        let repository = MockData("CorrectRepoData")
        viewModal = GitUserProfileViewModal(repository: repository)
        viewModal.delegate = self
    }
    
    override func tearDown() {
        super.tearDown()
        viewModal = nil
    }
    
    // MARK: Test for Valid repo
    func testFetchRepoDataWithCorrectUser() {
        expectation = self.expectation(description: "Waiting for the repoUserData call to complete.")
        viewModal.fetchUserRepoData(user: "hello")
        waitForExpectations(timeout: 15)
    }
    
    func updateUIAfterFetchUserData() {
        
    }
    
    func updateRepoAfterFetchUserData() {
        XCTAssertNotNil(self.viewModal.repoList)
        XCTAssertEqual(viewModal.repoList.count, 2)
        self.expectation.fulfill()
    }
    
    func updateUIAfterUserNotFound() {
        
    }
}
