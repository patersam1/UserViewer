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
    
    @IBOutlet weak var updateButton: UIButton!
    
    @IBOutlet weak var pageTitle: UILabel!
    
    var isViewOnlyKey = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if (UIDevice.current.orientation.isLandscape){
            //change constraint to 20
            topConstraint.constant = 40
            for con in betweenConstraints{
                con.constant /= 2
            }
        }
        if (isViewOnlyKey != ""){
            ViewUserOnly(key: isViewOnlyKey)
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
        print("------submitUser----")
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
        self.dismiss(animated: true, completion: nil)
        navController.popViewController(animated: true)

        
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
    
    func ViewUserOnly(key:String){
        let personData = Model.instance.users[key]!
        let personDataArray = [personData.firstName, personData.lastName, personData.age, personData.email]
        //change button, title label and lock text fields
        var fieldIndex = 0
        for textField in [fNameTextField, lNameTextField, ageTextField, emailTextField]{
            textField?.isUserInteractionEnabled = false
            textField?.text = personDataArray[fieldIndex]
//            textField?.borderStyle = .none
            fieldIndex += 1
        }
        pageTitle.text = "View User"
        updateButton.setTitle("Edit", for: .normal)
        updateButton.removeTarget(nil, action: nil, for: .allEvents)
        updateButton.addTarget(self, action: #selector(EnableEditing), for: .touchUpInside)
        
    }
    
    @objc func EnableEditing(){
        print("------EnableEditing----")
        for textField in [fNameTextField, lNameTextField, ageTextField, emailTextField]{
            textField?.isUserInteractionEnabled = true
        }
        pageTitle.text = "Edit User"
        updateButton.setTitle("Update", for: .normal)
        updateButton.removeTarget(nil, action: nil, for: .allEvents)
        updateButton.addTarget(self, action: #selector(updateUser), for: .touchUpInside)
    }
    
    @objc func updateUser(){
        Model.instance.users.removeValue(forKey: isViewOnlyKey)
        SubmitUser(self)
    }

}
