//
//  ContentView.swift
//  twenty-fourty-eight
//
//  Created by Phil Vargas on 7/12/22.
//

import ComposableArchitecture
import CoreData
import SwiftUI

struct ContentView: View {
    let store = Store(initialState: GameState(), reducer: gameReducer, environment: .live)

    var body: some View {
        NavigationView {
            ZStack {
                Color.neutral.ignoresSafeArea()
                GameView(store: store)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
