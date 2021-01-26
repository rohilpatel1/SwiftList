//
//  QytoApp.swift
//  Qyto
//
//  Created by Rohil on 12/1/20.
//

import SwiftUI

@main
struct QytoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
