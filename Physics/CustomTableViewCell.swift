//
//  CustomTableViewCell.swift
//  Physics
//
//  Created by Calvin Schofield on 10/31/15.
//  Copyright © 2015 Calvin Schofield. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    //MARK: - IBActions / IBOutlets
    @IBOutlet weak var verticalEquation: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    //MARK: - Local Variables
    var horizantalEquationsArray = [UIImage(named: "displacement.png"), UIImage(named: "velocityFinal.png"), UIImage(named: "velocitySquared.png"), UIImage(named: "averageVelocity.png")]
    
    var descriptions = ["The relationship between displacement and time when considering initial velocity and acceleration", "Shows final velocity as a result of initial velocity added to total time multiplied by acceleration", "Demonstrates the relationship between final velocity and initial velocity with regardds to acceleration and displacement", "Average velocity as a result of final velocity plus initial velocity divided by two"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
