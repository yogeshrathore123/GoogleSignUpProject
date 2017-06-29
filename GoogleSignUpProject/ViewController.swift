//
//  ViewController.swift
//  GoogleSignUpProject
//
//  Created by Yogesh Rathore on 26/06/17.
//  Copyright © 2017 Sybrant Technologies. All rights reserved.
//

import UIKit
//import GoogleSignIn
//import Google

class ViewController: UIViewController, GIDSignInUIDelegate {
    
   

    @IBOutlet weak var GoogleSignInBtn: GIDSignInButton! // This is UIView in storyboard
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
         GIDSignIn.sharedInstance().uiDelegate = self
 
        GIDSignIn.sharedInstance().scopes.append("https://www.googleapis.com/auth/plus.login")
        GIDSignIn.sharedInstance().scopes.append("https://www.googleapis.com/auth/plus.me")
       // GIDSignIn.sharedInstance().signInSilently()
        GoogleSignInBtn.style = GIDSignInButtonStyle.wide
        GoogleSignInBtn.layer.borderColor = UIColor.red.cgColor
        GoogleSignInBtn.layer.borderWidth = 1.0
        GoogleSignInBtn.layer.cornerRadius = 5.0
        
    }
    
    @IBAction func didTapSignOut(_ sender: Any) {
        print("Work")
      //  GIDSignIn.sharedInstance().signOut()
    }
    //GOOGLE
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
        //myActivityIndicator.stopAnimating()
    }
    
    // Present a view that prompts the user to sign in with Google
    func sign(_ signIn: GIDSignIn!,
              present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    // Dismiss the "Sign in with Google" view
    func sign(_ signIn: GIDSignIn!,
              dismiss viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

