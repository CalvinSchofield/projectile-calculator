//
//  EquationsExplanationsViewController.swift
//  Physics
//
//  Created by Calvin Schofield on 1/20/16.
//  Copyright © 2016 Calvin Schofield. All rights reserved.
//

import UIKit

class EquationsExplanationsViewController: UIViewController {

    var titleLabelData = ["Displacement", "Final Velocity", "Velocity Squared", "Average Velocity"]
    
    var index = 0
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        titleLabel.text = titleLabelData[index]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
