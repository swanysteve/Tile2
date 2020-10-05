//
//  UserSettings.swift
//  Tile 2
//
//  Created by Steve Swanson on 9/10/20.
//  Copyright © 2020 Steve Swanson. All rights reserved.
//
// As of 9/17/20 this class is unused

import Foundation
import Combine

class UserSettings: ObservableObject {
    @Published var colors: Int {
        didSet {
            UserDefaults.standard.set(colors, forKey: "Colors")
        }
    }
    @Published var width: Int {
        didSet {
            UserDefaults.standard.set(width, forKey: "Width")
        }
    }
    @Published var height: Int {
        didSet {
            UserDefaults.standard.set(height, forKey: "Height")
        }
    }
    @Published var highScores: [String: Int] {
        didSet {
            UserDefaults.standard.set(highScores, forKey: "HighScores")
        }
    }
    
    init() {
        self.colors = UserDefaults.standard.object(forKey: "Colors") as? Int ?? 3
        self.width = UserDefaults.standard.object(forKey: "Width") as? Int ?? 3
        self.height = UserDefaults.standard.object(forKey: "Height") as? Int ?? 3
        self.highScores = UserDefaults.standard.object(forKey: "HighScores") as? [String:Int] ?? [String: Int]()
    }
    
    // friendly accessors
    func keyFormat(_ width: Int, _ height: Int, _ colors: Int) -> String {
        return String(format: "[%d,%d,%d]", width, height, colors)
    }
    
    func getHighScore(width: Int, height: Int, colors: Int) -> Int {
        let key = keyFormat(width, height, colors)
        return highScores[key] ?? 0
    }
    
    func getHighScore() -> Int {
        let key = keyFormat(self.width, self.height, self.colors)
        return highScores[key] ?? 0
    }
    
    func setHighScore(score: Int, width: Int, height: Int, colors: Int) {
        let key = keyFormat(width, height, colors)
        highScores.updateValue(score, forKey: key)
    }
    func setHighScore(score: Int) {
        let key = keyFormat(self.width, self.height, self.colors)
        highScores.updateValue(score, forKey: key)
    }

}
