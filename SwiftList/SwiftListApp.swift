//
//  SwiftListApp.swift
//  SwiftList
//
//  Created by Rohil on 1/24/21.
//

import SwiftUI
import UIKit
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    // Configure FirebaseApp
    if (FirebaseApp.app() == nil){
      FirebaseApp.configure();
    }
    
    return true
  }
}

@main
struct SwiftListApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
  let persistenceController = PersistenceController.shared
  
  init() {
    FirebaseApp.configure()
  }
  
  var body: some Scene {
    let isLoggedIn = UserDefaults.standard.bool(forKey: "signedIn")
    WindowGroup {
      if isLoggedIn {
        AppView()
          .environment(\.managedObjectContext, persistenceController.container.viewContext)
      } else {
        SignInView()
          .environment(\.managedObjectContext, persistenceController.container.viewContext)
      }
    }
  }
}
