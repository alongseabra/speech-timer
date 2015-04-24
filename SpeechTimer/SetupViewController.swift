//
//  SetupViewController.swift
//  SpeechTimer
//
//  Created by Anson Long-Seabra on 4/4/15.
//  Copyright (c) 2015 Anson Long-Seabra. All rights reserved.
//


import UIKit

class SetupViewController: UIViewController, UIPickerViewDelegate, ChoiceContainerViewDelegate {
    

    @IBOutlet weak var BackButton: UIButton!
    
    
    //The view containing items that indicate the user would like to stop
    //the timer manually
    var manualChoice : ChoiceView?;
    var automaticChoice : ChoiceView?;
    var choiceContainerView : ChoiceContainerView?;
    
    var finishTimeLabelContainerView : UIView?;
    var finishTimeLabel : UILabel?;
    var finishTimeStepper : UIStepper?;
    
    
    @IBOutlet weak var ContinueButton: UIButton!

    
    override func viewDidLoad() {
        
        super.viewDidLoad();
        self.choiceContainerView = ChoiceContainerView(frame: CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height / 4));
        self.manualChoice = ChoiceView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height / 8), choice: "manual");
        self.automaticChoice = ChoiceView(frame: CGRectMake(0, self.view.frame.size.height / 8,
                                                            self.view.frame.size.width, self.view.frame.size.height / 8 ),
                                          choice: "automatic");

        self.choiceContainerView?.addChoiceView(self.manualChoice!);
        self.choiceContainerView?.addChoiceView(self.automaticChoice!);
    
        self.manualChoice?.label.text = "Manual";
        self.automaticChoice?.label.text = "Automatic";
        self.view.addSubview(self.choiceContainerView!);
        
        
        self.finishTimeLabelContainerView = UIView(frame: CGRectMake(0, self.view.frame.size.height / 2, self.view.frame.size.width, self.view.frame.size.height / 8));
        self.finishTimeLabel = UILabel(frame:
            CGRectMake(0, 0, self.view.frame.size.width * 0.75, self.view.frame.size.height / 8));
        
        self.finishTimeLabel?.backgroundColor = UIColor.greenColor();
        self.view.addSubview(finishTimeLabelContainerView!);
        self.finishTimeLabelContainerView?.addSubview(self.finishTimeLabel!);
        
        self.finishTimeStepper = UIStepper(frame: CGRectMake(self.view.frame.size.width * 0.75, 50, 100, 50));
        self.finishTimeLabelContainerView?.addSubview(self.finishTimeStepper!);
        self.finishTimeStepper?.addTarget(self, action: "tapperPressed", forControlEvents: .TouchUpInside);
        updateFinishTimeLabel();
    
        self.choiceContainerView?.choices[0].checkBox.isChecked = true;
        
        setDelegates();

    }
    
    func choiceViewSelected(ChoiceView) {
        print("high level") ;
    }
    
    func setDelegates()
    {
        self.choiceContainerView?.delegate = self;
    }
    
    func tapperPressed()
    {
        updateFinishTimeLabel();
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
        self.finishTimeLabelContainerView?.alpha = 0.5;
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}