//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Pedro De Morais Chiossi on 08/02/18.
//  Copyright © 2018 Pedro De Morais Chiossi. All rights reserved.
//

import UIKit
import AVFoundation
	
class PlaySoundsViewController: UIViewController {
    
    @IBOutlet weak var slowButton: UIButton!
    @IBOutlet weak var highPitchButton: UIButton!
    @IBOutlet weak var fastButton: UIButton!
    @IBOutlet weak var lowPitchButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var recordedAudioURL: URL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int {
        case fast = 0, slow, highpitch, lowpitch, echo, reverb}
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButtons()
        
    }

    private func configureButtons() {
        configure(button: slowButton)
        configure(button: highPitchButton)
        configure(button: fastButton)
        configure(button: lowPitchButton)
        configure(button: echoButton)
        configure(button: reverbButton)
        configure(button: stopButton)
    }
    
    private func configure(button: UIButton	){
        button.imageView?.contentMode = .scaleAspectFit
    }
    
    @IBAction func playSoundForButton(_ sender: UIButton) {
        //print("Play Sound Button Pressed")
        switch(ButtonType(rawValue: sender.tag)!) {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .highpitch:
            playSound(pitch: 1000)
        case .lowpitch:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        configureUI(.playing)
    }
    
    @IBAction func stopButtonPressed(_ sender: AnyObject) {
        stopAudio()
    }
    

}
