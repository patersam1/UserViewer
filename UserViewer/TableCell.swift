//
//  TableCell.swift
//  UserViewer
//
//  Created by Sam Paterson on 17/02/19.
//  Copyright © 2019 Sam Paterson. All rights reserved.
//

import UIKit

class TableCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    var cellKey: String?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tappedCell))
        addGestureRecognizer(tapGesture)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(name: String, email: String){
        cellKey = name.replacingOccurrences(of: " ", with: "")
        nameLabel.text = name
        emailLabel.text = email
    }
    @objc func tappedCell(){
        //call the model with the cell key and open new view window
    }

}
