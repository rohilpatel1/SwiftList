//
//  SettingsView.swift
//  Calebra
//
//  Created by Rohil on 7/24/20.
//  Copyright © 2020 Calebra Inc. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @State var username = ""
    @State var notifications = true
    var body: some View {
    
            Form {
                    Section(header: Text("SETTINGS")) {
                        TextField("Username", text: $username)
                        Toggle(isOn: $notifications) {
                            Text("Notifications")
                            
                            
                        }
                  }
            }
        }
    }



struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
