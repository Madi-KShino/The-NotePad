//
//  RecordAudioViewController.swift
//  Today
//
//  Created by Madison Kaori Shino on 7/29/19.
//  Copyright © 2019 Madi S. All rights reserved.
//

import UIKit
import AVFoundation

class RecordAudioViewController: UIViewController {

    //Properties
    
    //Outlets
    @IBOutlet weak var recordingButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    func setUpView() {
        recordingSession = AVAudioSession.sharedInstance()
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        self.buttonViewWhenRecording()
                    } else {
                        //If failed
                        return
                    }
                }
            }
        } catch {
            //Failed
        }
    }
    
    func buttonViewWhenRecording() {
        recordingButton.isEnabled = true
        recordingButton.setTitle("Tap to Record", for: .normal)
        recordingButton.addTarget(self, action: #selector(recordButtonTapped), for: .touchUpInside)
        playButton.isEnabled = false
        view.addSubview(recordingButton)
    }
    
    @objc func recordButtonTapped() {
        
    }
    
    func beginRecording() {
    }
    
    func 
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
