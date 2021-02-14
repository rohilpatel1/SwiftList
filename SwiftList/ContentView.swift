//
//  ContentView.swift
//  SwiftList
//
//  Created by Rohil on 1/24/21.
//

import SwiftUI
import CoreData
import Firebase

struct ContentView: View {
  private var db: Firestore
  
  @State var goToCreate: Int? =  0;
  
  
  init() {
    db = Firestore.firestore()
  }
  
  
  var body: some View {
    NavigationView {
      VStack {
        Text("Welcome!")
          .font(.custom("Montserrat-Regular", size: 52))
        
        NavigationLink(destination: CreateView(), tag: 1, selection: $goToCreate) {
          EmptyView()
        }
        
        ZStack {
          Rectangle()
            .fill(Color(red: 38 / 255, green: 78 / 255, blue: 112 / 255))
            .frame(height: 120, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .cornerRadius(8)
            .padding(12)
            .shadow(radius: 10)
          
          Text("Favorites")
            .foregroundColor(.white)
            .font(Font.custom("Montserrat-Regular", size: 24))
        }
        
        HStack {
          ZStack {
            Rectangle()
              .fill(Color(red: 103 / 255, green: 145 / 255, blue: 134 / 255))
              .frame(height: 120, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
              .cornerRadius(8)
              .padding(.leading, 12)
              .padding(.trailing, 6)
              .shadow(radius: 10)
            
            Text("Staples")
              .font(.custom("Montserrat-Regular", size: 24))
          }
          
          ZStack {
            Rectangle()
              .fill(Color(red: 253 / 255, green: 235 / 255, blue: 211 / 255))
              .frame(height: 120, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
              .cornerRadius(8)
              .padding(.trailing, 12)
              .padding(.leading, 6)
              .shadow(radius: 10)
            
            Text("Create")
              .font(.custom("Montserrat-Regular", size: 24))
              .frame(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
          }.onTapGesture {
            self.goToCreate = 1;
          }
        }
        .navigationBarHidden(true)
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
      }
    }
    
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
  }
}
