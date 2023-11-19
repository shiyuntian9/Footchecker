//
//  LoginView.swift
//  Footchecker
//
//  Created by 田诗韵 on 11/18/23.
//



import SwiftUI
import CoreData
// Add this to the header of your file, e.g. in ViewController.swift
import FacebookLogin

// Add this to the body
//class ViewController: UIViewController {
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    
//        let loginButton = FBLoginButton()
//        loginButton.center = view.center
//        view.addSubview(loginButton)
//        
//        if let token = AccessToken.current,
//                !token.isExpired {
//                LoginView()
//            }
//        
//        loginButton.permissions = ["public_profile", "email"]
//    }
//    
//    
//      
//}





struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isUserLoggedIn = false
    @State private var showingAlert = false
    @State private var alertMessage = ""
    var body: some View {
        
        
        GeometryReader { geometry in
            VStack(spacing: 20) {
                Text("Login")
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .padding(.top, 20.0)
                    .frame(width: geometry.size.width, alignment: .top)
                
                
                Text("Username")
                
                
                TextField("Username", text: $username)
                    .padding(.horizontal, 4.0)
                                    .frame(width: 300)
                
                Text("Password")
                
                SecureField("Password", text: $password)
                    .padding(.horizontal, 4.0)
                    .frame(width: 300)
                Button(action: {
                    self.handleLogin()
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
                
                            .alert(isPresented: $showingAlert) {
                                           Alert(title: Text("Login Failed"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                                       }
                HStack{
                    Text("Don't have an account?")
                    Button("Sign up here") {
                        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                    }
                    .padding()
                    
                }
                .padding()
                HStack(spacing: 20) {


                           

                    FacebookLoginButton() { loggedIn in
                                    isUserLoggedIn = loggedIn
                                }

                            // Optionally, add more UI elements as needed
                        }
                        .padding()
                
                NavigationLink(destination: OverallView(), isActive: $isUserLoggedIn) {
                                EmptyView()
                            }
            }
            
            
            
        }
            
        
    }
    
    private func handleLogin() {
            let context = PersistenceController.shared.container.viewContext
            let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "username == %@ AND password == %@", username, password)

            do {
                let results = try context.fetch(fetchRequest)
                if results.isEmpty {
                    self.alertMessage = "No user found with the provided credentials."
                    self.showingAlert = true
                } else {
                    // Successful login
                    // Navigate to the next view or update the state accordingly
                }
            } catch {
                print("Error fetching: \(error)")
                self.alertMessage = "An error occurred during login."
                self.showingAlert = true
            }
        }
    
    func handleRegistration(username: String, password: String, context: NSManagedObjectContext) -> Bool {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "username == %@", username)

        do {
            let results = try context.fetch(fetchRequest)
            if !results.isEmpty {
                // Username already exists
                return false
            } else {
                // Create new user
                let newUser = User(context: context)
                newUser.username = username
                newUser.password = password // Consider hashing the password

                try context.save()
                return true
            }
        } catch {
            print("Error saving/registering user: \(error)")
            return false
        }
    }


    
    struct FacebookLoginButton: UIViewRepresentable {
        var onLoginStatusChanged: (Bool) -> Void

        func makeUIView(context: Context) -> FBLoginButton {
            let loginButton = FBLoginButton()
            loginButton.permissions = ["public_profile", "email"]
            loginButton.delegate = context.coordinator
            return loginButton
        }

        func updateUIView(_ uiView: FBLoginButton, context: Context) { }

        func makeCoordinator() -> Coordinator {
            Coordinator(onLoginStatusChanged: onLoginStatusChanged)
        }

        class Coordinator: NSObject, LoginButtonDelegate {
            var onLoginStatusChanged: (Bool) -> Void

            init(onLoginStatusChanged: @escaping (Bool) -> Void) {
                self.onLoginStatusChanged = onLoginStatusChanged
            }

            func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
                if let error = error {
                    print(error.localizedDescription)
                    return
                }

                if let result = result, !result.isCancelled {
                    // The user is logged in
                    onLoginStatusChanged(true)
                } else {
                    // The login operation was cancelled
                    onLoginStatusChanged(false)
                }
            }


            func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
                onLoginStatusChanged(false)
            }
            
            
        }
    }

}

#Preview {
    LoginView()
}

