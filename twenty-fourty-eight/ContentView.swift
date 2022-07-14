//
//  ContentView.swift
//  twenty-fourty-eight
//
//  Created by Phil Vargas on 7/12/22.
//

import SwiftUI
import CoreData
import ComposableArchitecture

struct ContentView: View {
    //    @Environment(\.managedObjectContext) private var viewContext
    //
    //    @FetchRequest(
    //        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
    //        animation: .default)
    //    private var items: FetchedResults<Item>
    let store = Store(initialState: BoardState(matrix: [
        [0, 0, 2, 2],
        [4, 0, 4, 128],
        [0, 0, 0, 0],
        [4, 16, 8, 128]
    ]), reducer: boardReducer, environment: .live)

    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: BoardView(store: store)) {
                    Text("New Game")
                        .font(.system(size: 16, weight: .black, design: .rounded))
                        .foregroundColor(.white)
                        .padding(12)
                        .background(Color.buttonBackground)
                        .cornerRadius(6)
                }
            }.navigationTitle("2048")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}


