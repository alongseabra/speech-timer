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
    var manualChoice : ChoiceView?;
    var automaticChoice : ChoiceView?;
    var choiceContainerView : ChoiceContainerView?;
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad();
        self.choiceContainerView = ChoiceContainerView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height / 4));
        self.manualChoice = ChoiceView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height / 8), choice: "manual");
        self.automaticChoice = ChoiceView(frame: CGRectMake(0, self.view.frame.size.height / 8,
                                                            self.view.frame.size.width, self.view.frame.size.height / 8 ),
                                          choice: "automatic");

        self.choiceContainerView?.addChoiceView(self.manualChoice!);
        self.choiceContainerView?.addChoiceView(self.automaticChoice!);
        self.view.addSubview(self.choiceContainerView!);

        

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}