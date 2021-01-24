//
//  SwiftListApp.swift
//  SwiftList
//
//  Created by Rohil on 1/24/21.
//

import SwiftUI

@main
struct SwiftListApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
