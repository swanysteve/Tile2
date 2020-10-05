//
//  Tile2Button.swift
//  Tile 2
//
//  Created by Steve Swanson on 9/5/20.
//  Copyright © 2020 Steve Swanson. All rights reserved.
//

import SwiftUI

struct Tile2Button: View {
    
    @Binding var background:Color
    var body: some View {
        Button(action: {}) {
            Rectangle()
                .foregroundColor(background)
                .cornerRadius(10)
                .frame(width: 100, height: 100)
        }
    }
}

struct Tile2Button_Previews: PreviewProvider {
    static var previews: some View {
        Tile2Button(background: Binding.constant(Color.red))
    }
}
