//
//  SetupViewController.swift
//  SpeechTimer
//
//  Created by Anson Long-Seabra on 4/4/15.
//  Copyright (c) 2015 Anson Long-Seabra. All rights reserved.
//


import UIKit

class SetupViewController: UIViewController {
    

    @IBOutlet weak var BackButton: UIButton!
    
    
    //The view containing items that indicate the user would like to stop
    //the timer manually
    lazy var manualChoice = ChoiceView(frame: CGRectMake(0, 100, 480, 120), choice: "manual");
    
    //lazy var automaticChoice = ChoiceView(frame: CGRectMake(0, 50, 200, 50));
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.addSubview(self.manualChoice);
        //self.view.addSubview(self.automaticChoice);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}