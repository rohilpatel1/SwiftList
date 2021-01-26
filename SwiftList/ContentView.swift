//
//  ContentView.swift
//  SwiftList
//
//  Created by Rohil on 1/24/21.
//

import SwiftUI
//test
import CoreData

struct ContentView: View {

    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(Color(red: 38 / 255, green: 78 / 255, blue: 112 / 255))
                    .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .cornerRadius(8)
                    .padding(12)
                    .shadow(radius: 10)
                
                Text("Favorites")
                    .foregroundColor(.white)
                    .font(Font.custom("Montserrat-Regular", size: 30))
            }
        }
    }

    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
