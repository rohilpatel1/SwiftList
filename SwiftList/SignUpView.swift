//
//  SignUpView.swift
//  SwiftList
//
//  Created by Rohil on 1/29/21.
//

import SwiftUI

struct SignUpView: View {
  @State var email = ""
  @State var password = ""
  @State var fname = ""
  @State var lname = ""
  @State var confirmPassword = ""
  
  @State var mLmR: CGFloat = 50;
  
  
  
    var body: some View {
      VStack {
        Text("SwiftList")
          .font(.custom("Montserrat-Regular", size: 52))
        
        TextField("Enter Email", text: $email)
          .textFieldStyle(RoundedBorderTextFieldStyle())
          .font(.custom("Montserrat-Regular", size: 22))
          .padding(.leading, mLmR)
          .padding(.trailing, mLmR)
          .padding(.bottom, 20)
        
        TextField("Enter First Name", text: $fname)
          .textFieldStyle(RoundedBorderTextFieldStyle())
          .font(.custom("Montserrat-Regular", size: 22))
          .padding(.leading, mLmR)
          .padding(.trailing, mLmR)
        
        TextField("Enter Last Name", text: $lname)
          .textFieldStyle(RoundedBorderTextFieldStyle())
          .font(.custom("Montserrat-Regular", size: 22))
          .padding(.leading, mLmR)
          .padding(.trailing, mLmR)
          .padding(.bottom, 20)
        
        SecureField("Enter Password", text: $password)
          .textFieldStyle(RoundedBorderTextFieldStyle())
          .font(.custom("Montserrat-Regular", size: 22))
          .padding(.trailing, mLmR)
          .padding(.leading, mLmR)
        
        SecureField("Enter Password", text: $confirmPassword)
          .textFieldStyle(RoundedBorderTextFieldStyle())
          .font(.custom("Montserrat-Regular", size: 22))
          .padding(.trailing, mLmR)
          .padding(.leading, mLmR)
      }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
