//
//  DisplacementsViewController.swift
//  Physics
//
//  Created by Calvin Schofield on 11/6/15.
//  Copyright © 2015 Calvin Schofield. All rights reserved.
//

import UIKit

class DisplacementsViewController: UIViewController, UITextFieldDelegate {

    
    //MARK: - Local Variables
    var physics = Physics()
    
    
    //MARK: - IBActions / IBOutlets
    @IBOutlet weak var yDisplacementTextField: UITextField!
    
    @IBOutlet weak var xDisplacementTextField: UITextField!
    
    @IBOutlet weak var sliderTimeLabel: UILabel!
    
    @IBOutlet weak var initialVelocityLabel: UILabel!
    
    @IBOutlet weak var InitialVelocityAngleLabel: UILabel!
    
    @IBOutlet weak var finalVelocityLabel: UILabel!
    
    @IBOutlet weak var finalVelocityAngleLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var maxHeightLabel: UILabel!
    
    @IBOutlet weak var verticalInitialVelocityLabel: UILabel!
    
    @IBOutlet weak var verticalDisplacementLabel: UILabel!
    
    @IBOutlet weak var verticalFinalVelocityLabel: UILabel!
    
    @IBOutlet weak var horizantalInitialVelocityLabel: UILabel!
    
    @IBOutlet weak var horizantalDisplacementLabel: UILabel!
    
    @IBOutlet weak var horizantalFinalVelocityLabel: UILabel!
    
    @IBOutlet weak var timeSlider: UISlider!
    
    @IBAction func timeSlider(sender: AnyObject) {
    
        if let yDisplacement = Double(yDisplacementTextField.text!) {
            
            if let xDisplacement = Double(xDisplacementTextField.text!) {
                
                    physics.recalculateDisplacements(CGFloat(timeSlider.value), degree: 0, xDisplacement: CGFloat(xDisplacement), yDisplacement: CGFloat(yDisplacement))
                    
                    displayRecalculations()
                    
                    sliderTimeLabel.text = String(round(100 * timeSlider.value) / 100) + " sec"
                
            }
                
        }
            
    }
    
    
    @IBAction func solveButton(sender: AnyObject) {
    
        solve()
        
    
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.xDisplacementTextField.delegate = self
        
        self.yDisplacementTextField.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - Function : solve for physics
    func solve() {
        
        if let yDisplacement = Double(yDisplacementTextField.text!) {
            
            if let xDisplacement = Double(xDisplacementTextField.text!) {
                        
                    physics = Physics(degree: 0, xDisplacement: CGFloat(xDisplacement), yDisplacement: CGFloat(yDisplacement))
                        
                    displayData()
                        
                    timeSlider.value = Float(physics.time!)
                
            }
            
        }
        
    }
    
    
    //MARK: - Function : display data
    func displayData() {
        
        initialVelocityLabel.text = "Initial Velocity: " + String(round(1000 * physics.VectorVelocity) / 1000) + " m/s"
        
        InitialVelocityAngleLabel.text = "Angle: " + String(round(1000 * physics.degrees) / 1000) + "º"
        
        finalVelocityLabel.text = "Final Velocity: " + String(round(1000 * physics.finalVectorVelocity) / 1000) + " m/s"
        
        finalVelocityAngleLabel.text = "Angle of Final Velocity Vector: " + String(round(1000 * physics.finalDegrees) / 1000) + "º"
        
        timeLabel.text = "Time: " + String(round(1000 * physics.time!) / 1000) + " sec"
        
        maxHeightLabel.text = "Max Height: " + String(round(1000 * physics.MaxHeight!) / 1000) + " m at " + (String(round(1000 * physics.maxHeightTime!) / 1000)) + " sec"
        
        verticalInitialVelocityLabel.text = "Vertical Velocity: " + String(round(1000 * physics.yInitialVelovity!) / 1000) + " m/s"
        
        verticalDisplacementLabel.text = "Vertical Displacement: " + String(round(1000 * physics.yDisplacement!) / 1000) + " m"
        
        verticalFinalVelocityLabel.text = "Vertical Final Velocity: " + String(round(1000 * physics.yFinalVelocity!) / 1000) + " m/s"
        
        horizantalInitialVelocityLabel.text = "Horizantal Velocity: " + String(round(1000 * physics.xInitialVelocity!) / 1000) + " m/s"
        
        horizantalDisplacementLabel.text = "Horizantal Displacement: " + String(round(1000 * physics.xDisplacement!) / 1000) + " m"
        
        horizantalFinalVelocityLabel.text = "Horizantal Final Velocity: " + String(round(1000 * physics.xFinalVelocity!) / 1000) + " m/s"
        
        sliderTimeLabel.text = String(round(1000 * physics.time!) / 1000) + " sec"
        
        timeSlider.maximumValue = abs(Float(physics.time!))
        
        timeSlider.minimumValue = 0
        
    }
    
    
    //MARK: - Function : Displays recalculated data
    func displayRecalculations() {
        
        initialVelocityLabel.text = "Initial Velocity: " + String(round(1000 * physics.VectorVelocity) / 1000) + " m/s"
        
        InitialVelocityAngleLabel.text = "Angle: " + String(round(1000 * physics.degrees) / 1000) + "º"
        
        finalVelocityLabel.text = "Final Velocity: " + String(round(1000 * physics.finalVectorVelocity) / 1000) + " m/s"
        
        finalVelocityAngleLabel.text = "Angle of Final Velocity Vector: " + String(round(1000 * physics.finalDegrees) / 1000) + "º"
        
        timeLabel.text = "Time: " + String(round(1000 * physics.time!) / 1000) + " sec"
        
        verticalInitialVelocityLabel.text = "Vertical Velocity: " + String(round(1000 * physics.yInitialVelovity!) / 1000) + " m/s"
        
        verticalDisplacementLabel.text = "Vertical Displacement: " + String(round(1000 * physics.yDisplacement!) / 1000) + " m"
        
        verticalFinalVelocityLabel.text = "Vertical Final Velocity: " + String(round(1000 * physics.yFinalVelocity!) / 1000) + " m/s"
        
        horizantalInitialVelocityLabel.text = "Horizantal Velocity: " + String(round(1000 * physics.xInitialVelocity!) / 1000) + " m/s"
        
        horizantalDisplacementLabel.text = "Horizantal Displacement: " + String(round(1000 * physics.xDisplacement!) / 1000) + " m"
        
        horizantalFinalVelocityLabel.text = "Horizantal Final Velocity: " + String(round(1000 * physics.xFinalVelocity!) / 1000) + " m/s"
        
        sliderTimeLabel.text = String(round(1000 * physics.time!) / 1000) + " sec"
        
        timeSlider.maximumValue = abs(Float(physics.time!))
        
        timeSlider.minimumValue = 0
        
    }
    
    
    //MARK: - Controlling Keyboard
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }

    
    //MARK: - Controlling Keyboard
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        xDisplacementTextField.resignFirstResponder()
                
        yDisplacementTextField.resignFirstResponder()
        
        return true
        
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "displacementsHow" {
            
            let howVC = segue.destinationViewController as! howDisplayController
            
            howVC.physics = physics
            
            howVC.identity = 2
            
        }
        
    }

}
