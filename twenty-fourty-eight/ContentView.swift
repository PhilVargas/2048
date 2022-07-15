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
    //    @Environment(\.managedObjectContext) private var viewContext
    //
    //    @FetchRequest(
    //        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
    //        animation: .default)
    //    private var items: FetchedResults<Item>

    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: GameView()) {
                    Text("New Game")
                        .font(.system(size: 16, weight: .black, design: .rounded))
                        .foregroundColor(.white)
                        .padding(12)
                        .background(Color.buttonBackground(.secondary))
                        .cornerRadius(6)
                }
            }
        }.font(.system(size: 16, weight: .black, design: .rounded))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
