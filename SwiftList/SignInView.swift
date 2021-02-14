//
//  SignInView.swift
//  SwiftList
//
//  Created by Rohil on 1/31/21.
//

import SwiftUI
import Firebase

struct SignInView: View {
  @State private var email = ""
  @State private var password = ""
  
  @State var alertMessage = false;
  @State var errorMessage = "";
  
  @State var mLmR: CGFloat = 50;
  
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
          .padding(.bottom, 2)
          .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
        
        SecureField("Password", text: $password)
          .textFieldStyle(RoundedBorderTextFieldStyle())
          .font(.custom("Montserrat-Regular", size: 18))
          .padding(.leading, mLmR)
          .padding(.trailing, mLmR)
          .padding(.bottom, 12)
        
        NavigationLink(destination: AppView(), tag: 1, selection: $goToHome) {
          EmptyView()
        }
        
        Button(action: {
          if (password != "" && email != "") {
            Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
              if let error = error {
                //basically if the user cannot be signed in, eg: the credentials are wrong
                print(error);
                errorMessage = "The credentials you have entered are invalid. Please try again!"
                alertMessage = true
              } else if authResult != nil {
                //if everything goes well
                
                guard let userID = Auth.auth().currentUser?.uid else { return }
                
                let userRef = db.collection(userID).document("PROFILE CREDENTIALS")
                
                userRef.getDocument { (document, error) in
                  if let document = document, document.exists {
                    //let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                    UserDefaults.standard.setValue(userID, forKey: "userID")
                    
                    self.goToHome = 1;
                  } else {
                    print ("document does not exist, somehow firestore wasn't working")
                  }
                }
              }
            }
          } else {
            errorMessage = "Please fill in all of the fields!"
            alertMessage = true
          }
        }) {
          Text("Sign In")
            .foregroundColor(.white)
        }
        .alert(isPresented: $alertMessage) {
          Alert(title: Text("Error!"), message: Text("\(errorMessage)"))
        }
        .padding(.leading, 14)
        .padding(.bottom, 8)
        .padding(.top, 8)
        .padding(.trailing, 14)
        .background(Color(red: 38 / 255, green: 78 / 255, blue: 112 / 255))
        .cornerRadius(50)
        
        NavigationLink(destination: SignUpView()) {
          Text("Don't have an account? Sign up!")
            //.foregroundColor(Color(red: 15 / 255, green: 191 / 255, blue: 130 / 255))
            .padding()
        }
      }
    }
    .navigationBarHidden(true)
    .navigationBarTitle("", displayMode: .inline)
    .navigationBarBackButtonHidden(true)
  }
}

struct SignInView_Previews: PreviewProvider {
  static var previews: some View {
    SignInView()
  }
}
