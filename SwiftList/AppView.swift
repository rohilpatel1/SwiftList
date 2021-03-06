//
//  AppView.swift
//  SwiftList
//
//  Created by Rohil on 1/29/21.
//

import SwiftUI

struct AppView: View {
    var body: some View {
      
        TabView {
          ContentView()
            .tabItem {
              Image(systemName: "house.fill")
              Text("Home")
            }
        }
        .navigationBarHidden(true)
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
    }
  
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
      AppView()
    }
}
