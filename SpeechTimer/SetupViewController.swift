//
//  SetupViewController.swift
//  SpeechTimer
//
//  Created by Anson Long-Seabra on 4/4/15.
//  Copyright (c) 2015 Anson Long-Seabra. All rights reserved.
//


import UIKit

/**
The ViewController for the setup scene
**/
class SetupViewController: UIViewController, UIPickerViewDelegate  {



    @IBOutlet var manualStopRadio: DLRadioButton!

    @IBOutlet var automaticStopRadio: DLRadioButton!

    @IBOutlet weak var BackButton: UIButton!
    
    @IBOutlet var nextScreenButton: UIButton!
    
    //The view containing items that indicate the user would like to stop
    //the timer manually
    var manualChoice : ChoiceView?;
    
    //The view containing items that indicate the user would like to stop
    //the timer automatically
    var automaticChoice : ChoiceView?;
    
    //The view containing the choices
    var choiceContainerView : ChoiceContainerView?;
    
    //Contains view that has automatic time options
    @IBOutlet var finishTimeLabelContainerView : UIView?;
    @IBOutlet var finishTimeLabel : UILabel?;
    @IBOutlet var finishTimeStepper : UIStepper?;
    
    var userWantsManual : Bool?;
    var readyToGoToNextScreen : Bool?
    
    var micSensitivitySlider : UISlider?;
    
    @IBOutlet weak var ContinueButton: UIButton!

    let labelFont = UIFont(name: "Bariol-Regular", size: 15.0);
    
    override func viewDidLoad() {

        super.viewDidLoad();
        
        self.nextScreenButton.layer.cornerRadius = 20;
        
        let yStart = self.view.frame.size.height * 0.57;
        let xStart = CGFloat(0.0);
        let containerWidth = self.view.frame.size.width;
        let containerHeight = self.view.frame.size.height / 8;
        
        
        self.disableFinishTimeLabel();
        self.nextScreenButton.enabled = false;
        
        //call initially to set value
        updateFinishTimeLabel();
        
        
    

    }
    
    @IBAction func manualStopTapped(sender: AnyObject) {
        self.userWantsManual = true;
        self.disableFinishTimeLabel();
        enableNextScreenButton();
    }
    
    @IBAction func automaticStopTapped(sender: AnyObject) {
        self.userWantsManual = false;
        self.enableFinishTimeLabel();
        enableNextScreenButton();
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "toTimer")
        {
            var dVC : TimerViewController = segue.destinationViewController as! TimerViewController;
            if (self.userWantsManual!) {
                dVC.mode = "manual";
            } else {
                dVC.mode = "automatic";
                var seconds = self.finishTimeStepper?.value;
                seconds = seconds! * 100;
                dVC.numberOfSecondsBeforeStop = Int(seconds!);
            }
        }
    }

    @IBAction func stepperPressed(sender: AnyObject) {
        updateFinishTimeLabel();

    }
    func enableNextScreenButton()
    {
        self.nextScreenButton.enabled = true;
    }
    
    
    func updateFinishTimeLabel()
    {
        var value = self.finishTimeStepper?.value;
        var stepperValue : String = String(format:"%.f", value!);
        self.finishTimeLabel?.text = "I want the timer to stop after \(stepperValue) seconds";
    }
    
    func disableFinishTimeLabel()
    {
        self.finishTimeLabelContainerView?.userInteractionEnabled = false;
        self.finishTimeLabelContainerView?.alpha = 0.3;
    }
    
    func enableFinishTimeLabel()
    {
        self.finishTimeLabelContainerView?.userInteractionEnabled = true;
        self.finishTimeLabelContainerView?.alpha = 1.0;
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}