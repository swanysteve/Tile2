//
//  Tile_2Tests.swift
//  Tile 2Tests
//
//  Created by Steve Swanson on 9/5/20.
//  Copyright © 2020 Steve Swanson. All rights reserved.
//

import XCTest
@testable import Tile_2

class Tile_2Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        

        var b = Board(width: 3, height: 3, colors: 3)
        b[0,0] = .red
        b[0,1] = .yellow
        b[0,2] = .red
        b[1,0] = .yellow
        b[1,1] = .blue
        b[1,2] = .yellow
        b[2,0] = .yellow
        b[2,1] = .blue
        b[2,2] = .yellow
        var b3 = b
        XCTAssert(b3.markAdjacent(1,1) == 2)
        
        var b4 = b
        XCTAssert(b4.markAdjacent(1,1) == 2)
        b4.clearAllMarks()
        XCTAssert(b4.markAdjacent(0,1) == 1)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            for _ in 1...400 {
                var b = Board(width: 3, height: 3, colors: 3)
                XCTAssert(b.markAdjacent(1, 1) < 10)
                b.destroyAllMarked()
                b.tilesFallDown()
                b.tilesShiftLeft()
            }
        }
    }

}
