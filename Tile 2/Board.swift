//
//  Board.swift
//  Tile 2
//
//  Created by Steve Swanson on 9/6/20.
//  Copyright © 2020 Steve Swanson. All rights reserved.
//

import SwiftUI

struct Board {
    
    let MAXWIDTH = 20
    let MAXHEIGHT = 20
    var width: Int
    var height: Int
    var numcolors: Int
    var board: [[BoardCell]] = []

    init(width x: Int, height y: Int, colors: Int) {
        self.width = x
        self.height = y
        self.numcolors = colors
        assert(x <= MAXWIDTH && x > 0, "width out of range")
        assert(y <= MAXWIDTH && y > 0, "height out of range")
        board = Array(repeating: Array(repeating: BoardCell(mark: false, color: Color.yellow), count: MAXWIDTH), count: MAXHEIGHT)
        self.new()
    }
    
    func indexIsValid(x: Int, y: Int) -> Bool {
        return x >= 0 && x < width && y >= 0 && y < height
    }
    
    func int2color(_ n: Int) -> Color {
        switch (n) {
        case 0: return Color.red;
        case 1: return Color.yellow;
        case 2: return Color.blue;
        case 3: return Color.green;
        case 4: return Color.orange;
        case 5: return Color.pink;
        case 6: return Color.purple;
        case 7: return Color.black;
        default: return Color.white;
        }
    }
    
    mutating func new() {
        for x in 0...MAXWIDTH-1 {
            for y in 0...MAXHEIGHT-1 {
                board[x][y].color = int2color(Int.random(in: 0...numcolors-1))
            }
        }
    }
    
    mutating func clearAllMarks() {
        for x in 0...width-1 {
            for y in 0...height-1 {
                board[x][y].mark = false
            }
        }
    }
    
    mutating func markAdjacent(_ x: Int, _ y: Int) -> Int {
        assert(!board[x][y].mark)
        board[x][y].mark = true
        
        var totalMarked = 1
        let thisColor = board[x][y].color
        
        if (thisColor == Color.clear) {
            return 0
        }
        
        if (x > 0 && board[x-1][y].color == thisColor && !board[x-1][y].mark) {
            totalMarked += markAdjacent(x-1, y)
        }
        if (x < width-1 && board[x+1][y].color == thisColor && !board[x+1][y].mark) {
            totalMarked += markAdjacent(x+1, y)
        }
        if (y > 0 && board[x][y-1].color == thisColor && !board[x][y-1].mark) {
            totalMarked += markAdjacent(x, y-1)
        }
        if (y < height-1 && board[x][y+1].color == thisColor && !board[x][y+1].mark) {
            totalMarked += markAdjacent(x, y+1)
        }
        
        return totalMarked
    }
    
    mutating func destroyAllMarked() {
        for x in 0...width-1 {
            for y in 0...height-1 {
                if (board[x][y].mark) {
                    board[x][y].color = Color.clear
                }
            }
        }
    }

    mutating func tilesFallDown() {
        for x in 0...width-1 {
            for y in 0...height-2 {
                if (board[x][y].color == Color.clear) {
                    // find non-clear row
                    var n = y+1
                    while n < height && board[x][n].color == Color.clear {
                        n += 1
                    }
                    if (n < height) {
                        board[x][y] = board[x][n]
                        board[x][n].color = Color.clear
                    }
                }
            }
        }
    }

    func isColumnClear(_ x: Int) -> Bool {
        for y in 0...height-1 {
            if (board[x][y].color != Color.clear) {
                return false
            }
        }
        return true
    }
    
    mutating func tilesShiftLeft() {
        for x in 0...width-2 {
            if (isColumnClear(x)) {
                // find non-clear column
                var n = x+1
                while n < width && isColumnClear(n) {
                    n += 1
                }
                if (n < width) {
                    for y in 0...height-1 {
                        board[x][y] = board[n][y]
                        board[n][y].color = Color.clear
                    }
                }
            }
        }
    }

    func remainingTiles() -> Int {
        var count = 0
        for x in 0...width-1 {
            for y in 0...height-1 {
                if (board[x][y].color != Color.clear) {
                    count += 1
                }
            }
        }
        return count
    }

    // subscript shortcut, see https://docs.swift.org/swift-book/LanguageGuide/Subscripts.html
    subscript(x: Int, y: Int) -> Color {
        get {
            assert(indexIsValid(x: x, y: y), "Index out of range")
            return board[x][y].color
        }
        set {
            assert(indexIsValid(x: x, y: y), "Index out of range")
            board[x][y].color = newValue
        }
    }
}
