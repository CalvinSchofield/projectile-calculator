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
    
    var currentUnit : Units = .MetersPerSecond
    
    
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
    
    @IBOutlet weak var meterPerSecond: UIButton!
    
    @IBOutlet weak var kilometersPerHour: UIButton!
    
    @IBOutlet weak var feetPerSecond: UIButton!
    
    @IBOutlet weak var milesPerHour: UIButton!
    
    @IBAction func metersPerSecond(sender: AnyObject) {
        
        currentUnit = .MetersPerSecond
        
        physics.currentUnits  = currentUnit
        
        meterPerSecond.backgroundColor = UIColor(red: 233/255, green: 228/255, blue: 183/255, alpha: 1.0)
        
        kilometersPerHour.backgroundColor = UIColor.clearColor()
        
        feetPerSecond.backgroundColor = UIColor.clearColor()
        
        milesPerHour.backgroundColor = UIColor.clearColor()
        
        solve()
        
    }
    
    @IBAction func kilometersPerHour(sender: AnyObject) {
        
        currentUnit = .KilometersPerHour
        
        physics.currentUnits  = currentUnit
        
        kilometersPerHour.backgroundColor = UIColor(red: 233/255, green: 228/255, blue: 183/255, alpha: 1.0)
        
        meterPerSecond.backgroundColor = UIColor.clearColor()
        
        feetPerSecond.backgroundColor = UIColor.clearColor()
        
        milesPerHour.backgroundColor = UIColor.clearColor()
        
        solve()
        
    }
    
    @IBAction func feetPerSecond(sender: AnyObject) {
        
        currentUnit = .FeetPerSecond
        
        physics.currentUnits  = currentUnit
        
        feetPerSecond.backgroundColor = UIColor(red: 233/255, green: 228/255, blue: 183/255, alpha: 1.0)
        
        kilometersPerHour.backgroundColor = UIColor.clearColor()
        
        meterPerSecond.backgroundColor = UIColor.clearColor()
        
        milesPerHour.backgroundColor = UIColor.clearColor()
        
        solve()
        
    }
    
    @IBAction func milesPerHour(sender: AnyObject) {
        
        currentUnit = .MilesPerHour
        
        physics.currentUnits  = currentUnit
        
        milesPerHour.backgroundColor = UIColor(red: 233/255, green: 228/255, blue: 183/255, alpha: 1.0)
        
        kilometersPerHour.backgroundColor = UIColor.clearColor()
        
        feetPerSecond.backgroundColor = UIColor.clearColor()
        
        meterPerSecond.backgroundColor = UIColor.clearColor()
        
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
        
        initialVelocityTextField.addTarget(self, action: #selector(XDisplacementViewController.shouldSolve(_:)), forControlEvents: UIControlEvents.EditingChanged)
        
        self.xDisplacementTextField.delegate = self
        
        xDisplacementTextField.addTarget(self, action: #selector(XDisplacementViewController.shouldSolve(_:)), forControlEvents: UIControlEvents.EditingChanged)
        
        self.angleTextField.delegate = self
        
        angleTextField.addTarget(self, action: #selector(XDisplacementViewController.shouldSolve(_:)), forControlEvents: UIControlEvents.EditingChanged)
        
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
            
        case .MilesPerHour:
            
            displayMilesPerHour(true)
            
            totalTimeLabel.text = String(round(1000 * physics.time!) / 1000) + " hr"
            
            break
            
        case .KilometersPerHour:
            
            displayKilometersPerHour(true)
            
            totalTimeLabel.text = String(round(1000 * physics.time!) / 1000) + "hr"
            
            break
            
        }
        
        totalTimeLabel.text = String(round(1000 * physics.time!) / 1000) + " s"
        
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
            
        case .MilesPerHour:
            
            displayMilesPerHour(false)
            
            totalTimeLabel.text = String(round(1000 * physics.time!) / 1000) + " hr"
            
            break
            
        case .KilometersPerHour:
            
            displayKilometersPerHour(false)
            
            totalTimeLabel.text = String(round(1000 * physics.time!) / 1000) + " hr"
            
            break
            
        }
        
        timeSliderOutlet.maximumValue = Float(physics.time!)
        
        timeSliderOutlet.minimumValue = 0
        
    }
    
    
    func displayFeetPerSecond(maxHeight : Bool) {
        
        initialVelocityLabel.text = "Initial Velocity: " + String(round(1000 * physics.VectorVelocity) / 1000) + " ft/s"
        
        angleLabel.text = "Angle: " + String(round(1000 * physics.degrees) / 1000) + "º"
        
        finalVectorVelocityLabel.text = "Final Velocity: " + String(round(1000 * physics.finalVectorVelocity) / 1000) + " ft/s"
        
        finalVectorAngle.text = "Angle of Final Velocity Vector: " + String(round(1000 * physics.finalDegrees) / 1000) + "º"
        
        timeLabel.text = "Time: " + String(round(1000 * physics.time!) / 1000) + " s"
        
        maxHeightLabel.text = "Max Height: " + String(round(1000 * physics.yMaxHeight!) / 1000) + " ft  at " + String(round(1000 * physics.maxHeightTime!) / 1000) + " s"
        
        verticalVelocityLabel.text = "Vertical Velocity: " + String(round(1000 * physics.yInitialVelovity!) / 1000) + " ft/s"
        
        verticalDisplacementLable.text = "Vertical Displacement: " + String(round(1000 * physics.yDisplacement!) / 1000) + " ft"
        
        verticalFinalVelocityLabel.text = "Vertical Final Velocity: " + String(round(1000 * physics.yFinalVelocity!) / 1000) + " ft/s"
        
        horizantalVelocityLabel.text = "Horizantal Velocity: " + String(round(1000 * physics.xInitialVelocity!) / 1000) + " ft/s"
        
        horizantalDisplacementLabel.text = "Horizantal Displacement: " + String(round(1000 * physics.xDisplacement!) / 1000) + " ft"
        
        horizantalFinalVelocityLabel.text = "Horizantal Final Velocity: " + String(round(1000 * physics.xFinalVelocity!) / 1000) + " ft/s"
        
    }
    
    func displayMilesPerHour(maxHeight : Bool) {
        
        initialVelocityLabel.text = "Initial Velocity: " + String(round(1000 * physics.VectorVelocity) / 1000) + " mi/hr"
        
        angleLabel.text = "Angle: " + String(round(1000 * physics.degrees) / 1000) + "º"
        
        finalVectorVelocityLabel.text = "Final Velocity: " + String(round(1000 * physics.finalVectorVelocity) / 1000) + " mi/hr"
        
        finalVectorAngle.text = "Angle of Final Velocity Vector: " + String(round(1000 * physics.finalDegrees) / 1000) + "º"
        
        timeLabel.text = "Time: " + String(round(1000 * physics.time!) / 1000) + " hr"
        
        maxHeightLabel.text = "Max Height: " + String(round(1000 * physics.yMaxHeight!) / 1000) + " mi  at " + String(round(1000 * physics.maxHeightTime!) / 1000) + " hr"
        
        
        verticalVelocityLabel.text = "Vertical Velocity: " + String(round(1000 * physics.yInitialVelovity!) / 1000) + " mi/hr"
        
        verticalDisplacementLable.text = "Vertical Displacement: " + String(round(1000 * physics.yDisplacement!) / 1000) + " mi"
        
        verticalFinalVelocityLabel.text = "Vertical Final Velocity: " + String(round(1000 * physics.yFinalVelocity!) / 1000) + " mi/hr"
        
        horizantalVelocityLabel.text = "Horizantal Velocity: " + String(round(1000 * physics.xInitialVelocity!) / 1000) + " mi/hr"
        
        horizantalDisplacementLabel.text = "Horizantal Displacement: " + String(round(1000 * physics.xDisplacement!) / 1000) + " mi"
        
        horizantalFinalVelocityLabel.text = "Horizantal Final Velocity: " + String(round(1000 * physics.xFinalVelocity!) / 1000) + " mi/hr"
        
    }
    
    
    func displayMetersPerSecond(maxHeight : Bool) {
        
        initialVelocityLabel.text = "Initial Velocity: " + String(round(1000 * physics.VectorVelocity) / 1000) + " m/s"
        
        angleLabel.text = "Angle: " + String(round(1000 * physics.degrees) / 1000) + "º"
        
        finalVectorVelocityLabel.text = "Final Velocity: " + String(round(1000 * physics.finalVectorVelocity) / 1000) + " m/s"
        
        finalVectorAngle.text = "Angle of Final Velocity Vector: " + String(round(1000 * physics.finalDegrees) / 1000) + "º"
        
        timeLabel.text = "Time: " + String(round(1000 * physics.time!) / 1000) + " s"
        
        maxHeightLabel.text = "Max Height: " + String(round(1000 * physics.yMaxHeight!) / 1000) + " m  at " + String(round(1000 * physics.maxHeightTime!) / 1000) + " s"
            
        
        verticalVelocityLabel.text = "Vertical Velocity: " + String(round(1000 * physics.yInitialVelovity!) / 1000) + " m/s"
        
        verticalDisplacementLable.text = "Vertical Displacement: " + String(round(1000 * physics.yDisplacement!) / 1000) + " m"
        
        verticalFinalVelocityLabel.text = "Vertical Final Velocity: " + String(round(1000 * physics.yFinalVelocity!) / 1000) + " m/s"
        
        horizantalVelocityLabel.text = "Horizantal Velocity: " + String(round(1000 * physics.xInitialVelocity!) / 1000) + " m/s"
        
        horizantalDisplacementLabel.text = "Horizantal Displacement: " + String(round(1000 * physics.xDisplacement!) / 1000) + " m"
        
        horizantalFinalVelocityLabel.text = "Horizantal Final Velocity: " + String(round(1000 * physics.xFinalVelocity!) / 1000) + " m/s"
        
    }
    
    func displayKilometersPerHour(maxHeight : Bool) {
        
        initialVelocityLabel.text = "Initial Velocity: " + String(round(1000 * physics.VectorVelocity) / 1000) + " ki/hr"
        
        angleLabel.text = "Angle: " + String(round(1000 * physics.degrees) / 1000) + "º"
        
        finalVectorVelocityLabel.text = "Final Velocity: " + String(round(1000 * physics.finalVectorVelocity) / 1000) + " ki/hr"
        
        finalVectorAngle.text = "Angle of Final Velocity Vector: " + String(round(1000 * physics.finalDegrees) / 1000) + "º"
        
        timeLabel.text = "Time: " + String(round(1000 * physics.time!) / 1000) + " hr"
        
        maxHeightLabel.text = "Max Height: " + String(round(1000 * physics.yMaxHeight!) / 1000) + " ki  at " + String(round(1000 * physics.maxHeightTime!) / 1000) + " hr"
            
        
        verticalVelocityLabel.text = "Vertical Velocity: " + String(round(1000 * physics.yInitialVelovity!) / 1000) + " ki/hr"
        
        verticalDisplacementLable.text = "Vertical Displacement: " + String(round(1000 * physics.yDisplacement!) / 1000) + " ki"
        
        verticalFinalVelocityLabel.text = "Vertical Final Velocity: " + String(round(1000 * physics.yFinalVelocity!) / 1000) + " ki/hr"
        
        horizantalVelocityLabel.text = "Horizantal Velocity: " + String(round(1000 * physics.xInitialVelocity!) / 1000) + " ki/hr"
        
        horizantalDisplacementLabel.text = "Horizantal Displacement: " + String(round(1000 * physics.xDisplacement!) / 1000) + " ki"
        
        horizantalFinalVelocityLabel.text = "Horizantal Final Velocity: " + String(round(1000 * physics.xFinalVelocity!) / 1000) + " ki/hr"
        
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
        
        physics.currentUnits = currentUnit
        
        solve()
        
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        
    }

}
