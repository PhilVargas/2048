//
//  twenty_fourty_eightApp.swift
//  twenty-fourty-eight
//
//  Created by Phil Vargas on 7/12/22.
//

import SwiftUI

@main
struct twenty_fourty_eightApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
