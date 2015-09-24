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
    
    let meterLevel = -25;
    
    //The actual time that is displayed
    @IBOutlet weak var displayTimeLabel: UILabel!;
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet var resetButton: UIButton!
    @IBOutlet weak var autoStopIndicator: UILabel!
    
    
    @IBOutlet weak var progressTilStop: UIProgressView!
    var numberOfSecondsBeforeStop: Int?; //total 100ths of seconds of silence before recording stops
    var numberOfSecondsSilent: Int = 0; //total 100ths of second that app has detected since last sound
    
    var recorder: AVAudioRecorder!;
    var startSoundTimer : NSTimer!;
    var timeIncrementTimer : NSTimer!;
    var listenForSilenceTimer : NSTimer!;
    var timerRunning = false;
    var timerStarted = false; // for when the timer is started then stopped
    var fullyStopped = false;
    
    var mode : String?;
    
    var previousTime : NSTimeInterval? = -1;
    var startTime : NSTimeInterval?;
    var elapsedTime : NSTimeInterval = 0.0;
    var timeIncrementInterval : NSTimeInterval?;
    
    
    var recordingPath : String?;
    
    
    
    @IBOutlet weak var progressLabel: UILabel!
    //The timer that keeps time
    var timer = NSTimer();

    @IBOutlet weak var instructionLabel: UILabel!
    

    override func viewWillAppear(animated: Bool) {
        
        setupRecorder();
        var error: NSError?;
        AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayAndRecord, error: &error);
        
        self.startSoundTimer = NSTimer.scheduledTimerWithTimeInterval(0.03, target: self, selector: "startSoundTimerCallback", userInfo: nil, repeats: true);
        self.recorder.record();

        if (self.mode != nil) {
            if (self.mode == "automatic") {
                self.autoStopIndicator.textColor = UIColor.redColor();
            } else {
                self.autoStopIndicator.hidden = true;
                self.progressLabel.hidden = true;
                self.progressTilStop.hidden = true;
            }
            
        } else {
            print("mode is nil");
        }
        
        self.stopButton.hidden = true;
        self.resetButton.enabled = false;
        
        if (self.mode == "automatic")
        {
            self.progressTilStop.progress = 0;
            self.progressLabel.text = "\(Int(numberOfSecondsBeforeStop! / 100))" + " seconds until stop";
        }

        
        super.viewDidLoad();
   }
    
      func startSoundTimerCallback()
    {
        println("checking levels");
        self.recorder.updateMeters();
        //println("Average input: \(recorder.averagePowerForChannel(0)) Peak input: \(recorder.peakPowerForChannel(0))");
        if (self.recorder.peakPowerForChannel(0) > -25)
        {
            start();
        }
    }
    
    
    
    //Starts the timer
    @IBAction func start()
    {
        //for if the start button is pressed
        self.startSoundTimer.invalidate();
        
        
        if (!self.timerRunning) {
            
            if (!self.timerStarted) {
                self.startTime = NSDate.timeIntervalSinceReferenceDate();
            }
            self.instructionLabel.hidden = true;
            if (self.mode == "automatic") {
                self.listenForSilenceTimer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "levelTimerCallbackForEnd", userInfo: nil, repeats: true);
            }
            
            keepTrackOfTime();
            self.startButton.hidden = true;
            self.stopButton.hidden = false;
            self.timerRunning = true;
            self.resetButton.enabled = true;

        }

    }
    
    @IBAction func stop()
    {
        self.timerRunning = false;
        self.timerStarted = true;
        if (self.mode == "automatic") {
            self.listenForSilenceTimer.invalidate();
        }
        self.timeIncrementTimer.invalidate();
        
        self.startButton.hidden = false;
        self.stopButton.hidden = true;
        if (self.elapsedTime == 0) {
            self.resetButton.hidden = false;
            self.timerStarted = false;
        }
        
        
    }
    
    @IBAction func reset(sender: AnyObject) {
        
        if (self.timerRunning) {
            stop();
        }
        
        self.elapsedTime = 0.0;
        self.numberOfSecondsSilent = 0;
        if (self.mode == "automatic")
        {
            self.progressLabel.text = "\(Int(numberOfSecondsBeforeStop! / 100))" + " seconds until stop";
            self.progressTilStop.progress = 0;
            if (self.fullyStopped == true) {
                self.startButton.hidden = false;
                self.fullyStopped = false;
            }
        }
        self.displayTimeLabel.text = "00:00";
        self.startSoundTimer = NSTimer.scheduledTimerWithTimeInterval(0.03, target: self, selector: "startSoundTimerCallback", userInfo: nil, repeats: true);
        self.instructionLabel.hidden = false;
        
        
        
    }
    
    func keepTrackOfTime()
    {
        self.timeIncrementTimer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "updateTime", userInfo: nil, repeats: true);
    }
    //Updates the timer each second
    func updateTime()
    {
        
        self.elapsedTime = self.elapsedTime.advancedBy(0.01);
        
        let minutes = UInt8(self.elapsedTime / 60.0);
        
        let seconds = UInt8(self.elapsedTime - Double(minutes) * 60);
        
        let strMinutes = minutes > 9 ? String(minutes): "0" + String(minutes);
        let strSeconds = seconds > 9 ? String(seconds): "0" + String(seconds);
        
        self.displayTimeLabel.text = "\(strMinutes):\(strSeconds)";
        
    }
    
    func  levelTimerCallbackForEnd()
    {
        self.recorder.updateMeters()
        if (self.numberOfSecondsSilent >= self.numberOfSecondsBeforeStop)
        {
            stop();
            self.fullyStopped = true;
            var timeToSubtract = Double(-self.numberOfSecondsBeforeStop!) / 100;
            self.elapsedTime = self.elapsedTime.advancedBy(timeToSubtract);
            self.startButton.hidden = true;
            updateTime();
        }
        
        var elapsedSeconds : Int = (numberOfSecondsBeforeStop! - numberOfSecondsSilent) / 100 + 1 ;
        if (numberOfSecondsSilent == 0)
        {
            elapsedSeconds = numberOfSecondsBeforeStop! / 100;
        }
        self.progressLabel.text = "\(elapsedSeconds)" + " seconds until stop";
        
        println(self.recorder.peakPowerForChannel(0))
        if (self.recorder.averagePowerForChannel(0) < -40)
        {
            self.numberOfSecondsSilent++
            self.progressTilStop.progress = Float(numberOfSecondsSilent) / Float(numberOfSecondsBeforeStop!);
            
            
        }
        else {
            self.numberOfSecondsSilent = 0
            self.progressTilStop.progress = 0;
        }
        
    }
    
    //Sets up the recorder we'll be using to record sounds
    func setupRecorder() {
    
        var recordSettings = [
            AVFormatIDKey: kAudioFormatAppleLossless,
            AVEncoderAudioQualityKey : AVAudioQuality.Max.rawValue,
            AVEncoderBitRateKey : 320000,
            AVNumberOfChannelsKey: 2,
            AVSampleRateKey : 44100.0
        ];
        var error: NSError?;
        self.recorder = AVAudioRecorder(URL: NSURL.fileURLWithPath("/dev/null"), settings: recordSettings as [NSObject : AnyObject], error: &error);
        
        if let e = error {
            println(e.localizedDescription);
        } else {
            self.recorder.delegate = self;
            self.recorder.meteringEnabled = true;
            self.recorder.prepareToRecord(); // creates/overwrites the file at soundFileURL
        }
    }
    
        override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "toHome")
        {
            if (self.timerStarted) {
                self.timeIncrementTimer.invalidate();
            }
            if (self.mode == "automatic") {
                self.listenForSilenceTimer.invalidate();
            }

            
        }
    }
    
}
