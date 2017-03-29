//
//  ViewController.swift
//  DBDetectionTest
//
//  Created by Urian Chang on 3/28/17.
//  Copyright © 2017 CodingDojo. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation
import CoreAudio

class ViewController: UIViewController {

    var recorder : AVAudioRecorder!
    var levelTimer = Timer()
    var lowPassResults : Double = 0.0
    
    @IBOutlet weak var dbLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Make AudioSession: set it to PlayAndRecord and activate it
        let audioSession : AVAudioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try audioSession.setActive(true)
        } catch {
            print (error)
        }

        //Set up URL for audio file
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentDirectory = path.first! as NSString
        let str = documentDirectory.appendingPathComponent("recordTest.caf")
        let url = NSURL.fileURL(withPath: str as String)
        
        // make a dictionary to hold the recording settings so we can instantiate our AVAudioRecorder
        let recordSettings: [String : Any] = [AVFormatIDKey : kAudioFormatAppleIMA4,
                                                      AVSampleRateKey : 44100.0,
                                                      AVNumberOfChannelsKey : 2,
                                                      AVEncoderBitRateKey : 12800,
                                                      AVLinearPCMBitDepthKey : 16,
                                                      AVEncoderAudioQualityKey : AVAudioQuality.max.rawValue
            
        ]
        
        //Instantiate an AVAudioRecorder
        do {
            _ = try AVAudioRecorder(url: url, settings: recordSettings)
        } catch {
            print (error)
        }
        
        recorder.prepareToRecord()
        recorder.isMeteringEnabled = true
            
        //start recording
        recorder.record()
            
        //instantiate a timer to be called with whatever frequency we want to grab metering values
        self.levelTimer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(ViewController.levelTimerCallback), userInfo: nil, repeats: true)
        
    }

    //This selector/function is called every time our timer (levelTime) fires
    func levelTimerCallback() {
        //we have to update meters before we can get the metering values
        recorder.updateMeters()
        
        //print to the console if we are beyond a threshold value. Here I've used -7
        if recorder.averagePower(forChannel: 0) > -7 {
            print("Dis be da level I'm hearin' you in dat mic ")
            print(recorder.averagePower(forChannel: 0))
            print("Do the thing I want, mofo")
            dbLabel.text = String(recorder.averagePower(forChannel: 0))
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

