//
//  ContentView.swift
//  Tile 2
//
//  Created by Steve Swanson on 9/5/20.
//  Copyright © 2020 Steve Swanson. All rights reserved.
//

import SwiftUI

struct Tile2ButtonStyle: ButtonStyle {
    func makeBody(configuration: ButtonStyleConfiguration) -> some View {
        RoundedRectangle(cornerRadius: 10)
            .fill()
            .aspectRatio(1.0, contentMode: .fit)
    }
}

struct ContentView: View {
    
    @ObservedObject var model: Model
    @Environment(\.undoManager) var undoManager
    
    @State private var viewSelection: String? = nil

    var body: some View {
        NavigationView {
            ZStack {
                Rectangle()
                    .foregroundColor(.gray)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    NavigationLink(destination: HighScoresView(model: self.model), tag: "HighScores", selection: $viewSelection) {
                            EmptyView()
                        }
                    NavigationLink(destination: SettingsView(model: self.model), tag: "Settings", selection: $viewSelection) {
                            EmptyView()
                        }
                    NavigationLink(destination: HelpView(), tag: "Help", selection: $viewSelection) {
                             EmptyView()
                         }

                    Spacer()
                    VStack {
                        ForEach((0 ..< self.model.height).reversed(), id: \.self) { j in
                            HStack {
                                ForEach(0 ..< self.model.width, id: \.self) { i in
                                    Button("", action: {self.handleTap(i,j)})
                                        .foregroundColor(self.model.board[i,j])
                                        .buttonStyle(Tile2ButtonStyle())
                                }
                            }
                        }
                    }
                        .padding(.all,10)
                    
                    Spacer()
                    Text(String(self.model.winner))
                        .font(Font.largeTitle.weight(.bold))
                    Text(String(self.model.score))
                        .font(Font.largeTitle.weight(.bold))
                }
            }
            .navigationBarItems(
                leading: HStack() {
                    Button(action: { self.handleNew() }) {
                        Text("New")
                    }
                        .padding(.all,5)
                        .background(Color.white)
                        .cornerRadius(10)
                    
                    Button(action: { self.handleUndo() }) {
                        Image(systemName: "arrow.uturn.left")
                    }
                        .padding(.all,10)
                        .background(Color.white)
                        .cornerRadius(10)
                        .disabled(!(self.undoManager?.canUndo ?? false))
                }
                    .font(Font.body.weight(.bold))
                ,
                trailing: HStack() {
                    Button(action: { self.viewSelection = "HighScores" }) {
                        Image(systemName: "number.square")
                    }
                        .padding(.all,10)
                        .background(Color.white)
                        .cornerRadius(10)

                    Button(action: { self.viewSelection = "Settings" }) {
                        Image(systemName: "gear")
                    }
                        .padding(.all,10)
                        .background(Color.white)
                        .cornerRadius(10)

                    Button(action: { self.viewSelection = "Help"} ) {
                        Text("Help")
                    }
                        .padding(.all,5)
                        .background(Color.white)
                        .cornerRadius(10)
                }
                    .font(Font.body.weight(.bold))
            )
        }
    }
    
    func handleTap(_ x: Int, _ y: Int) {
        self.model.tap(x,y)
    }
    
    func handleNew() {
        self.model.new()
    }
    
    func handleUndo() {
        self.model.undo()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(model: Model(undoManager: UndoManager()))
    }
}

