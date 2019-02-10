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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if (UIDevice.current.orientation.isLandscape){
            //change constraint to 20
            topConstraint.constant = 40
            for con in betweenConstraints{
                con.constant /= 2
            }
            print("device is landscape")
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if (UIDevice.current.orientation.isLandscape){
            //change constraint to 20
            topConstraint.constant = 40
            for con in betweenConstraints{
                con.constant /= 2
                print(con)
            }
            print("device is landscape")
        }else{
            //change constraint to 120
            topConstraint.constant = 120
            for con in betweenConstraints{
                con.constant *= 2
            }
            print("device is Potrate")
        }
        view.layoutIfNeeded()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
