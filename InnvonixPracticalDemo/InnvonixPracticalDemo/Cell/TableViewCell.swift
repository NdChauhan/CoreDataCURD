//
//  TableViewCell.swift
//  InnvonixPracticalDemo
//
//  Created by Nidhi Chauhan on 31/05/23.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    //MARK: veriables & outlets
    
    @IBOutlet weak var labelfirstName: UILabel!
    @IBOutlet weak var labellastname: UILabel!
    @IBOutlet weak var labelemail: UILabel!
    @IBOutlet weak var labelMobileno: UILabel!
    @IBOutlet weak var viewMainView: UIView!
    
    //MARK: didset method
    
    var user:UserData! {
        didSet {
            labelfirstName.text = "FirstName: " + (user.firstname ?? "")
            labellastname.text = "LastName: " + (user.lastname ?? "")
            labelMobileno.text = "MobileNo: " + (user.mobileno ?? "")
            labelemail.text = "Email: " + (user.email ?? "")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
