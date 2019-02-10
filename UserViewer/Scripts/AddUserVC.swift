//
//  MainVC.swift
//  UserViewer
//
//  Created by Sam Paterson on 10/02/19.
//  Copyright © 2019 Sam Paterson. All rights reserved.
//

import UIKit

class AddUserVC: UIViewController {

    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet var betweenConstraints: [NSLayoutConstraint]!
    
    @IBOutlet weak var fNameTextField: UITextField!
    @IBOutlet weak var lNameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if (UIDevice.current.orientation.isLandscape){
            //change constraint to 20
            topConstraint.constant = 40
            for con in betweenConstraints{
                con.constant /= 2
            }
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if (UIDevice.current.orientation.isLandscape){
            //change constraint to 20
            topConstraint.constant = 40
            for con in betweenConstraints{
                con.constant /= 2
            }
        }else{
            //change constraint to 120
            topConstraint.constant = 120
            for con in betweenConstraints{
                con.constant *= 2
            }
        }
        view.layoutIfNeeded()
    }
    

    @IBAction func SubmitUser(_ sender: Any) {
        //submit to model
        if(!Model.instance.addUser(fName: fNameTextField.text!, lName: lNameTextField.text!, age: ageTextField.text!, email: emailTextField.text!)){
            //add user failed
        }
        //pop vc from navigation controller
        let navController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "NavController") as? UINavigationController
        print(navController?.viewControllers)
        navController?.popViewController(animated: true)
        print(navController?.viewControllers)
        
    }
    

}
