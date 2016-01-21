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
    
    var currentUnit : Units = .InternationalSystem
    
    
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
    
    @IBOutlet weak var metricButtonOutlet: UIButton!
    
    @IBOutlet weak var internationalButtonOutlet: UIButton!
    
    @IBAction func metricButton(sender: AnyObject) {
    
        currentUnit = .MetricSystem
        
        physics.currentUnits  = currentUnit
        
        metricButtonOutlet.backgroundColor = UIColor(red: 255/255, green: 150/255, blue: 150/255, alpha: 1.0)
        
        internationalButtonOutlet.backgroundColor = UIColor(red: 150/255, green: 150/255, blue: 255/255, alpha: 1.0)
        
    }
    
    @IBAction func internationalButton(sender: AnyObject) {
    
        currentUnit = .InternationalSystem
        
        physics.currentUnits = currentUnit
        
        internationalButtonOutlet.backgroundColor = UIColor(red: 255/255, green: 150/255, blue: 150/255, alpha: 1.0)
        
        metricButtonOutlet.backgroundColor = UIColor(red: 150/255, green: 150/255, blue: 255/255, alpha: 1.0)
        
    }
    
    @IBOutlet weak var totalTimeLabel: UILabel!
    
    @IBOutlet weak var timeSliderOutlet: UISlider!
    
    @IBAction func timeSlider(sender: AnyObject) {
    
        if let initialVelocity = Double(initialVelocityTextField.text!) {
            
            if let angle = Double(angleTextField.text!) {
                
                if let yDisplacement = Double(yDisplacementTextField.text!) {
                    
                    physics.recalculateYDisplacement(CGFloat(timeSliderOutlet.value), VectorVelocity: CGFloat(initialVelocity), degree: CGFloat(angle), yDisplacement: CGFloat(yDisplacement), currentUnit: currentUnit)
                    
                    if physics.canBeSolved {
                    
                        displayRecalculations()
                    
                        timeLabel.text = "Time: " + String(round(100 * timeSliderOutlet.value) / 100) + " s"
                        
                    } else {
                        
                        print("Error - or something went wrong")
                        
                    }
                    
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
                    
                    physics = Physics(VectorVelocity: CGFloat(initialVelocity), degree: CGFloat(angle), yDisplacement: CGFloat(yDisplacement), currentUnits: currentUnit)
                    
                    if physics.canBeSolved {
                    
                        displayData()
                    
                        timeSliderOutlet.value = Float(physics.time!)
                        
                    } else {
                        
                        print("Error - not possible, or something is wrong")
                        
                    }
    
                    
                }
                
            }
            
        }
        
    }
    
    
    //MARK: = Function : function to display data
    func displayData() {
        
        print(currentUnit)
        
        switch physics.currentUnits {
            
        case .InternationalSystem:
            
            displayInternational()
            
        case .MetricSystem:
            
            displayMetric()
            
        }
        
        totalTimeLabel.text = String(round(1000 * physics.time!) / 1000) + " sec"
        
        timeSliderOutlet.maximumValue = Float(physics.time!)
        
        timeSliderOutlet.minimumValue = 0
        
    }
    
    
    //MARK: - Function : Displays recalculated data
    func displayRecalculations() {
        
        switch physics.currentUnits {
            
            case .InternationalSystem:
            
                displayInternational()
            
            case .MetricSystem:
            
                displayMetric()
            
        }

        totalTimeLabel.text = String(round(1000 * physics.time!) / 1000) + " sec"
        
        timeSliderOutlet.maximumValue = Float(physics.time!)
        
        timeSliderOutlet.minimumValue = 0
        
    }
    
    
    func displayInternational() {
        
        initialVelocityLabel.text = "Initial Velocity: " + String(round(1000 * physics.VectorVelocity) / 1000) + " m/s"
        
        angleLabel.text = "Angle: " + String(round(1000 * physics.degrees) / 1000) + "º"
        
        finalVelocityLabel.text = "Final Velocity: " + String(round(1000 * physics.finalVectorVelocity) / 1000) + " m/s"
        
        finalAngleLabel.text = "Angle of Final Velocity Vector: " + String(round(1000 * physics.finalDegrees) / 1000) + "º"
        
        timeLabel.text = "Time: " + String(round(1000 * physics.time!) / 1000) + " sec"
        
        maxHeightLabel.text = "Max Height: " + String(round(1000 * physics.yMaxHeight!) / 1000) + " m  at " + String(round(1000 * physics.maxHeightTime!) / 1000) + " sec"
        
        verticalVelocityLabel.text = "Vertical Velocity: " + String(round(1000 * physics.yInitialVelovity!) / 1000) + " m/s"
        
        verticalDisplacementLable.text = "Vertical Displacement: " + String(round(1000 * physics.yDisplacement!) / 1000) + " m"
        
        verticalFinalVelocityLabel.text = "Vertical Final Velocity: " + String(round(1000 * physics.yFinalVelocity!) / 1000) + " m/s"
        
        horizantalVelocityLabel.text = "Horizantal Velocity: " + String(round(1000 * physics.xInitialVelocity!) / 1000) + " m/s"
        
        horizantalDisplacementLabel.text = "Horizantal Displacement: " + String(round(1000 * physics.xDisplacement!) / 1000) + " m"
        
        horizantalFinalVelocityLabel.text = "Horizantal Final Velocity: " + String(round(1000 * physics.xFinalVelocity!) / 1000) + " m/s"
        
    }
    
    
    func displayMetric() {
        
        initialVelocityLabel.text = "Initial Velocity: " + String(round(1000 * physics.VectorVelocity) / 1000) + " ft/s"
        
        angleLabel.text = "Angle: " + String(round(1000 * physics.degrees) / 1000) + "º"
        
        finalVelocityLabel.text = "Final Velocity: " + String(round(1000 * physics.finalVectorVelocity) / 1000) + " ft/s"
        
        finalAngleLabel.text = "Angle of Final Velocity Vector: " + String(round(1000 * physics.finalDegrees) / 1000) + "º"
        
        timeLabel.text = "Time: " + String(round(1000 * physics.time!) / 1000) + " sec"
        
        maxHeightLabel.text = "Max Height: " + String(round(1000 * physics.yMaxHeight!) / 1000) + " ft  at " + String(round(1000 * physics.maxHeightTime!) / 1000) + " sec"
        
        verticalVelocityLabel.text = "Vertical Velocity: " + String(round(1000 * physics.yInitialVelovity!) / 1000) + " ft/s"
        
        verticalDisplacementLable.text = "Vertical Displacement: " + String(round(1000 * physics.yDisplacement!) / 1000) + " ft"
        
        verticalFinalVelocityLabel.text = "Vertical Final Velocity: " + String(round(1000 * physics.yFinalVelocity!) / 1000) + " ft/s"
        
        horizantalVelocityLabel.text = "Horizantal Velocity: " + String(round(1000 * physics.xInitialVelocity!) / 1000) + " ft/s"
        
        horizantalDisplacementLabel.text = "Horizantal Displacement: " + String(round(1000 * physics.xDisplacement!) / 1000) + " ft"
        
        horizantalFinalVelocityLabel.text = "Horizantal Final Velocity: " + String(round(1000 * physics.xFinalVelocity!) / 1000) + " ft/s"
        
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
