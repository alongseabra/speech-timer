//
//  TimerViewController.swift
//  SpeechTimer
//
//  Created by Anson Long-Seabra on 4/11/15.
//  Copyright (c) 2015 Anson Long-Seabra. All rights reserved.
//

import UIKit

/**
The ViewController for the timing scene.
**/
class TimerViewController: UIViewController {
    
    //The actual time that is displayed
    @IBOutlet weak var displayTimeLabel: UILabel!;
    
    //The date-time the timer is started
    var startTime = NSDate.timeIntervalSinceReferenceDate();
    
    //The timer that "listens" for when input noise dies down, if
    //user should excersize this option
    var inputTimer = NSTimer();
    
    //The timer that keeps time
    var timer = NSTimer();



    override func viewDidLoad() {
        super.viewDidLoad();
    }
    
    
    //Starts the timer
    @IBAction func start()
    {
        
        let aSelector : Selector = "updateTime";
        
        self.timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: aSelector, userInfo: nil, repeats: true);
        
        self.startTime = NSDate.timeIntervalSinceReferenceDate();
        
        
    }
    
    @IBAction func stop()
    {
        self.timer.invalidate();
    }
    
    //Updates the timer each second
    func updateTime()
    {
        
        var currentTime = NSDate.timeIntervalSinceReferenceDate();
        
        var elapsedTime: NSTimeInterval = currentTime - startTime;
        
        let minutes = UInt8(elapsedTime / 60.0);
        
        elapsedTime -= (NSTimeInterval(minutes) * 60);
        
        
        let seconds = UInt8(elapsedTime);
        
        elapsedTime -= NSTimeInterval(seconds);
        
        
        let fraction = UInt8(elapsedTime * 100);
        
        let strMinutes = minutes > 9 ? String(minutes): "0" + String(minutes);
        let strSeconds = seconds > 9 ? String(seconds): "0" + String(seconds);
        let strFraction = fraction > 9 ? String(fraction): "0" + String(fraction);
        
        self.displayTimeLabel.text = "\(strMinutes):\(strSeconds)";
        
    }
    
}
