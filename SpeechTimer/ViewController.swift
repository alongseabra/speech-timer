//
//  ViewController.swift
//  SpeechTimer
//
//  Created by Anson Long-Seabra on 4/3/15.
//  Copyright (c) 2015 Anson Long-Seabra. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var logoLabel: UILabel!
    @IBOutlet var nextScreenButton: UIButton!
    @IBOutlet var twitterButton: UIButton!
    
    @IBOutlet var mainImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       // self.TimeMeButton.layer.cornerRadius =
        nextScreenButton.layer.cornerRadius = 20;


    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func twitterButtonTapped(sender: AnyObject) {
        
        
        var url : NSURL = NSURL(string: "https://twitter.com/AnsonLongSeabra")!
        UIApplication.sharedApplication().openURL(url)
    }
}

