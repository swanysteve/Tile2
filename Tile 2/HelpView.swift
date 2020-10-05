//
//  HelpView.swift
//  Tile 2
//
//  Created by Steve Swanson on 9/10/20.
//  Copyright © 2020 Steve Swanson. All rights reserved.
//

import SwiftUI

struct HelpView: View {
    var body: some View {
        
        NavigationView() {
            ScrollView() {

                Text("• Tiles appear in a rectangular grid")
                Text("• Like-colored connected regions can be removed by tapping on them")
                Image("Tile 2 blue selected 1024")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 256, height: 256)
                Text("• Removing tiles causes the ones above to fall down")
                Image("Tile 2 yellow selected 1024")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 256, height: 256)
                Text("• When you remove N tiles you score (N-1)²")
                Text("• So you would score 1 for removing the 2 blue tiles and 16 for removing the 5 yellow tiles")
                Text("• You cannot remove a singleton tile")
                Text("• You win by removing all the tiles. In that case, you get a bonus score of width * height")

            }
                .navigationBarTitle("Tile 2 Help", displayMode: .inline)
        }
        .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
    }
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView()
    }
}
