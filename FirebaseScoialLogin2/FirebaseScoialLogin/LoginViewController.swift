//
//  ViewController.swift
//  FirebaseScoialLogin
//
//  Created by Basila Nathan on 3/28/17.
//  Copyright © 2017 Basila Nathan. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginButton = FBSDKLoginButton()
        loginButton.readPermissions = ["email"]
        loginButton.readPermissions = ["read_custom_friendlists"]
        loginButton.readPermissions = ["user_friends"]

        view.addSubview(loginButton)
        //frame's are obselete, please use constraints instead because its 2016 after all
        loginButton.frame = CGRect(x: 16, y: 50, width: view.frame.width - 32, height: 50)
        loginButton.center = view.center
        
        loginButton.delegate = self
        

        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Did log out of facebook")
        if FBSDKAccessToken.current() == nil {
//            print ("great")
        } else {
//            print ("fuck")
        }
        logout()
        
    }
    
    func logout() {
        FBSDKLoginManager().logOut()
        
    }
    

    
    func showFriends() {
        let accessToken = FBSDKAccessToken.current()
        guard let accessTokenString = accessToken?.tokenString else {return}
        
        let credentials = FIRFacebookAuthProvider.credential(withAccessToken: (accessTokenString))
        FIRAuth.auth()?.signIn(with: credentials, completion: { (user, error) in
            if error != nil {
                print("something went wrong with ourFB user: ", error ?? "")
                return
            }
            print("successfully logged in with user: ", user ?? "")
        })
        
        let params = ["fields": "id, last_name, first_name, gender, email"]
        FBSDKGraphRequest(graphPath: "me/friends", parameters: params).start { (connection, result , error) -> Void in
            
            if error != nil {
                print(error!)
            }
            else {
                
                let user = result as? [String: Any]
                
//             print (user)
//                print (type(of: user))
                
//                print(result!)
                //Do further work with response
            }
        }
        
//        let params = ["fields": "id, first_name, last_name, name, email, picture"]
        
//        let graphRequest = FBSDKGraphRequest(graphPath: "/me/taggable_friends", parameters: params, httpMethod: "GET")
//        graphRequest?.start(completionHandler: { (connection, result, error) in
//            if error == nil {
//
//            if let userData = result as? [String:AnyObject] {
//                print (userData)
////                for something in userData["data"] as! [Any] {
////                    
////                    print (something)
////                }
//            }
//            } else {
//            print("Error Getting Friends \(error)");
//            }
//            
//            })
//        let connection = FBSDKGraphRequestConnection()
//        connection.add(graphRequest, completionHandler: { (connection, result, error) in
//            if error == nil {
//                if let userData = result as? [String:Any ] {
//                    
//                    print (userData["data"])
//                }
//            } else {
//                print("Error Getting Friends \(error)");
//            }
//            
//        })
//        
//        connection.start()
        
//        let parameters = ["fields": "email, id, name"]
//        let graphRequest = FBSDKGraphRequest(graphPath: "me/friendlists", parameters: parameters)
//        
//        _ = graphRequest?.start { [weak self] connection, result, error in
//            // If something went wrong, we're logged out
//            print(result)
//            if (error != nil) {
//                // Clear email, but ignore error for now
//                return
//            }
//            
//            // Transform to dictionary first
//            if let result = result as? [String: Any] {
//                // Got the email; send it to Lucid's server
//                guard (result["email"] as? String) != nil else {
//                    // No email? Fail the login
//                    return
//                }
//                guard (result["name"] as? String) != nil else {
//                    // No username? Fail the login
//                    return
//                }
//                
//                guard (result["id"] as? String) != nil else {
//                    // No userId? Fail the login
//                    return
//                }
//                
//            }
//            
//        } // End of graph request

    }
    
    //Get list of friends
    
//    func getFriends() {
//        var friendsRequest : FBSDKGraphRequest = FBSDKGraphRequest.
//        
//    }
    

    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error)
            return
        }
        
        print("Successfully logged in with facebook...")
        
        performSegue(withIdentifier: "swipe", sender: self)
        
  
        showFriends()
    }
}


