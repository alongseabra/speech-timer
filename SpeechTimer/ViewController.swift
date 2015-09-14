//
//  ViewController.swift
//  SpeechTimer
//
//  Created by Anson Long-Seabra on 4/3/15.
//  Copyright (c) 2015 Anson Long-Seabra. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var LogoLabel: UILabel!
    @IBOutlet weak var TimeMeButton: UIButton!
    @IBOutlet weak var MoreInfoButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        


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

