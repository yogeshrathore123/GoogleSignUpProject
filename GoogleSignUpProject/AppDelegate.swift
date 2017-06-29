//
//  AppDelegate.swift
//  GoogleSignUpProject
//
//  Created by Yogesh Rathore on 26/06/17.
//  Copyright © 2017 Sybrant Technologies. All rights reserved.
//

import UIKit



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    



    var window: UIWindow?
    let defaults = UserDefaults.standard


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Initialize sign-in
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services: \(String(describing: configureError))")
        
        GIDSignIn.sharedInstance().delegate = self
        
        return true
    }
    
   
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(_ application: UIApplication,
                     open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
//        let isFacebookURL = FBSDKApplicationDelegate.sharedInstance().application(application,
//                                                                                  open: url,
//                                                                                  sourceApplication: sourceApplication,
//                                                                                  annotation: annotation)
        
        let isGooglePlusURL = GIDSignIn.sharedInstance().handle(url,
                                                                sourceApplication: sourceApplication,
                                                                annotation: annotation)
        
     //   return isFacebookURL || isGooglePlusURL
        return isGooglePlusURL
    }
    
    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if (error == nil) {
            // Perform any operations on signed in user here.
            let userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
           
           
            print("\n\(String(describing: userId)) \n\(String(describing: idToken)) \n\(String(describing: fullName)) \n \(String(describing: givenName)) \n \(String(describing: familyName)) \n \(String(describing: email))");
            
            if (user.profile.hasImage) {
                let url = user.profile.imageURL(withDimension: 100)
               
                print("url....\(String(describing: url))")
        
                self.defaults.set(url, forKey: "user_photo")
            }
            
            DispatchQueue.main.async { () -> Void in
                
                self.defaults.setValue(email, forKeyPath: "gemail")
                self.defaults.setValue(fullName, forKeyPath: "gfullName")
         
                self.defaults.synchronize()
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let initialViewController = storyboard.instantiateViewController(withIdentifier: "RegistrationViewControllerID")
                self.window?.rootViewController = initialViewController
                self.window?.makeKeyAndVisible()
                
                
            }
            
            
        } else {
            print("\(error.localizedDescription)")
        }
    }
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user:GIDGoogleUser!,
              withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }


}

