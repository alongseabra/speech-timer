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
    
    
    @IBOutlet weak var progressTilStop: UIProgressView!
    var numberOfSecondsBeforeStop: Int?; //total 100ths of seconds of silence before recording stops
    var numberOfSecondsSilent: Int = 0; //total 100ths of second that app has detected since last sound
    
    var recorder: AVAudioRecorder!

    
    var mode : String?;
    
    //The date-time the timer is started
    var startTime = NSDate.timeIntervalSinceReferenceDate();

    //The timer that "listens" for when input noise dies down, if
    //user should excersize this option
    var inputTimer : NSTimer = NSTimer();
    
    var listenForSilenceTimer : NSTimer = NSTimer();
    
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
        self.recorder.updateMeters();
        println("Average input: \(recorder.averagePowerForChannel(0)) Peak input: \(recorder.peakPowerForChannel(0))");
        if (self.recorder.peakPowerForChannel(0) > -15)
        {
            self.inputTimer.invalidate();
            start();
            
        }
    }
    
    func listenForSilence()
    {
        self.listenForSilenceTimer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "levelTimerCallbackForEnd", userInfo: nil, repeats: true);
        
    }
    
    
    //Starts the timer
    @IBAction func start()
    {
        //self.recorder.stop();
        self.startButton.hidden = true;
        
        let aSelector : Selector = "updateTime";
        
        self.timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: aSelector, userInfo: nil, repeats: true);
        
        self.startTime = NSDate.timeIntervalSinceReferenceDate();
        self.instructionLabel.hidden = true;
        
        if (self.mode == "automatic")
        {
            listenForSilence();
        }
        
    }
    
    @IBAction func stop()
    {
        self.timer.invalidate();
        self.listenForSilenceTimer.invalidate();
        
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
    
    func  levelTimerCallbackForEnd()
    {
        self.recorder.updateMeters()
        
        if (self.numberOfSecondsSilent >= self.numberOfSecondsBeforeStop)
        {
            //print("invalidating")
            stop();
        }
        
        if (self.recorder.averagePowerForChannel(0) < -25)
        {
            println(self.recorder.averagePowerForChannel(0))
            self.numberOfSecondsSilent++
            self.progressTilStop.progress = Float(numberOfSecondsSilent) / Float(numberOfSecondsBeforeStop!);
            
            
        }
        else {
            self.numberOfSecondsSilent = 0
            self.progressTilStop.progress = 0;
        }
        //println(numberOfSecondsSilent)
        
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
