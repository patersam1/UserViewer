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
        var errorCount = 0
        errorCount = textFieldCheck(fNameTextField, errorCount: errorCount)
        errorCount = textFieldCheck(lNameTextField, errorCount: errorCount)
        errorCount = textFieldCheck(ageTextField, errorCount: errorCount)
        errorCount = textFieldCheck(emailTextField, errorCount: errorCount)
        if (errorCount > 0){
            //stops the submission if something is missing
             return
        }
        
        //submit to model
        if(!Model.instance.addUser(fName: fNameTextField.text!, lName: lNameTextField.text!, age: ageTextField.text!, email: emailTextField.text!)){
            //add user failed
        }
        //pop vc from navigation controller
        let navController = self.navigationController!
        print(navController.viewControllers)
        self.dismiss(animated: true, completion: nil)
        navController.popViewController(animated: true)
        
        print(navController.viewControllers)
        
    }
    
    func textFieldCheck(_ textField: UITextField, errorCount: Int)-> Int{
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.red,
        ]
        if (textField.text == ""){
            textField.attributedPlaceholder =
                NSAttributedString(string: "*", attributes: attributes)
            return errorCount + 1
        }else{
            textField.placeholder = ""
        }
        
       return errorCount
    }
    

}
