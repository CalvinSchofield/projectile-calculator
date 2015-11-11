//
//  howDisplayController.swift
//  Physics
//
//  Created by Calvin Schofield on 11/5/15.
//  Copyright © 2015 Calvin Schofield. All rights reserved.
//

import UIKit

class howDisplayController: UIViewController {

    
    //MARK: - IBActions / IBOutelts
    @IBOutlet weak var timeExplanationLabel: UILabel!
    
    @IBOutlet weak var displacementExplanationLabel: UILabel!
    
    @IBOutlet weak var maxHeightTimeLabel: UILabel!

    @IBOutlet weak var maxHeightLabel: UILabel!
    
    @IBOutlet weak var graphImage: UIImageView!
    
    @IBOutlet weak var totalTimeGraph: UILabel!
    
    @IBOutlet weak var noYDisplacementMaxHeight: UILabel!

    @IBOutlet weak var yDisplacementMaxHeight: UILabel!
    
    @IBOutlet weak var noAngleMaxHeight: UILabel!
    
    @IBOutlet weak var yDisplacementGraph: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    //MARK: - Local Variables
    var physics = Physics()
    
    var identity = Int()
    
    var timeExplanation = [String]()
    
    var displacementExplanation = [String]()
    
    var maxHeightTimeExplanation = [String]()
    
