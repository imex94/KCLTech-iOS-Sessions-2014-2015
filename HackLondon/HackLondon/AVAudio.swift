//
//  AVAudioPlayer.swift
//  HackLondon
//
//  Created by Alex Telek on 26/02/2015.
//  Copyright (c) 2015 KCLTech. All rights reserved.
//

import UIKit
import AVFoundation

class AVAudio: UIViewController {

    var player: AVAudioPlayer?
    var recorder: AVAudioRecorder?
    
    @IBOutlet weak var lblHelp: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let dirPaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let soundFilePath = dirPaths[0].stringByAppendingPathComponent("sound.mp3")
        let soundFileURL = NSURL(fileURLWithPath:   soundFilePath)
        let recordSettings =
        [AVEncoderAudioQualityKey: AVAudioQuality.High.rawValue,
            AVEncoderBitRateKey: 16,
            AVNumberOfChannelsKey: 2,
            AVSampleRateKey: 44100.0]
        
        recorder = AVAudioRecorder(URL: soundFileURL, settings: recordSettings as [NSObject : AnyObject], error: nil)
        
        recorder?.prepareToRecord()
    }

    @IBAction func recordAudio(sender: AnyObject) {
        if recorder?.recording == false {
            
            let audioSession = AVAudioSession.sharedInstance()
            audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord,error: nil)
            audioSession.setActive(true, error: nil)
            audioSession.overrideOutputAudioPort(AVAudioSessionPortOverride.Speaker, error: nil)
            
            lblHelp.text = "RECORD"
            lblHelp.textColor = UIColor.redColor()
            
            recorder?.record()
        }
    }
    
    @IBAction func stopAudio(sender: AnyObject) {
        recorder?.stop()
        
        playAudio()
    }
    
    func playAudio() {
        if let url = recorder?.url {
            player = AVAudioPlayer(contentsOfURL: url, error: nil)
            
            lblHelp.text = "PLAY"
            lblHelp.textColor = UIColor.blackColor()
            
            player?.volume = 1.0
            
            player?.prepareToPlay()
            player?.play()
        }
    }
}
