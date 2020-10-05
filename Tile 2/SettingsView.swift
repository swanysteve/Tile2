//
//  SettingsView.swift
//  Tile 2
//
//  Created by Steve Swanson on 9/9/20.
//  Copyright © 2020 Steve Swanson. All rights reserved.
//

import SwiftUI


struct SettingsView: View {
    
    @ObservedObject var model: Model

    var body: some View {
        
        NavigationView() {
            VStack {
                Stepper("Width: \(model.width)", value: $model.width, in: 2...20)
                    .padding()
                Stepper("Height: \(model.height)", value: $model.height, in: 2...20)
                    .padding()
                Stepper("Colors: \(model.colors)", value: $model.colors, in: 2...8)
                    .padding()
            }
            .navigationBarTitle("Tile 2 Settings", displayMode: .inline)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(model: Model(undoManager: UndoManager()))
    }
}
