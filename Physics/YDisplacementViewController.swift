//
//  YDisplacementViewController.swift
//  Physics
//
//  Created by Calvin Schofield on 10/29/15.
//  Copyright © 2015 Calvin Schofield. All rights reserved.
//

import UIKit

class YDisplacementViewController: UIViewController, UITextFieldDelegate {

    
    //MARK: - Local Variables
    var physics = Physics()
        
    
    //MARK: - IBActions / IBOutlets
    @IBOutlet weak var scrollView: UIScrollView!
   
    @IBOutlet weak var initialVelocityTextField: UITextField!
    
    @IBOutlet weak var angleTextField: UITextField!
    
    @IBOutlet weak var yDisplacementTextField: UITextField!
    
    @IBOutlet weak var initialVelocityLabel: UILabel!
    
    @IBOutlet weak var angleLabel: UILabel!
    
    @IBOutlet weak var finalVelocityLabel: UILabel!
    
    @IBOutlet weak var finalAngleLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var verticalVelocityLabel: UILabel!
    
    @IBOutlet weak var verticalDisplacementLable: UILabel!
    
    @IBOutlet weak var verticalFinalVelocityLabel: UILabel!
    
    @IBOutlet weak var maxHeightLabel: UILabel!
    
    @IBOutlet weak var horizantalVelocityLabel: UILabel!
    
    @IBOutlet weak var horizantalDisplacementLabel: UILabel!
        
    @IBOutlet weak var horizantalFinalVelocityLabel: UILabel!
    
    @IBOutlet weak var totalTimeLabel: UILabel!
    
    @IBOutlet weak var timeSliderOutlet: UISlider!
    
    @IBAction func timeSlider(sender: AnyObject) {
    
        if let initialVelocity = Double(initialVelocityTextField.text!) {
            
            if let angle = Double(angleTextField.text!) {
                
                if let xDisplacement = Double(yDisplacementTextField.text!) {
                    
                    physics.recalculateYDisplacement(CGFloat(timeSliderOutlet.value), VectorVelocity: CGFloat(initialVelocity), degree: CGFloat(angle), yDisplacement: CGFloat(xDisplacement))
                    
                    displayRecalculations()
                    
                    timeLabel.text = "Time: " + String(round(100 * timeSliderOutlet.value) / 100) + " s"
                    
                }
                
            }
            
        }
        
    }
    
    @IBAction func solveButton(sender: AnyObject) {
    
        solve()
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.initialVelocityTextField.delegate = self
        
        self.yDisplacementTextField.delegate = self
        
        self.angleTextField.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - Function : function to solve everything
    func solve() {
        
        if let initialVelocity = Double(initialVelocityTextField.text!) {
            
            if let angle = Double(angleTextField.text!) {
                
                if let yDisplacement = Double(yDisplacementTextField.text!) {
                    
                    physics = Physics(VectorVelocity: CGFloat(initialVelocity), degree: CGFloat(angle), yDisplacement: abs(CGFloat(yDisplacement)))
                    
                    displayData()
                    
                    timeSliderOutlet.value = Float(physics.time!)
                    
                }
                
            }
            
        }
        
    }
    
    
    //MARK: = Function : function to display data
    func displayData() {
        
        initialVelocityLabel.text = "Initial Velocity: " + String(round(1000 * physics.VectorVelocity) / 1000) + " m/s"
        
        angleLabel.text = "Angle: " + String(round(1000 * physics.degrees) / 1000) + "º"
        
        finalVelocityLabel.text = "Final Velocity: " + String(round(1000 * physics.finalVectorVelocity) / 1000) + " m/s"
        
        finalAngleLabel.text = "Angle of Final Velocity Vector: " + String(round(1000 * physics.finalDegrees) / 1000) + "º"
        
        timeLabel.text = "Time: " + String(round(1000 * physics.time!) / 1000) + " sec"
        
        maxHeightLabel.text = "Max Height: " + String(round(1000 * physics.MaxHeight!) / 1000) + " m at " + (String(round(1000 * physics.maxHeightTime!) / 1000)) + " sec"
        
        verticalVelocityLabel.text = "Vertical Velocity: " + String(round(1000 * physics.yInitialVelovity!) / 1000) + " m/s"
        
        verticalDisplacementLable.text = "Vertical Displacement: " + String(round(1000 * physics.yDisplacement!) / 1000) + " m"
        
        verticalFinalVelocityLabel.text = "Vertical Final Velocity: " + String(round(1000 * physics.yFinalVelocity!) / 1000) + " m/s"
        
        horizantalVelocityLabel.text = "Horizantal Velocity: " + String(round(1000 * physics.xInitialVelocity!) / 1000) + " m/s"
        
        horizantalDisplacementLabel.text = "Horizantal Displacement: " + String(round(1000 * physics.xDisplacement!) / 1000) + " m"
        
        horizantalFinalVelocityLabel.text = "Horizantal Final Velocity: " + String(round(1000 * physics.xFinalVelocity!) / 1000) + " m/s"
        
        totalTimeLabel.text = String(round(1000 * physics.time!) / 1000) + " sec"
        
        timeSliderOutlet.maximumValue = abs(Float(physics.time!))
        
        timeSliderOutlet.minimumValue = 0
        
    }
    
    
    //MARK: - Function : Displays recalculated data
    func displayRecalculations() {
        
        initialVelocityLabel.text = "Initial Velocity: " + String(round(1000 * physics.VectorVelocity) / 1000) + " m/s"
        
        angleLabel.text = "Angle: " + String(round(1000 * physics.degrees) / 1000) + "º"
        
        finalVelocityLabel.text = "Final Velocity: " + String(round(1000 * physics.finalVectorVelocity) / 1000) + " m/s"
        
        finalAngleLabel.text = "Angle of Final Velocity Vector: " + String(round(1000 * physics.finalDegrees) / 1000) + "º"
        
        timeLabel.text = "Time: " + String(round(1000 * physics.time!) / 1000) + " sec"
        
        verticalVelocityLabel.text = "Vertical Velocity: " + String(round(1000 * physics.yInitialVelovity!) / 1000) + " m/s"
        
        verticalDisplacementLable.text = "Vertical Displacement: " + String(round(1000 * physics.yDisplacement!) / 1000) + " m"
        
        verticalFinalVelocityLabel.text = "Vertical Final Velocity: " + String(round(1000 * physics.yFinalVelocity!) / 1000) + " m/s"
        
        horizantalVelocityLabel.text = "Horizantal Velocity: " + String(round(1000 * physics.xInitialVelocity!) / 1000) + " m/s"
        
        horizantalDisplacementLabel.text = "Horizantal Displacement: " + String(round(1000 * physics.xDisplacement!) / 1000) + " m"
        
        horizantalFinalVelocityLabel.text = "Horizantal Final Velocity: " + String(round(1000 * physics.xFinalVelocity!) / 1000) + " m/s"
        
        totalTimeLabel.text = String(round(1000 * physics.time!) / 1000) + " sec"
        
        timeSliderOutlet.maximumValue = abs(Float(physics.time!))
        
        timeSliderOutlet.minimumValue = 0
        
    }

    
    //MARK: - Controlling Keyboard
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        initialVelocityTextField.resignFirstResponder()
        
        angleTextField.resignFirstResponder()
        
        yDisplacementTextField.resignFirstResponder()
        
        return true
        
    }
    
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "yDisplacementHow" {
            
            let howVC = segue.destinationViewController as! howDisplayController
            
            howVC.physics = physics
            
            howVC.identity = 0
            
        }
        
    }

}
