//
//  SignUpView.swift
//  SwiftList
//
//  Created by Rohil on 1/29/21.
//

import SwiftUI
import Firebase

struct SignUpView: View {
  @State private var email = ""
  @State private var password = ""
  @State var fname = ""
  @State var lname = ""
  @State var confirmPassword = ""
  
  @State var mLmR: CGFloat = 50;
  
  @State var validEntries = false
  @State var emptyStuff = false
  @State var passwordsDontMatch = false
  
  @State var errorMessage = ""
  
  @State var goToHome: Int? =  0;
  private var db: Firestore
  
  
  init() {
    db = Firestore.firestore()
  }
  
  var body: some View {
    NavigationView {
      VStack {
        Text("SwiftList")
          .font(.custom("Montserrat-Regular", size: 52))
        
        TextField("Email", text: $email)
          .textFieldStyle(RoundedBorderTextFieldStyle())
          .font(.custom("Montserrat-Regular", size: 18))
          .padding(.leading, mLmR)
          .padding(.trailing, mLmR)
          .padding(.bottom, 10)
          .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
        
        TextField("First Name", text: $fname)
          .textFieldStyle(RoundedBorderTextFieldStyle())
          .font(.custom("Montserrat-Regular", size: 18))
          .padding(.leading, mLmR)
          .padding(.trailing, mLmR)
        
        TextField("Last Name", text: $lname)
          .textFieldStyle(RoundedBorderTextFieldStyle())
          .font(.custom("Montserrat-Regular", size: 18))
          .padding(.leading, mLmR)
          .padding(.trailing, mLmR)
          .padding(.bottom, 10)
        
        SecureField("Password", text: $password)
          .textFieldStyle(RoundedBorderTextFieldStyle())
          .font(.custom("Montserrat-Regular", size: 18))
          .padding(.trailing, mLmR)
          .padding(.leading, mLmR)
        
        SecureField("Confirm Password", text: $confirmPassword)
          .textFieldStyle(RoundedBorderTextFieldStyle())
          .font(.custom("Montserrat-Regular", size: 18))
          .padding(.trailing, mLmR)
          .padding(.leading, mLmR)
          .padding(.bottom, 20)
        
        NavigationLink(destination: AppView(), tag: 1, selection: $goToHome) {
          EmptyView()
        }
        
        Button(action: {
          if (email != "" && fname != "" && lname != "" && password != "" && confirmPassword != "") {
            if (password != confirmPassword) {
              emptyStuff = true
              errorMessage = "The passwords you have entered do not match!"
            } else {
              if (password.count < 6) {
                emptyStuff = true
                errorMessage = "The password you enter has to be at least 6 characters"
              } else {
                if (email.count >= 6 && email.contains("@") && email.contains(".")) {
                  //db code injection
                  Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
                    if let error = error {
                      print(error)
                    }
                    
                    guard let userID = Auth.auth().currentUser?.uid else { return }
                    
                    let userCreds = [
                      "firstName": fname,
                      "lname": lname,
                      "email": email,
                    ]
                    
                    db.collection(userID).document("PROFILE CREDENTIALS").setData(userCreds) { err in
                      if let err = err {
                        print(err)
                      } else {
                        UserDefaults.standard.setValue(userID, forKey: "userID");
                        //UserDefaults.standard.setValue(userCreds, forKey: "User")
                      }
                    }
                  }
                  //attempt to send user to app view
                  self.goToHome = 1;
                  UserDefaults.standard.setValue(true, forKey: "signedIn")
                } else {
                  emptyStuff = true
                  errorMessage = "Invalid Email, please try again!"
                }
              }
            }
          } else {
            emptyStuff = true
            errorMessage = "In at least one of the fields you have entered an invalid value"
          }
        }) {
          Text("Sign Up")
            .foregroundColor(.white)
        }
        .alert(isPresented: $emptyStuff) {
          Alert(title: Text("Error!"), message: Text("\(errorMessage)"))
        }
        .padding(.leading, 14)
        .padding(.bottom, 8)
        .padding(.top, 8)
        .padding(.trailing, 14)
        .background(Color(red: 38 / 255, green: 78 / 255, blue: 112 / 255))
        .cornerRadius(50)
        
        NavigationLink(destination: SignInView()) {
          Text("Already have an account? Sign in!")
            .padding()
            //.foregroundColor(Color(red: 15 / 255, green: 191 / 255, blue: 130 / 255))
        }
      }
    }
    .navigationBarHidden(true)
    .navigationBarTitle("", displayMode: .inline)
    .navigationBarBackButtonHidden(true)
  }
}

struct SignUpView_Previews: PreviewProvider {
  static var previews: some View {
    SignUpView()
  }
}
