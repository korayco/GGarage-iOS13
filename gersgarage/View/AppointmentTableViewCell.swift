//
//  AppointmentTableViewCell.swift
//  gersgarage
//
//  Created by taylanakbas on 14.08.2021.
//

import UIKit

class AppointmentTableViewCell: UITableViewCell {

    @IBOutlet weak var serviceType: UILabel!
    @IBOutlet weak var serviceStatus: UIImageView!
    @IBOutlet weak var date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
