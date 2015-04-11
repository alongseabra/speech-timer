//
//  SetupViewController.swift
//  SpeechTimer
//
//  Created by Anson Long-Seabra on 4/4/15.
//  Copyright (c) 2015 Anson Long-Seabra. All rights reserved.
//


import UIKit

class SetupViewController: UIViewController, UIPickerViewDelegate {
    

    @IBOutlet weak var BackButton: UIButton!
    
    
    //The view containing items that indicate the user would like to stop
    //the timer manually
    var manualChoice : ChoiceView?;
    var automaticChoice : ChoiceView?;
    var choiceContainerView : ChoiceContainerView?;
    
    var finishTimeLabelContainerView : UIView?;
    var finishTimeLabel : UILabel?;
    var finishTimePicker : UIPickerView?;
    
    var nums : [String] = ["5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15"];

    
    override func viewDidLoad() {
        
        super.viewDidLoad();
        self.choiceContainerView = ChoiceContainerView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height / 4));
        self.manualChoice = ChoiceView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height / 8), choice: "manual");
        self.automaticChoice = ChoiceView(frame: CGRectMake(0, self.view.frame.size.height / 8,
                                                            self.view.frame.size.width, self.view.frame.size.height / 8 ),
                                          choice: "automatic");

        self.choiceContainerView?.addChoiceView(self.manualChoice!);
        self.choiceContainerView?.addChoiceView(self.automaticChoice!);
    
        self.manualChoice?.label.text = "Manual";
        self.automaticChoice?.label.text = "Automatic";
        self.view.addSubview(self.choiceContainerView!);
        
        self.finishTimePicker = UIPickerView(frame: CGRectMake(0, 300, 50, 50));
        self.finishTimePicker?.delegate = self;
        self.view.addSubview(self.finishTimePicker!);
        

    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView!) -> Int {
        return 1;
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       
        return self.nums.count;
        
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        
        return self.nums[row];
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}