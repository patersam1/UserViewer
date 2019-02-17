//
//  MainVC.swift
//  UserViewer
//
//  Created by Sam Paterson on 10/02/19.
//  Copyright © 2019 Sam Paterson. All rights reserved.
//

import UIKit

class ViewUsersVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var table: UITableView!
    var keyArray: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        keyArray = Array(Model.instance.userDic.keys)
        
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model.instance.userDic.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! TableCell
        let personData = Model.instance.userDic[keyArray![indexPath.item]]!
        cell.setCell(name: "\(personData[0]) \(personData[1])", email: personData[3])
        return cell
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
