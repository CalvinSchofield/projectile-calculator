//
//  EquationsExplanationsViewController.swift
//  Physics
//
//  Created by Calvin Schofield on 1/20/16.
//  Copyright © 2016 Calvin Schofield. All rights reserved.
//

import UIKit

class EquationsExplanationsViewController: UIViewController {


    //Local Variables
    var titleLabelData = ["Displacement", "Final Velocity", "Velocity Squared", "Average Velocity"]

    var horizantalEquationsArray = [UIImage(named: "displacement.png"), UIImage(named: "velocityFinal.png"), UIImage(named: "velocitySquared.png"), UIImage(named: "averageVelocity.png")]
    
    var descriptions = ["The relationship between displacement and time when considering initial velocity and acceleration\n\nThis equation will be one of the most important equations of kinematics used to observe the motion of objects. Using time and initial velocity coupled with the acceleration of gravity that acts upon all objects, we can determine the displacement of an object as a result of time. Using simple algebra, we can find any of the other variables using what was given.",
        "Shows final velocity as a result of initial velocity added to total time multiplied by acceleration",
        "Demonstrates the relationship between final velocity and initial velocity with regardds to acceleration and displacement",
        "Average velocity as a result of final velocity plus initial velocity divided by two"]
    
    var index = 0
    
    
    //IBOutlets & IBActions
    @IBOutlet weak var equationImage: UIImageView!
    
    @IBOutlet weak var descriptionLabel: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
                
        equationImage.image = horizantalEquationsArray[index]
        
        descriptionLabel.text = descriptions[index]
        
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
