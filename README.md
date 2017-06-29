# GoogleSignUpProject

How to Integrate Google Sign-in SDK Using Swift in iOS Application


1. Install the pod 'Google/SignIn'
2. Steps for install Third party framework Google/Signin
*    cd projectNmae
*   Pod init
*  open Podfile
* Inside Podfile write -> pod 'Google/SignIn'
* Save Podfile
* Pod install
* If successfully install pod you got message something like this
Pod installation complete! There are 3 dependencies from the Podfile and 10 total pods installed.

* in terminal for show list => ls
* Now open project from terminal => open ProjectName.xcworkspace
* Now Close the terminal.

3. Open https://developers.google.com/identity/sign-in/ios/
4. First of all Sign in with your gmail id in google developer account.
5. Give The app Name and iOS Bundle Name

  Ex => App Name = Demo App
	    Bundle Identifier = com.companyname.appname
Than select country and click on done

6. Select which Google services you'd like to add to your app below. “Google Sign-in” and click on Enable Google Sign in
7. Than select Generate configuration files and Download GoogleService-info.plist file
8. Drag the GoogleService-Info.plist file you just downloaded into the root of your Xcode project and add it to all targets.
9. https://developers.google.com/identity/sign-in/ios/sign-in?configured=true&ver=swift  Guide line
Before you begin
Download the dependencies and configure your Xcode project.
Add the configuration file to your project
Drag the GoogleService-Info.plist file you just downloaded into the root of your Xcode project and add it to all targets.
In the Project > Target > Info > URL Types panel, create a new item and paste your REVERSED_CLIENT_ID into the URL Schemes field. You can find your REVERSED_CLIENT_ID in the GoogleService-Info.plist file.

Also in the Project > Target > Info > URL Types panel, create a new item and type your bundle identifier in the URL Schemes field.

Enable sign-in
To enable sign in, you must configure the GGLContext shared instance (or, if you manually installed the SDK, the GIDSignIn shared instance). You can do this in many places in your app. Often the easiest place to configure this instance is in your app delegate's application:didFinishLaunchingWithOptions: method.

1. In your app's project-Bridging-Header.h file, import the Google Sign-In SDK headers:

#import <Google/SignIn.h>

If your project does not have a project-Bridging-Header.h file, you can create one by adding an Objective-C file to your app. The easiest way to do this is to drag and drop a .m file into your project—which creates the bridging header and configures your project to use it—then delete the .m file. See Swift and Objective-C in the Same Project for more information.

2. In your app delegate (AppDelegate.swift), declare that this class implements the GIDSignInDelegateprotocol.
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

3. In your app delegate's application:didFinishLaunchingWithOptions: method, configure the GGLContextshared instance and set the sign-in delegate.

// Initialize sign-in
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        assert(configureError == nil, "Error configuring Google services: \(String(describing: configureError))")
        
        GIDSignIn.sharedInstance().delegate = self
        
        return true

4. In the app delegate, implement the GIDSignInDelegate protocol to handle the sign-in process by defining the following methods:
  let defaults = UserDefaults.standard

func application(_ application: UIApplication,
                     open url: URL, sourceApplication: String?, annotation: Any) -> Bool {

        let isGooglePlusURL = GIDSignIn.sharedInstance().handle(url,
                                                                sourceApplication: sourceApplication,
                                                                annotation: annotation)
        
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
            let gender = user.profile.debugDescription
            print("my Data => \(gender)")
            print("\n\(String(describing: userId)) \n\(String(describing: idToken)) \n\(String(describing: fullName)) \n \(String(describing: givenName)) \n \(String(describing: familyName)) \n \(String(describing: email))");
            
            if (user.profile.hasImage) {
                let url = user.profile.imageURL(withDimension: 100)
                
                print("url....\(String(describing: url))")
            }
            
            DispatchQueue.main.async { () -> Void in
                
                self.defaults.setValue(email, forKeyPath: "gfemail")
                self.defaults.setValue(fullName, forKeyPath: "gffisrtname")
                self.defaults.setValue(givenName, forKeyPath: "gflastname")
             //   self.defaults.setValue(url, forKeyPath: "user_photo")
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

In Controller

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
