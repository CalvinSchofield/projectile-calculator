//
//  howDisplacementAngleViewController.swift
//  Physics
//
//  Created by Calvin Schofield on 11/7/15.
//  Copyright © 2015 Calvin Schofield. All rights reserved.
//

import UIKit

class howDisplacementAngleViewController: UIViewController {

    
    //MARK: - IBActions / IBOutelts
    @IBOutlet weak var timeLAbel: UILabel!
    
    @IBOutlet weak var timeImage: UIImageView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
       timeLAbel.text = "1: Find Time\n\t\tThe first step, regardless of the information your given, is to find time. These types of questions are particularly hard to solve, becuase it takes lots of steps to eventually cancel out variables. Essentially, you solve for time just to solve for the initial velocity so that you can find time in the end. I'll save you a headache and not try to explain this complexity, but understand that multiple steps are needed to solve for time which will only give you initial velocity which you can then find time, and everything else.\n\nBelow is an example worked out finding time, once time is found, the problem is easy to solve."
        
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
