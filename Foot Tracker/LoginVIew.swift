//
//  LoginVIew.swift
//  Foot Tracker
//
//  Created by 田诗韵 on 11/18/23.
//

import SwiftUI

struct LoginVIew: View {
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 20) {
                Text("Login")
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .padding(.top, 20.0)
                    .frame(width: geometry.size.width, alignment: .top)
                
                
                Text("Username")
                
                
                TextField("Username", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                    .padding(.horizontal, 4.0)
                                    .frame(width: 300)
                
                Text("Password")
                
                TextField("Password", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                    .padding(.horizontal, 4.0)
                    .frame(width: 300)
                Button(action: {
                                // Button action
                            }) {
                                Text("Login")
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity) // Make the button expand to the full width
                                    .background(Color.purple
                                    ) // Set the button background color
                                    .cornerRadius(10) // Rounded corners
                            }
                            .padding(.horizontal)
                HStack{
                    Text("Don't have an account?")
                    Button("Sign up here") {
                        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                    }
                    .padding()
                    
                }
                .padding()
                VStack(spacing: 20) {
                            Image("InstagramLogo") // Replace with your logo asset
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)

                            Text("Sign in with Instagram")
                                .font(.title)
                                .padding()

                            Button(action: signInWithInstagram) {
                                Text("Sign In")
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.purple) // Instagram color theme
                                    .cornerRadius(10)
                            }
                            .padding(.horizontal)

                            // Optionally, add more UI elements as needed
                        }
                        .padding()
            }
            
            
            
        }
            
        
    }
    
    func signInWithInstagram() {
            // Implement the sign-in logic here
        }
}

#Preview {
    LoginVIew()
}
