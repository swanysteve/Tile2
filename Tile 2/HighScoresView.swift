//
//  HighScoresView.swift
//  Tile 2
//
//  Created by Steve Swanson on 9/10/20.
//  Copyright © 2020 Steve Swanson. All rights reserved.
//

import SwiftUI

struct HighScoresView: View {
    
    @ObservedObject var model: Model

    var body: some View {
        NavigationView() {
            VStack() {
                Spacer()
                Text("High score \(model.highScore)")
                    .navigationBarTitle("Tile 2 High Scores", displayMode: .inline)
                Text("(for \(model.width) x \(model.height) with \(model.colors) colors)")
                    .font(.footnote)
                Spacer()
                Button("Reset", action: { self.model.highScore = 0 })
                Spacer()
            }
        }
    }
}

struct HighScoresView_Previews: PreviewProvider {
    static var previews: some View {
        HighScoresView(model: Model(undoManager: UndoManager()))
    }
}