    var maxHeightExplanation = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setUp()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - Function : set up ViewController
    func setUp() {
        
        if physics.MaxHeight != nil {
            
            timeExplanation = [
                "1: Find Time\n\t\tFirst step always is to solve for time. Once you have time, you can find anything else. Since you know all the necessary vertical components to find time, set up the formula\n\t\tdisplacement = initial velocity * time + (acceleration * time^2) / 2\n\t\tIn the equation - displacement equals your vertical displacement, initial velocity equals the Vertical Component of the initial velocity, and the acceleration equals the acceleration of the y-axis (gravity : -9.8 m/s^2). In this case:\n\t\t\(round(100 * (physics.yDisplacement!) / 100)) = \(round(100 * (physics.yInitialVelovity!) / 100)) * time + (\(physics.yAcceleration!) * (time^2)) / 2\n\t\tIn the end, time equals \(round(100 * physics.time!) / 100) seconds",
                "1: Find Time\n\t\tYour first step should always be to find time. Since you know all the necessary horizantal components, set up the formula\n\t\tdisplacement = initial velocity * time\n\t\tIn the equation - displacement equals your horizantal displacement and initial velocity equals the Horizantal Component of the initial velocity. In this case:\n\t\t\(round(100 * (physics.xDisplacement!) / 100)) = \(round(100 * (physics.xInitialVelocity!) / 100)) * time\n\t\tIn the end, time equals \(round(100 * physics.time!) / 100) seconds",
                "1: Find Time\n\t\tAlways solve for time as the first step. Unfortunately, this calculator can only solve for time with given Vertical and Horizantal Displacements IF the angle is 0, thus horizntal projectile problems (think a ball rolling of a table). The first step is to plug in what you know - if the angle is 0, then the Vertical Velocity in the Y-Direction is 0. Using the equation displacement = initial velocity * time + (acceleration * time^2) / 2:\n\n\t\t\(round(100 * (physics.yDisplacement!) / 100)) =  0 * time + (\(physics.yAcceleration!) * (time^2)) / 2\n\n\t\tIn the end we find time = \(round(100 * physics.time!) / 100) seconds"]
            
            timeExplanationLabel.text = timeExplanation[identity]
            
            
            displacementExplanation = ["2: Solve for Horizantal Displacement\n\t\tAfter finding the total time of the projectile, you can use the same equation to find total Horizantal Displacement. This time, use the Horizantal Component of the initial velocity and set time equal to the total time you just found above. Notice how acceleration is not used - this is because for these questions, horizantal acceleration does not exist (think friction). In the end, your just left with the equation\n\n\t\tdisplacement = initial velocity * time\n\n\t\tPlugging in the variables for what you know, you get\n\n\t\thorizantal displacement = \(round(100 * physics.xInitialVelocity!) / 100) * \(round(100 * physics.time!) / 100)\n\nWhen all is said and done, horizantal displacement equals \(round(100 * physics.xDisplacement!) / 100)",
                "2: Solve for Vertical Displacement\n\t\tThe same equation above can be used to find Vertical Displacement. This time, use the Vertical Component of the initial velocity and set time equal to the total time you just found above. In the end, your left with the equation\n\n\t\tdisplacement = initial velocity * time + (acceleration * time^2) / 2\n\n\t\tPlugging in the variables for what you know, you get\n\n\t\tvertical displacement = = \(round(100 * (physics.yInitialVelovity!) / 100)) * \(round(100 * (physics.time!) / 100)) + (\((physics.yAcceleration!)) * (\(round(100 * (physics.time!) / 100)) * \(round(100 * (physics.time!) / 100))\n\nWhen all is said and done, vertical displacement equals \(round(100 * physics.xDisplacement!) / 100)",
                "Temporary Text"]
            
            displacementExplanationLabel.text = displacementExplanation[identity]
            
            
            maxHeightTimeExplanation = ["3-A: Finding time of Max Height\n\t\tSolving for max height is really pretty simple when visualizing the path of the projectile. Max height will be at exactly one half of the total time WHEN the projectile starts and ends at ground level. If the displacement is greater than 0 (think shooting something of of a cliff), we will need to find time when the Vertical Displacement is equal to 0\n\n\t\tdisplacement = initial velocity * time + (acceleration * (time * time)) / 2\n\n\t\tAgain, pluggin in all the Vertical known components, except this time, set the displacement equal to 0 no matter what.\n\n\t\t0 = \(round(100 * (physics.yInitialVelovity!) / 100)) * \(round(100 * (physics.time!) / 100)) + (\((physics.yAcceleration!)) * (\(round(100 * (physics.time!) / 100)) * \(round(100 * (physics.time!) / 100))\n\t\tAfter that, we find that our time equals \(round(100 * physics.maxHeightTime!) / 100)",
                "3: Find Max Height\n\t\tSolving for max height is easy if you visualize the projectile. Max height will be at exactly one half of the total time WHEN the projectile starts and ends at ground level. If the displacement is greater than 0 (think shooting something of of a cliff), we will need to find time when the Vertical Displacement is equal to 0\n\n\t\tdisplacement = initial velocity * time + (acceleration * (time * time)) / 2)\n\n\t\tAgain, pluggin in all the Vertical known components, except this time, set the displacement equal to 0 no matter what.\n\n\t\t0 = \(round(100 * (physics.yInitialVelovity!) / 100)) * \(round(100 * (physics.time!) / 100)) + (\((physics.yAcceleration!)) * (\(round(100 * (physics.time!) / 100)) * \(round(100 * (physics.time!) / 100)))\n\t\tAfter that, we find that our time equals \(round(100 * physics.maxHeightTime!) / 100)",
                "Temporary Text"]
            
            maxHeightExplanation = ["3-B: Finding Max Height\n\t\tWith this time at 0 Vertical displacement, we can use the same equation while plugging in exactly one-half of time to find the max height of the parabola.\n\t\tWhen doing this, we get\n\t\tMax Height = \(round(100 * (physics.yInitialVelovity!) / 100)) / 2 * \(round(1000 * (physics.time!) / 1000)) + (\(physics.yAcceleration!) * (\(round(1000 * (physics.time!) / 1000)) / 2 * \(round(100 * (physics.time!) / 100)) / 2) / 2\n\t\tWe find that the Max Height equals \(round(100 * physics.MaxHeight!) / 100)",
                "With this time at 0 Vertical displacement, we can use the same equation while plugging in exactly one-half of time to find the max height of the parabola.\n\t\tWhen doing this, we get\n\t\tMax Height = \(round(100 * (physics.yInitialVelovity!) / 100)) * \(round(1000 * (physics.time!) / 1000)) / 2 + (\(physics.yAcceleration!) * (\(round(1000 * (physics.time!) / 1000)) / 2 * \(round(100 * (physics.time!) / 100)) / 2) / 2\n\t\tWe find that the Max Height equals \(round(100 * physics.MaxHeight!) / 100)",
                "Temporary Text"]
            
            maxHeightTimeLabel.text = maxHeightTimeExplanation[identity]
            
            maxHeightLabel.text = maxHeightExplanation[identity]
            
            
            if physics.yDisplacement! == 0 {
                
                graphImage.image = UIImage(named: "noYDisplacement")
                
                noAngleMaxHeight.text = ""
                
                yDisplacementMaxHeight.text = ""
                
                noYDisplacementMaxHeight.text = String(round(100 * physics.MaxHeight!) / 100) + " m"
                
                yDisplacementGraph.text = ""
                
            } else {
                
                if physics.degrees == 0 && physics.yInitialVelovity! == 0 {
                 
                    graphImage.image = UIImage(named: "noAngle")
                    
                    noAngleMaxHeight.text = String(round(100 * physics.MaxHeight!) / 100) + " m"
                    
                    yDisplacementMaxHeight.text = ""
                    
                    noYDisplacementMaxHeight.text = ""
                    
                    yDisplacementGraph.text = String(round(100 * physics.yDisplacement!) / 100) + " m"
                    
                } else {
                    
                    graphImage.image = UIImage(named: "yDisplacement")
                    
                    noAngleMaxHeight.text = ""
                    
                    yDisplacementMaxHeight.text = String(round(100 * physics.MaxHeight!) / 100) + " m"
                    
                    noYDisplacementMaxHeight.text = ""
                    
                    yDisplacementGraph.text = String(round(100 * physics.yDisplacement!) / 100) + " m"
                    
                }
                
            }
            
            totalTimeGraph.text = String(round(100 * physics.time!) / 100) + " sec"
            
            
            
        } else {
            
            timeExplanationLabel.text = "Enter some data to see an explanation of the answers"
            
            displacementExplanationLabel.text = ""
            
            maxHeightTimeLabel.text = ""
            
            maxHeightLabel.text = ""
            
            yDisplacementGraph.text = ""
            
            noAngleMaxHeight.text = ""
            
            yDisplacementMaxHeight.text = ""
            
            noYDisplacementMaxHeight.text = ""
            
            totalTimeGraph.text = ""
            
        }
        
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
