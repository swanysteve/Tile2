//
//  Model.swift
//  Tile 2
//
//  Created by Steve Swanson on 9/17/20.
//  Copyright © 2020 Steve Swanson. All rights reserved.
//

import Foundation

// format for keys of high scores in dictionary
func keyFormat(_ width: Int, _ height: Int, _ colors: Int) -> String {
    return String(format: "[%d,%d,%d]", width, height, colors)
}

class Model: ObservableObject {
    
    @Published var board: Board = Board(width: 3, height: 3, colors: 3)  // fixed in init()
    @Published var score: Int = 0
    @Published var winner: String = ""
    
    @Published var colors: Int {
        didSet {
            UserDefaults.standard.set(colors, forKey: "Colors")
            self.new()
            highScore = self.getHighScore()
        }
    }
    @Published var width: Int {
        didSet {
            UserDefaults.standard.set(width, forKey: "Width")
            self.new()
            highScore = self.getHighScore()
        }
    }
    @Published var height: Int {
        didSet {
            UserDefaults.standard.set(height, forKey: "Height")
            self.new()
            highScore = self.getHighScore()
        }
    }
    @Published var highScores: [String: Int] {
        didSet {
            UserDefaults.standard.set(highScores, forKey: "HighScores")
        }
    }
    @Published var highScore: Int {
        didSet {
            self.setHighScore(score: highScore)
        }
    }

    let undoManager: UndoManager

    init(undoManager: UndoManager) {
        self.undoManager = undoManager
        
        let colors = UserDefaults.standard.object(forKey: "Colors") as? Int ?? 3
        let width = UserDefaults.standard.object(forKey: "Width") as? Int ?? 3
        let height = UserDefaults.standard.object(forKey: "Height") as? Int ?? 3
        let highScores = UserDefaults.standard.object(forKey: "HighScores") as? [String:Int] ?? [String: Int]()
        
        self.height = height
        self.colors = colors
        self.width = width
        self.highScores = highScores
        self.highScore = highScores[keyFormat(width, height, colors)] ?? 0  // duplicates logic in getHighScore()
        
        self.board = Board(width: width, height: height, colors: colors); // wrong?
    }
        
    func getHighScore() -> Int {
        let key = keyFormat(self.width, self.height, self.colors)
        return highScores[key] ?? 0
    }
    
    func setHighScore(score: Int) {
        let key = keyFormat(self.width, self.height, self.colors)
        highScores.updateValue(score, forKey: key)
    }
    
    func tap(_ x: Int, _ y: Int) {
        let thisScore = self.board.markAdjacent(x, y)
        if (thisScore > 1) {
            let oldBoard = self.board
            let oldScore = self.score
            
            undoManager.registerUndo(withTarget: self) { target in
                target.board = oldBoard
                target.score = oldScore
                target.board.clearAllMarks()
            }

            self.score += (thisScore-1)*(thisScore-1)
            self.board.destroyAllMarked()
            self.board.tilesFallDown()
            self.board.tilesShiftLeft()
            self.board.clearAllMarks()
            if (self.board.remainingTiles() == 0) {
                self.score += self.width*self.height
                if (self.score > self.highScore) {
                    self.highScore = self.score
                    self.winner = "High Score!"
                }
                else {
                    self.winner = "Winner!"
                }
            }
        }
        board.clearAllMarks()
    }
    
    func new() {
        self.undoManager.removeAllActions()
        self.board = Board(width: self.width, height: self.height, colors: self.colors); // wrong?
        self.score = 0
        self.winner = ""
    }
    
    func undo() {
        self.undoManager.undo()
        self.winner = ""
    }

}

