//
//  UtilTest.swift
//  GithubUsersUnitTests
//
//  Created by Ronit Chaurasia on 22/02/22.
//

import XCTest
@testable import GithubUsers

class UtilTest: XCTestCase {

    func testRoundOffForThousand() {
        let ans: String = Utilities.roundOff(45_855)
        XCTAssertEqual(ans, "45.8K")
    }

    func testRoundOffForMillion() {
        let ans: String = Utilities.roundOff(45_454_543)
        XCTAssertEqual(ans, "45.4M")
    }

    func testRoundOffForBillion() {
        let ans: String = Utilities.roundOff(45_454_897_897)
        XCTAssertEqual(ans, "45.4B")
    }
}

// MARK: Test for date
extension UtilTest{
    //MARK: Setup time accordingly everytime
    func testDateDifferenceForHour() throws {
        
        let date = Utilities.dateDifference(repoDate: "2022-02-25T12:00:11Z")
        XCTAssertEqual(date, "last updated 2 hours ago" )
    }
    
    func testDateDifferenceForMonths() throws {
        let date = Utilities.dateDifference(repoDate: "2021-12-22T21:25:11Z")
        XCTAssertEqual(date, "last updated 2 months ago" )
    }
    
    func testDateDifferenceForYears() throws {
        let date = Utilities.dateDifference(repoDate: "2021-01-22T21:25:11Z")
        XCTAssertEqual(date, "last updated an year ago" )
    }
}
