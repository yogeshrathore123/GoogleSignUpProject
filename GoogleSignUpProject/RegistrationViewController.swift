//
//  RegistrationViewController.swift
//  GoogleSignUpProject
//
//  Created by Yogesh Rathore on 26/06/17.
//  Copyright © 2022 Yogesh Rathore. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {

    @IBOutlet weak var UserimageView: UIImageView!
    @IBOutlet weak var NameLbl: UILabel!
    @IBOutlet weak var EmailIDLbl: UILabel!
  
    let defaults = UserDefaults.standard
 
    override func viewDidLoad() {
       
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    
        
       
   //     let imageUrl = defaults.value(forKey: "user_photo") as! String
        
    
        
        
        
        
        
        if let nameStr = defaults.value(forKey: "gfullName") as? String {
           NameLbl.text = nameStr
        }
        
        if let emailStr = defaults.value(forKey: "gemail") as? String {
            EmailIDLbl.text = emailStr
        }
        
        if let imageUrl = defaults.url(forKey: "user_photo") {
          //  let data = try? Data(contentsOf: imageUrl) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
          //  UserimageView.image = UIImage(data: data!)
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: imageUrl) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                DispatchQueue.main.async {
                    self.UserimageView.image = UIImage(data: data!)
                }
            }
        }
        
    }
    
    
    @IBAction func LogOutBtnAction(_ sender: Any) {
        GIDSignIn.sharedInstance().signOut()
        self.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


