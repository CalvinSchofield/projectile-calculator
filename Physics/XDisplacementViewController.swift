//
//  XDisplacementViewController.swift
//  Physics
//
//  Created by Calvin Schofield on 10/29/15.
//  Copyright © 2015 Calvin Schofield. All rights reserved.
//

import UIKit

class XDisplacementViewController: UIViewController, UITextFieldDelegate {

    
    //MARK: - Local Variables
    var physics = Physics()
    
    var currentUnit : Units = .InternationalSystem
    
    
    //MARK: - IBActions / IBOutlets
    @IBOutlet weak var scrollView: UIScrollView!
   
    @IBOutlet weak var initialVelocityTextField: UITextField!
    
    @IBOutlet weak var angleTextField: UITextField!

    @IBOutlet weak var xDisplacementTextField: UITextField!
    
    @IBOutlet weak var initialVelocityLabel: UILabel!
    
    @IBOutlet weak var angleLabel: UILabel!
    
    @IBOutlet weak var finalVectorVelocityLabel: UILabel!
    
    @IBOutlet weak var finalVectorAngle: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var verticalVelocityLabel: UILabel!
    
    @IBOutlet weak var verticalDisplacementLable: UILabel!
    
    @IBOutlet weak var maxHeightLabel: UILabel!
    
    @IBOutlet weak var verticalFinalVelocityLabel: UILabel!
    
    @IBOutlet weak var horizantalVelocityLabel: UILabel!
    
    @IBOutlet weak var horizantalDisplacementLabel: UILabel!
    
    @IBOutlet weak var horizantalFinalVelocityLabel: UILabel!
    
    @IBOutlet weak var totalTimeLabel: UILabel!
    
    @IBOutlet weak var timeSliderOutlet: UISlider!
    
    @IBOutlet weak var metricButtonOutlet: UIButton!
    
    @IBOutlet weak var internationalButtonOutlet: UIButton!
    
    @IBAction func metricButton(sender: AnyObject) {
        
        currentUnit = .MetricSystem
        
        physics.currentUnits  = currentUnit
        
        metricButtonOutlet.backgroundColor = UIColor(red: 233/255, green: 228/255, blue: 183/255, alpha: 1.0)
        
        internationalButtonOutlet.backgroundColor = UIColor.clearColor()
        
        solve()
        
    }
    
    @IBAction func internationalButton(sender: AnyObject) {
        
        currentUnit = .InternationalSystem
        
        physics.currentUnits = currentUnit
        
        internationalButtonOutlet.backgroundColor = UIColor(red: 233/255, green: 228/255, blue: 183/255, alpha: 1.0)
        
        metricButtonOutlet.backgroundColor = UIColor.clearColor()
        
        solve()
        
    }
    
