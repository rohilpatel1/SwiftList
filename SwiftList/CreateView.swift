//
//  CreateView.swift
//  SwiftList
//
//  Created by Rohil on 2/14/21.
//

import SwiftUI

struct CreateView: View {
  @State var recipeName = ""
  @State var isStaple = false
  
  var body: some View {
    Form {
      Section(header: Text("General")) {
        TextField("Recipe Name", text: $recipeName)
        Toggle(isOn: $isStaple, label: {
          Text("Staple")
        })
      }
    }
    .navigationBarHidden(true)
    .navigationBarTitle("Create Recipe", displayMode: .inline)
    .navigationBarBackButtonHidden(false)
  }
}

struct CreateView_Previews: PreviewProvider {
  static var previews: some View {
    CreateView()
  }
}
