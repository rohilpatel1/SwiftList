//
//  RemindersView.swift
//  Calebra
//
//  Created by Rohil on 7/24/20.
//  Copyright © 2020 Calebra Inc. All rights reserved.
//

import SwiftUI
import UserNotifications

public class Globals: ObservableObject {
    @Published var reminder: String = ""
    @Published var date: Date = Date()
}

var Reminders: [String] = []




struct AddReminders: View {
    
    @ObservedObject var globals = Globals()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        
        NavigationView {
        Form {
            Section(header: Text("REMINDER")) {
                TextField("Reminder Name", text: self.$globals.reminder)
                DatePicker(selection: self.$globals.date) {
                    Text("Select Completion Date")
                }
                //Text(self.globals.reminder)
                /*
                NavigationLink(destination: RemindersView(globals: self.globals)) {
                    Button(action: {
                        print("Done tapped")
                        Reminders.append(self.globals.reminder)
                        
                    }) {
                        Text("Done")
                    }
                }
 */
            }
 
        }
        .navigationBarTitle("", displayMode: .inline)
        //.navigationBarHidden(true)
        .navigationBarItems(trailing: NavigationLink(destination: RemindersView(globals: self.globals)) {
            Button(action: {
                print("Done tapped")
                Reminders.append(self.globals.reminder)
                self.presentationMode.wrappedValue.dismiss()
                
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (success, error) in
                    if success {
                    print("Permisson Granted")
                    } else if let err = error {
                        print(err.localizedDescription)
                    }
                }
                
                let content = UNMutableNotificationContent()
                
                content.title = self.globals.reminder
                content.body = "You have a reminder to do! Get started on it!"
                
                var dateComponents = DateComponents()
                dateComponents.calendar = Calendar.current
                let datePicker = self.globals.date
                let dateInteger = Int(datePicker.timeIntervalSince1970)
                let currentDateInt = Int(Date().timeIntervalSince1970)
                let dateDifference = Double(dateInteger - currentDateInt)
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: dateDifference, repeats: false)
                
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request)
            }) {
                Text("Save")
            }
        })
        }
    }
}



struct RemindersView: View {
    @ObservedObject var globals: Globals
    

    var body: some View {
        NavigationView {
          List {
            //Text(self.globals.reminder)
            ForEach(Reminders, id: \.self) {reminder in
                Text(reminder)
  
            }
            //.listRowBackground(Color.init(red: 11/255, green: 28/255, blue: 89/255))
          
          }
          .navigationBarTitle("", displayMode: .inline)}
        .navigationBarHidden(true)
            .navigationBarItems(trailing: NavigationLink(destination: AddReminders(), label: {
              Image(systemName: "plus")
                .font(.system(size: 22))
        }))
        
    }
    
}



/*
struct RemindersView_Previews: PreviewProvider {
    static var previews: some View {
        RemindersView()
    }
}
 
 */

