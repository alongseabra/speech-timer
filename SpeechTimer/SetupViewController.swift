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
    
    lazy var manualChoice = ChoiceView(frame: CGRectMake(0, 100, 200, 50));
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(manualChoice);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}