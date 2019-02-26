//
//  MainVC.swift
//  UserViewer
//
//  Created by Sam Paterson on 10/02/19.
//  Copyright © 2019 Sam Paterson. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {

    @IBOutlet weak var background: UIView!
    
    @IBOutlet weak var xBackgroundConstraint: NSLayoutConstraint!
    @IBOutlet weak var yBackgroundConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        background.layer.cornerRadius = 10
//        background.layer.masksToBounds = true
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
////        let tempConstraintX = xBackgroundConstraint.constant
////        let tempConstraintY = yBackgroundConstraint.constant
////        xBackgroundConstraint.constant = 50
////        yBackgroundConstraint.constant = 50
        self.background.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            self.background.transform = CGAffineTransform(scaleX: 1, y: 1)
        }) { (finished) in
            print("popup opened")
        }
        
        
    }

    @IBAction func AutoPopData(_ sender: Any) {
        guard let testUsersUrl = Bundle.main.path(forResource: "TestUsers", ofType: "json")else{
            print("Error with test url")
            return
        }
        Model.instance.loadUsersFromJSON(fileUrl: URL(fileURLWithPath: testUsersUrl))
    }
    @IBAction func ClearData(_ sender: Any) {
        Model.instance.users.removeAll()
        Model.instance.savetoJSON()
        
    }
    @IBAction func CloseSettings(_ sender: Any) {
        view.removeFromSuperview()
    }
}
