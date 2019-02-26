//
//  MainVC.swift
//  UserViewer
//
//  Created by Sam Paterson on 10/02/19.
//  Copyright © 2019 Sam Paterson. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let docUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
        let fileUrl = docUrl.appendingPathComponent("Users.json")
        Model.instance.loadUsersFromJSON(fileUrl: fileUrl)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func openSettings(_ sender: Any){
        let settingsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SettingsVC") as! SettingsVC
        self.addChild(settingsVC)
        settingsVC.view.frame = self.view.frame
        self.view.addSubview(settingsVC.view)
        
    }
}
