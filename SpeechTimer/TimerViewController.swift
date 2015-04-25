//
//  TimerViewController.swift
//  SpeechTimer
//
//  Created by Anson Long-Seabra on 4/11/15.
//  Copyright (c) 2015 Anson Long-Seabra. All rights reserved.
//

import UIKit
import AVFoundation


/**
The ViewController for the timing scene.
**/
class TimerViewController: UIViewController, AVAudioRecorderDelegate {
    
    //The actual time that is displayed
    @IBOutlet weak var displayTimeLabel: UILabel!;
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var autoStopIndicator: UILabel!
    
    var recorder: AVAudioRecorder!

    
    var mode : String?;
    
    //The date-time the timer is started
    var startTime = NSDate.timeIntervalSinceReferenceDate();

    //The timer that "listens" for when input noise dies down, if
    //user should excersize this option
    var inputTimer = NSTimer();
    
    //The timer that keeps time
    var timer = NSTimer();

    @IBOutlet weak var instructionLabel: UILabel!
    

    override func viewDidLoad() {
        setupRecorder();
        
        var error: NSError?;
        AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayAndRecord, error: &error);
        
        
        self.inputTimer = NSTimer.scheduledTimerWithTimeInterval(0.03, target: self, selector: "levelTimerCallback", userInfo: nil, repeats: true);
        self.recorder.record();
        
        if (self.mode != nil) {
            if (self.mode == "automatic") {
                self.autoStopIndicator.textColor = UIColor.redColor();
            } else {
                self.autoStopIndicator.hidden = true;
            }

        } else {
            print("mode is nil");
        }
        super.viewDidLoad();
   }
    
    func levelTimerCallback()
    {
        recorder.updateMeters();
        println("Average input: \(recorder.averagePowerForChannel(0)) Peak input: \(recorder.peakPowerForChannel(0))");
        if (recorder.peakPowerForChannel(0) > -15)
        {
            recorder.stop();
            inputTimer.invalidate();
            start();
            
        }
    }
    
    
    //Starts the timer
    @IBAction func start()
    {
        self.recorder.stop();
        self.startButton.hidden = true;
        
        let aSelector : Selector = "updateTime";
        
        self.timer = NSTimer.scheduledTimerWithTimeInterval(0.001, target: self, selector: aSelector, userInfo: nil, repeats: true);
        
        self.startTime = NSDate.timeIntervalSinceReferenceDate();
        self.instructionLabel.hidden = true;
        
    }
    
    @IBAction func stop()
    {
        self.timer.invalidate();
    }
    
    //Updates the timer each second
    func updateTime()
    {
        println("firing");
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
    
    //Sets up the recorder we'll be using to record sounds
    func setupRecorder() {
        
        var format = NSDateFormatter();
        format.dateFormat="yyyy-MM-dd-HH-mm-ss";
        var currentFileName = "recording-\(format.stringFromDate(NSDate(timeIntervalSinceNow: 0.0))).m4a";
        
        var dirPaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true);
        var docsDir: AnyObject = dirPaths[0];
        var soundFilePath = docsDir.stringByAppendingPathComponent(currentFileName);
        var soundFileURL = NSURL(fileURLWithPath: soundFilePath);
        let filemanager = NSFileManager.defaultManager();
        if filemanager.fileExistsAtPath(soundFilePath) {
            // probably won't happen. want to do something about it?
        }
        
        var recordSettings = [
            AVFormatIDKey: kAudioFormatAppleLossless,
            AVEncoderAudioQualityKey : AVAudioQuality.Max.rawValue,
            AVEncoderBitRateKey : 320000,
            AVNumberOfChannelsKey: 2,
            AVSampleRateKey : 44100.0
        ];
        var error: NSError?;
        self.recorder = AVAudioRecorder(URL: soundFileURL, settings: recordSettings, error: &error);
        
        if let e = error {
            println(e.localizedDescription);
        } else {
            self.recorder.delegate = self;
            self.recorder.meteringEnabled = true;
            self.recorder.prepareToRecord(); // creates/overwrites the file at soundFileURL
        }
    }
    
}
