//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Pedro De Morais Chiossi on 29/01/18.
//  Copyright © 2018 Pedro De Morais Chiossi. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    var audioRecorder: AVAudioRecorder!
    
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopRecordingButton.isEnabled = false
        // Do any additional setup after loading the view, typically from a nib.
    }
    

    
    func configureUI(isRecording: Bool) {
            if isRecording{
                recordingLabel.text = "Recording in Progress"
                stopRecordingButton.isEnabled = true
                recordButton.isEnabled = false
            }
            else{
                recordButton.isEnabled = true
                stopRecordingButton.isEnabled = false
                recordingLabel.text = "Tap to Record"
            }
    }
    
    @IBAction func recordAudio(_ sender: UIButton) {
        configureUI(isRecording: true)
    

        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = 	URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }
    @IBAction func stopRecording(_ sender: UIButton) {
        configureUI(isRecording: false)
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
        
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag{
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else{
            let alert = UIAlertController(title: "Error", message: "Recording was not successful", preferredStyle: .alert)
            self.present(alert, animated: true) 
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            if let playSoundsVC = segue.destination as? PlaySoundsViewController{
                if let recordedAudioURL = sender as? URL{
                    playSoundsVC.recordedAudioURL = recordedAudioURL
                }
            }
        }
    }
    
}