    @IBAction func timeSlider(sender: AnyObject) {
    
        if let initialVelocity = Double(initialVelocityTextField.text!) {
            
            if let angle = Double(angleTextField.text!) {
                
                if let xDisplacement = Double(xDisplacementTextField.text!) {
                    
                    physics.recalculateXDisplacement(CGFloat(timeSliderOutlet.value), VectorVelocity: CGFloat(initialVelocity), degree: CGFloat(angle), xDisplacement: CGFloat(xDisplacement), currentUnit: currentUnit)
                    
                    if physics.canBeSolved {
                    
                        displayRecalculations()
                        
                        timeLabel.text = "Time: " + String(round(100 * timeSliderOutlet.value) / 100) + " s"
                    
                    } else {
                        
                        self.presentViewController(physics.presentErrorAlert(), animated: true, completion: nil)
                        
                    }
                    
                }
                
            }
            
        }
    
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.initialVelocityTextField.delegate = self
        
        initialVelocityTextField.addTarget(self, action: "shouldSolve:", forControlEvents: UIControlEvents.EditingChanged)
        
        self.xDisplacementTextField.delegate = self
        
        xDisplacementTextField.addTarget(self, action: "shouldSolve:", forControlEvents: UIControlEvents.EditingChanged)
        
        self.angleTextField.delegate = self
        
        angleTextField.addTarget(self, action: "shouldSolve:", forControlEvents: UIControlEvents.EditingChanged)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - Function : function to solve everything
    func solve() {
        
        if let initialVelocity = Double(initialVelocityTextField.text!) {
            
            if let angle = Double(angleTextField.text!) {
                
                if let xDisplacement = Double(xDisplacementTextField.text!) {
                    
                    if (angle == 90 || angle == 180 || angle == 270 ) && xDisplacement != 0 {
                    
                        if angle == 180 || angle == 270 {
                        
                            self.presentViewController(physics.presentErrorAlert(), animated: true, completion: nil)
                        
                        } else {
                            
                            self.presentViewController(physics.presentErrorAlert(), animated: true, completion: nil)
                            
                        }
                    
                    } else {
                        
                        physics = Physics(VectorVelocity: CGFloat(initialVelocity), degree: CGFloat(angle), xDisplacement: CGFloat(xDisplacement), currentUnit: currentUnit)
                        
                        if physics.canBeSolved {
                        
                            displayData()
                        
                            timeSliderOutlet.value = Float(physics.time!)
                        
                        } else {
                            
                            self.presentViewController(physics.presentErrorAlert(), animated: true, completion: nil)
                            
                        }
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    
    
    //MARK: = Function : function to display data
    func displayData() {
        
        switch physics.currentUnits {
            
        case .InternationalSystem:
            
            displayInternational(true)
            
        case .MetricSystem:
            
            displayMetric(true)
            
        }
        
        totalTimeLabel.text = String(round(1000 * physics.time!) / 1000) + " sec"
        
        timeSliderOutlet.maximumValue = Float(physics.time!)
        
        timeSliderOutlet.minimumValue = 0
        
    }
    
    
    //MARK: - Function : Displays recalculated data
    func displayRecalculations() {
        
        switch physics.currentUnits {
            
        case .InternationalSystem:
            
            displayInternational(false)
            
        case .MetricSystem:
            
            displayMetric(false)
            
        }
        
        totalTimeLabel.text = String(round(1000 * physics.time!) / 1000) + " sec"
        
        timeSliderOutlet.maximumValue = abs(Float(physics.time!))
        
        timeSliderOutlet.minimumValue = 0
        
    }
    
    
    func displayInternational(maxHeight : Bool) {
        
        initialVelocityLabel.text = "Initial Velocity: " + String(round(1000 * physics.VectorVelocity) / 1000) + " m/s"
        
        angleLabel.text = "Angle: " + String(round(1000 * physics.degrees) / 1000) + "º"
        
        finalVectorVelocityLabel.text = "Final Velocity: " + String(round(1000 * physics.finalVectorVelocity) / 1000) + " m/s"
        
        finalVectorAngle.text = "Angle of Final Velocity Vector: " + String(round(1000 * physics.finalDegrees) / 1000) + "º"
        
        timeLabel.text = "Time: " + String(round(1000 * physics.time!) / 1000) + " sec"
        
        if maxHeight {
        
            maxHeightLabel.text = "Max Height: " + String(round(1000 * physics.yMaxHeight!) / 1000) + " m  at " + String(round(1000 * physics.maxHeightTime!) / 1000) + " sec"
        
        }
        
        verticalVelocityLabel.text = "Vertical Velocity: " + String(round(1000 * physics.yInitialVelovity!) / 1000) + " m/s"
        
        verticalDisplacementLable.text = "Vertical Displacement: " + String(round(1000 * physics.yDisplacement!) / 1000) + " m"
        
        verticalFinalVelocityLabel.text = "Vertical Final Velocity: " + String(round(1000 * physics.yFinalVelocity!) / 1000) + " m/s"
        
        horizantalVelocityLabel.text = "Horizantal Velocity: " + String(round(1000 * physics.xInitialVelocity!) / 1000) + " m/s"
        
        horizantalDisplacementLabel.text = "Horizantal Displacement: " + String(round(1000 * physics.xDisplacement!) / 1000) + " m"
        
        horizantalFinalVelocityLabel.text = "Horizantal Final Velocity: " + String(round(1000 * physics.xFinalVelocity!) / 1000) + " m/s"
        
    }
    
    
    func displayMetric(maxHeight : Bool) {
        
        initialVelocityLabel.text = "Initial Velocity: " + String(round(1000 * physics.VectorVelocity) / 1000) + " ft/s"
        
        angleLabel.text = "Angle: " + String(round(1000 * physics.degrees) / 1000) + "º"
        
        finalVectorVelocityLabel.text = "Final Velocity: " + String(round(1000 * physics.finalVectorVelocity) / 1000) + " ft/s"
        
        finalVectorAngle.text = "Angle of Final Velocity Vector: " + String(round(1000 * physics.finalDegrees) / 1000) + "º"
        
        timeLabel.text = "Time: " + String(round(1000 * physics.time!) / 1000) + " sec"
        
        if maxHeight {
        
            maxHeightLabel.text = "Max Height: " + String(round(1000 * physics.yMaxHeight!) / 1000) + " ft at " + String(round(1000 * physics.maxHeightTime!) / 1000) + " sec"
        
        }
        
        verticalVelocityLabel.text = "Vertical Velocity: " + String(round(1000 * physics.yInitialVelovity!) / 1000) + " ft/s"
        
        verticalDisplacementLable.text = "Vertical Displacement: " + String(round(1000 * physics.yDisplacement!) / 1000) + " ft"
        
        verticalFinalVelocityLabel.text = "Vertical Final Velocity: " + String(round(1000 * physics.yFinalVelocity!) / 1000) + " ft/s"
        
        horizantalVelocityLabel.text = "Horizantal Velocity: " + String(round(1000 * physics.xInitialVelocity!) / 1000) + " ft/s"
        
        horizantalDisplacementLabel.text = "Horizantal Displacement: " + String(round(1000 * physics.xDisplacement!) / 1000) + " ft"
        
        horizantalFinalVelocityLabel.text = "Horizantal Final Velocity: " + String(round(1000 * physics.xFinalVelocity!) / 1000) + " ft/s"
        
    }
    
    
    //MARK: - Controlling Keyboard
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        initialVelocityTextField.resignFirstResponder()
        
        xDisplacementTextField.resignFirstResponder()
        
        angleTextField.resignFirstResponder()
        
        return true
        
    }
    
    func shouldSolve(sender : AnyObject) {
        
        solve()
        
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        
    }

}
