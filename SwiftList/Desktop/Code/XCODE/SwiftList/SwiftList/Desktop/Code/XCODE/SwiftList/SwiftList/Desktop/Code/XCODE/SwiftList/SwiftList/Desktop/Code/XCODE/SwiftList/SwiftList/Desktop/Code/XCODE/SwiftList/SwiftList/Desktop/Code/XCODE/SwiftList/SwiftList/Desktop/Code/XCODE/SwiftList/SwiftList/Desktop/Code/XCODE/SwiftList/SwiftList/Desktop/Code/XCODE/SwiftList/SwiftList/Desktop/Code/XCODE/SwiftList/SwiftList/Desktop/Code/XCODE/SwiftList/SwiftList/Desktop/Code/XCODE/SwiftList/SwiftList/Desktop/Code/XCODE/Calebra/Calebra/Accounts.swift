//
//  Accounts.swift
//  Calebra
//
//  Created by Rohil on 7/28/20.
//  Copyright © 2020 Calebra Inc. All rights reserved.
//

import SwiftUI
import Firebase
import LocalAuthentication

public class UserProfile: ObservableObject {
    @Published var username: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
}

struct CreateAccounts: View {
    
    @State var trueStuff = false
    @State var goToHome: Int? = 0
    
    @ObservedObject var profile = UserProfile()
    @State var confirmedPw  = ""
    
    var body: some View {
        
        NavigationView {
            ZStack {
                Rectangle()
                    .fill(Color(red: 11/255, green: 28/255, blue: 89/255))
                    .edgesIgnoringSafeArea(.all)
                
                Rectangle()
                    .fill(Color(red: 14/255, green: 37/255, blue: 120/255))
                    .rotationEffect(Angle(degrees: 45))
                    .shadow(radius: 6)
                    .frame(height: 10000)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Text("Calebra")
                        .foregroundColor(.white)
                        .font(.system(size: 54))
                        .frame(alignment: .topLeading)
                    
                    ZStack {
                        Rectangle()
                            .frame(height: 300)
                            .cornerRadius(16)
                            .padding()
                            .foregroundColor(Color.white.opacity(0.8))
                            .cornerRadius(20)
                        VStack {
                            Text("Create an Account")
                                .bold()
                                .font(.system(size: 28))
                            
                            HStack {
                                //Image(systemName: "envelope")
                                TextField("Email", text: self.$profile.email)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .frame(width: 250)
                            }
                            
                            HStack {
                                //Image(systemName: "lock")
                                TextField("Password", text: self.$profile.password)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .frame(width: 250)
                            }
                            
                            TextField("Confirm Password", text: self.$confirmedPw)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 250)
                            NavigationLink(destination: ContentView(), tag: 1, selection: $goToHome) {
                                EmptyView()
                            }
                            
                            ZStack {
                                Rectangle()
                                    .foregroundColor(Color.init(red: 14/255, green: 37/255, blue: 120/255))
                                    .frame(width: 250, height: 34)
                                    .cornerRadius(6)
                                    .padding()
                                
                                Text("Create")
                                    .foregroundColor(.white)
                                
                            }.simultaneousGesture(TapGesture().onEnded({
                                if (self.profile.password != self.confirmedPw) {
                                    self.trueStuff = true
                                } else {
                                    Auth.auth().createUser(withEmail: self.profile.email, password: self.profile.password) { authResult, error in
                                        if let error = error {
                                            print(error)
                                        } else if authResult != nil {
                                            UserDefaults.standard.set(self.profile.email, forKey: "email")
                                            self.goToHome = 1
                                        }
                                    }
                                }
                            }))
                        }
                    }
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .alert(isPresented: self.$trueStuff) {
                Alert(title: Text("The passwords don't match!"))
            }
        }
    }
}


struct AccountSignIn: View {
    @State var goToHome: Int? = 0
    
    @State var trueStuff = false
    
    @State var userPassword: String = ""
    
    @State var userEmail = ""
    
    @ObservedObject var profile: UserProfile = UserProfile()
    
    @State private var isUnlocked = false
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        // check whether biometric authentication is possible
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // it's possible, so go ahead and use it
            let reason = "Calebra needs to get your account password"
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                // authentication has now completed
                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                    } else {
                        // there was a problem
                    }
                }
            }
        } else {
            // no biometrics
        }
    }
    
    
    
    
    
    
    
    
    
    var body: some View {
        NavigationView {
            ZStack {
                    Rectangle()
                        .fill(Color(red: 11/255, green: 28/255, blue: 89/255))
                        .edgesIgnoringSafeArea(.all)
                    
                    Rectangle()
                        .fill(Color(red: 14/255, green: 37/255, blue: 120/255))
                        .rotationEffect(Angle(degrees: 45))
                        .shadow(radius: 6)
                        .frame(height: 10000)
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack {
                        Text("Calebra")
                            .foregroundColor(.white)
                            .font(.system(size: 54))
                            .frame(alignment: .topLeading)
                        
                        ZStack {
                            Rectangle()
                                .frame(height: 300)
                                .cornerRadius(16)
                                .padding()
                                .foregroundColor(Color.white.opacity(0.8))
                                .cornerRadius(20)
                            VStack {
                                Text("Sign In")
                                    .bold()
                                    .font(.system(size: 28))
                                
                                
                                TextField("Email", text: self.$userEmail)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .frame(width: 250)
                                
                                
                                TextField("Password", text: self.$userPassword)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .frame(width: 250)
                                
                                
                                
                                
                                NavigationLink(destination: ContentView(), tag: 1, selection: $goToHome) {
                                    EmptyView()
                                }
                                
                                ZStack {
                                    Rectangle()
                                        .foregroundColor(Color.init(red: 14/255, green: 37/255, blue: 120/255))
                                        .frame(width: 250, height: 34)
                                        .cornerRadius(6)
                                        .padding()
                                    
                                    Text("Sign in")
                                        .foregroundColor(.white)
                                    
                                }.simultaneousGesture(TapGesture().onEnded({
                                    if (self.profile.password != self.userPassword) {
                                        self.trueStuff = true
                                    } else {
                                        Auth.auth().signIn(withEmail: self.profile.email, password: self.profile.password) { authResult, error in
                                            if let error = error {
                                                print(error)
                                            } else if authResult != nil {
                                                UserDefaults.standard.set(self.profile.email, forKey: "email")
                                                self.goToHome = 1
                                            }
                                        }
                                    }
                                    
                                    
                                }))
                                
                                NavigationLink(destination: CreateAccounts()) {
                                    Text("Create Account")
                                }
                            }
                        
                    }
                }
            }
            .navigationBarTitle("", displayMode: .inline)
                
                .onAppear(perform: {
                    if let email = UserDefaults.standard.object(forKey: "email") as? String {
                        self.userEmail = email
                    }
                    self.authenticate()
                })
        }
    }
    
}





struct Accounts_Previews: PreviewProvider {
    var hi: UserProfile
    static var previews: some View {
        AccountSignIn()
    }
}
