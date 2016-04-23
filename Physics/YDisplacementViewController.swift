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
    
    var currentUnit : Units = .MetersPerSecond
    
    var textFields = [UITextField]()
    
    
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
    
    @IBOutlet weak var meterPerSecond: UIButton!
    
    @IBOutlet weak var feetPerSecond: UIButton!
    
    @IBAction func metersPerSecond(sender: AnyObject) {
    
        currentUnit = .MetersPerSecond
        
        physics.currentUnits  = currentUnit
        
        meterPerSecond.backgroundColor = UIColor(red: 233/255, green: 228/255, blue: 183/255, alpha: 1.0)
        
        feetPerSecond.backgroundColor = UIColor.clearColor()
        
        solve()
    
    }
    
    @IBAction func feetPerSecond(sender: AnyObject) {
    
        currentUnit = .FeetPerSecond
        
        physics.currentUnits  = currentUnit
        
        feetPerSecond.backgroundColor = UIColor(red: 233/255, green: 228/255, blue: 183/255, alpha: 1.0)
        
        meterPerSecond.backgroundColor = UIColor.clearColor()
                
        solve()
    
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
                        
                        self.presentViewController(physics.presentErrorAlert(textFields), animated: true, completion: nil)
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tabBarController!.tabBar.tintColor = UIColor(red: 153/255, green: 153/255, blue: 102/255, alpha: 1.0)
        
        self.initialVelocityTextField.delegate = self
        
        initialVelocityTextField.addTarget(self, action: #selector(YDisplacementViewController.shouldSolve(_:)), forControlEvents: UIControlEvents.EditingChanged)
        
        self.yDisplacementTextField.delegate = self
        
        yDisplacementTextField.addTarget(self, action: #selector(YDisplacementViewController.shouldSolve(_:)), forControlEvents: UIControlEvents.EditingChanged)
        
        self.angleTextField.delegate = self
        
        angleTextField.addTarget(self, action: #selector(YDisplacementViewController.shouldSolve(_:)), forControlEvents: UIControlEvents.EditingChanged)
        
        textFields = [initialVelocityTextField, yDisplacementTextField, angleTextField]
        
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
                        
                        self.presentViewController(physics.presentErrorAlert(textFields), animated: true, completion: nil)
                        
                    }
    
                }
                
            }
            
        }
        
    }
    
    
    //MARK: - Function : function to display data
    func displayData() {
                
        switch physics.currentUnits {
            
        case .FeetPerSecond:
            
            displayFeetPerSecond(true)
            
            totalTimeLabel.text = String(round(1000 * physics.time!) / 1000) + " s"
            
            break
            
        case .MetersPerSecond:
            
            displayFeetPerSecond(true)
            
            totalTimeLabel.text = String(round(1000 * physics.time!) / 1000) + " s"
            
            break
            
        }
        
        timeSliderOutlet.maximumValue = Float(physics.time!)
        
        timeSliderOutlet.minimumValue = 0
        
    }
    
    
    //MARK: - Function : Displays recalculated data
    func displayRecalculations() {
        
        switch physics.currentUnits {
            
        case .FeetPerSecond:
            
            displayFeetPerSecond(false)
            
            totalTimeLabel.text = String(round(1000 * physics.time!) / 1000) + " s"
            
            break
            
        case .MetersPerSecond:
            
            displayMetersPerSecond(false)
            
            totalTimeLabel.text = String(round(1000 * physics.time!) / 1000) + " s"
            
            break
            
        }
        
        timeSliderOutlet.maximumValue = Float(physics.time!)
        
        timeSliderOutlet.minimumValue = 0
        
    }
    
    func showInitial() {
        
        initialVelocityLabel.text = "Initial Velocity:"
        
        angleLabel.text = "Angle of Initial Velocity Vector:"
        
        finalVelocityLabel.text = "Final Velocity:"
        
        finalAngleLabel.text = "Angle of Final Velocity Vector:"
        
        timeLabel.text = "Time:"
        
        maxHeightLabel.text = "Max Height:"
        
        verticalVelocityLabel.text = "Vertical Velocity:"
        
        verticalDisplacementLable.text = "Vertical Displacement:"
        
        verticalFinalVelocityLabel.text = "Vertical Final Velocity:"
        
        horizantalVelocityLabel.text = "Horizantal Velocity:"
        
        horizantalDisplacementLabel.text = "Horizantal Displacement:"
        
        horizantalFinalVelocityLabel.text = "Horizantal Final Velocity:"
        
    }
    
    
    func displayFeetPerSecond(maxHeight : Bool) {
        
        initialVelocityLabel.text = "Initial Velocity: " + String(round(1000 * physics.VectorVelocity) / 1000) + " ft/s"
        
        angleLabel.text = "Angle of Initial Velocity Vector: " + String(round(1000 * physics.degrees) / 1000) + "º"
        
        finalVelocityLabel.text = "Final Velocity: " + String(round(1000 * physics.finalVectorVelocity) / 1000) + " ft/s"
        
        finalAngleLabel.text = "Angle of Final Velocity Vector: " + String(round(1000 * physics.finalDegrees) / 1000) + "º"
        
        timeLabel.text = "Time: " + String(round(1000 * physics.time!) / 1000) + " s"

        if(maxHeight) {
        
            maxHeightLabel.text = "Max Height: " + String(round(1000 * physics.yMaxHeight!) / 1000) + " ft  at " + String(round(1000 * physics.maxHeightTime!) / 1000) + " s"
            
        }
        
        verticalVelocityLabel.text = "Vertical Velocity: " + String(round(1000 * physics.yInitialVelovity!) / 1000) + " ft/s"
        
        verticalDisplacementLable.text = "Vertical Displacement: " + String(round(1000 * physics.yDisplacement!) / 1000) + " ft"
        
        verticalFinalVelocityLabel.text = "Vertical Final Velocity: " + String(round(1000 * physics.yFinalVelocity!) / 1000) + " ft/s"
        
        horizantalVelocityLabel.text = "Horizantal Velocity: " + String(round(1000 * physics.xInitialVelocity!) / 1000) + " ft/s"
        
        horizantalDisplacementLabel.text = "Horizantal Displacement: " + String(round(1000 * physics.xDisplacement!) / 1000) + " ft"
        
        horizantalFinalVelocityLabel.text = "Horizantal Final Velocity: " + String(round(1000 * physics.xFinalVelocity!) / 1000) + " ft/s"
        
    }
    
    func displayMetersPerSecond(maxHeight : Bool) {
        
        initialVelocityLabel.text = "Initial Velocity: " + String(round(1000 * physics.VectorVelocity) / 1000) + " m/s"
        
        angleLabel.text = "Angle of Initial Velocity Vector: " + String(round(1000 * physics.degrees) / 1000) + "º"
        
        finalVelocityLabel.text = "Final Velocity: " + String(round(1000 * physics.finalVectorVelocity) / 1000) + " m/s"
        
        finalAngleLabel.text = "Angle of Final Velocity Vector: " + String(round(1000 * physics.finalDegrees) / 1000) + "º"
        
        timeLabel.text = "Time: " + String(round(1000 * physics.time!) / 1000) + " s"
        
        if(maxHeight) {

            maxHeightLabel.text = "Max Height: " + String(round(1000 * physics.yMaxHeight!) / 1000) + " m  at " + String(round(1000 * physics.maxHeightTime!) / 1000) + " s"
        
        }
        
        verticalVelocityLabel.text = "Vertical Velocity: " + String(round(1000 * physics.yInitialVelovity!) / 1000) + " m/s"
        
        verticalDisplacementLable.text = "Vertical Displacement: " + String(round(1000 * physics.yDisplacement!) / 1000) + " m"
        
        verticalFinalVelocityLabel.text = "Vertical Final Velocity: " + String(round(1000 * physics.yFinalVelocity!) / 1000) + " m/s"
        
        horizantalVelocityLabel.text = "Horizantal Velocity: " + String(round(1000 * physics.xInitialVelocity!) / 1000) + " m/s"
        
        horizantalDisplacementLabel.text = "Horizantal Displacement: " + String(round(1000 * physics.xDisplacement!) / 1000) + " m"
        
        horizantalFinalVelocityLabel.text = "Horizantal Final Velocity: " + String(round(1000 * physics.xFinalVelocity!) / 1000) + " m/s"
        
    }

    
    //MARK: - Controlling Keyboard
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        initialVelocityTextField.resignFirstResponder()
        
        angleTextField.resignFirstResponder()
        
        yDisplacementTextField.resignFirstResponder()
        
        return true
        
    }
    
    func shouldSolve(sender : AnyObject) {
        
        physics.currentUnits = currentUnit
        
        clear()
        
        solve()
        
    }
    
    func clear() {
        
        if (initialVelocityTextField.text?.isEmpty)! || (yDisplacementTextField.text?.isEmpty)! || (angleTextField.text?.isEmpty)! {
            
            showInitial()
            
        }
        
    }
    
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        
    }

}
