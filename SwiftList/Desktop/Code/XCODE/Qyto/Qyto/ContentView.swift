//
//  ContentView.swift
//  Qyto
//
//  Created by Rohil on 12/1/20.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        Text("Hello World")
            .font(Font.custom("Montserrat-Regular", size: 60))
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
