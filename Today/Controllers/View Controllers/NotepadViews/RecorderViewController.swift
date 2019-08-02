//
//  RecorderViewController.swift
//  Today
//
//  Created by Madison Kaori Shino on 7/31/19.
//  Copyright © 2019 Madi S. All rights reserved.
//

import UIKit
import AVFoundation
import Accelerate

enum RecordingState {
    case recording
    case stopped
}

protocol RecorderViewControllerDelegate: class {
    func didStartRecording()
    func didFinishRecording()
}

class RecorderViewController: UIViewController {

    //Properties
    weak var delegate: RecorderViewControllerDelegate?
    var audioView = AudioVisualizerContainerView()
    var recordings: [Audio] = []
    var isRecording = false
    var recordingTime: Double = 0
    var renderTime: Double = 0
    var silenceTime: Double = 0
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!
    var audioFile: AVAudioFile?
    var audioEngine = AVAudioEngine()
    let recordingSettings = [AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                             AVSampleRateKey: 1200,
                             AVNumberOfChannelsKey: 1,
                             AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue]
    
    //Outlets
    @IBOutlet weak var handleView: UIView!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recordingTimeLabel: UILabel!
    @IBOutlet weak var recordingVisualView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpHandleView()
        setUpRecordButton()
        setUpTimeLabel()
        setUpAudioVisualView()
        setUpRecorder()
        audioRecorder = nil
    }
    
    //Actions
    //Begin or Stop Recording
    @IBAction func recordButtonTapped(_ sender: Any) {
        var defaultFrame: CGRect = CGRect(x: 0, y: 24, width: view.frame.width, height: 150)
        if isRecording == false {
            defaultFrame = self.view.frame
            recordingVisualView.isHidden = false
            recordButton.titleLabel?.text = "Stop Recording"
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.handleView.alpha = 1
                self.recordingTimeLabel.alpha = 1
                self.recordingVisualView.alpha = 1
                self.view.frame = CGRect(x: 0, y: self.view.frame.height, width: self.view.bounds.width, height: -300)
                self.view.layoutIfNeeded()
            }, completion: nil)
            beginRecording()
            isRecording = true
        } else {
            recordingVisualView.isHidden = true
            recordButton.titleLabel?.text = "Begin Recording"
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.handleView.alpha = 0
                self.recordingTimeLabel.alpha = 0
                self.recordingVisualView.alpha = 0
                self.view.frame = defaultFrame
                self.view.layoutIfNeeded()
            }, completion: nil)
            stopRecording(success: true)
            isRecording = false
        }
    }
    
    //Helper Functions
    //Settings for small 'handle' bar line at top of movable view
    fileprivate func setUpHandleView() {
        handleView.layer.cornerRadius = 4
        handleView.alpha = 0
        handleView.backgroundColor = UIColor.white
        handleView.translatesAutoresizingMaskIntoConstraints = false
        handleView.widthAnchor.constraint(equalToConstant: 37.5).isActive = true
        handleView.heightAnchor.constraint(equalToConstant: 5).isActive = true
        handleView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        handleView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
    }
    
    //Settings for the Record Button
    fileprivate func setUpRecordButton() {
        isRecording = false
        recordButton.layer.cornerRadius = 10
        recordButton.setTitleColor(.white, for: .normal)
        recordButton.titleLabel?.text = "Begin Recording"
        recordButton.translatesAutoresizingMaskIntoConstraints = false
        recordButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32).isActive = true
        recordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        recordButton.widthAnchor.constraint(equalToConstant: view.frame.width / 2).isActive = true
        recordButton.heightAnchor.constraint(equalToConstant: 30 ).isActive = true
    }
    
    //Settings for Time Label
    fileprivate func setUpTimeLabel() {
        recordingTimeLabel.text = "00.00"
        recordingTimeLabel.textColor = UIColor.white
        recordingTimeLabel.alpha = 0
        recordingTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        recordingTimeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        recordingTimeLabel.bottomAnchor.constraint(equalTo: recordButton.topAnchor, constant: -16).isActive = true
    }
    
    //Settings for Audio Visualizer View
    fileprivate func setUpAudioVisualView() {
        recordingVisualView.frame = CGRect(x: 0, y: 24, width: view.frame.width, height: 135)
        recordingVisualView.alpha = 0
        recordingVisualView.isHidden = true
        recordingVisualView.backgroundColor = .gray
    }
    
    //Update View Based off Recorder State
    private func updateUI(_ recorderState: RecordingState) {
        switch recorderState {
        case .recording:
            recordButton.titleLabel?.text = "Stop Recording"
            UIApplication.shared.isIdleTimerDisabled = true
            recordingVisualView.isHidden = false
            recordingTimeLabel.isHidden = false
            break
        case .stopped:
            recordButton.titleLabel?.text = "Begin Recording"
            UIApplication.shared.isIdleTimerDisabled = false
            recordingVisualView.isHidden = true
            recordingTimeLabel.isHidden = true
            break
        }
    }
    
    //Recording Functions
    //Prepare the Recorder & Request Permissions
    func setUpRecorder() {
        recordingSession = AVAudioSession.sharedInstance()
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { allowed in
                DispatchQueue.main.async {
                    if allowed {
                        self.recordButton.isEnabled = true
                        print("Permission to Access Microphone accepted")
                    } else {
                        print("Denied Microphone Access")
                        return
                    }
                }
            }
        } catch {
            print("Failed: \(error.localizedDescription)")
        }
    }
    
    //Begin and create a new audio file
    func beginRecording() {
        delegate?.didStartRecording()
        recordingTime = NSDate().timeIntervalSince1970
        //Activate Audio Session
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(.playAndRecord, mode: .default)
            try session.setActive(true)
        } catch let error as NSError {
            print("Error in \(#function): \(error.localizedDescription) /n---/n \(error)")
            return
        }
        //Recording Settings
        let inputNode = self.audioEngine.inputNode
        let format = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: format) { (buffer, time) in
            let level: Float = -50
            let length: UInt32 = 1024
            buffer.frameLength = length
            let channels = UnsafeBufferPointer(start: buffer.floatChannelData, count: Int(buffer.format.channelCount))
            var value: Float = 0
            vDSP_meamgv(channels[0], 1, &value, vDSP_Length(length))
            var average: Float = ((value == 0) ? -100 : 20.0 * log10f(value))
            if average > 0 {
                average = 0
            } else if average < -100 {
                average = -100
            }
            let silent = average < level
            let time = NSDate().timeIntervalSince1970
            if time - self.renderTime > 0.1 {
                let floats = UnsafeBufferPointer(start: channels[0], count: Int(buffer.frameLength))
                let frame = floats.map({ (f) -> Int in
                    return Int(f * Float(Int16.max))
                })
                //Set Recording Time Label
                DispatchQueue.main.async {
                    let seconds = (time - self.recordingTime)
                    self.recordingTimeLabel.text = seconds.toTimeString
                    self.renderTime = time
                    let len = self.audioView.waveForms.count
                    for i in 0 ..< len {
                        let idx = ((frame.count - 1) * i) / len
                        let f: Float = sqrt(1.5 * abs(Float(frame[idx])) / Float(Int16.max))
                        self.audioView.waveForms[i] = min(49, Int(f * 50))
                    }
                    self.audioView.waveIsActive = !silent
                    self.audioView.setNeedsDisplay()
                }
            }
            //Create the Recording Data
            if self.audioFile == nil {
                self.audioFile = self.createAudioRecordFile()
            }
            if let newFile = self.audioFile {
                do {
                    try newFile.write(from: buffer)
                } catch let error as NSError {
                    print("Error in \(#function): \(error.localizedDescription) /n---/n \(error)")
                }
            }
        }
        do {
            self.audioEngine.prepare()
            try self.audioEngine.start()
        } catch let error as NSError {
                print("Error in \(#function): \(error.localizedDescription) /n---/n \(error)")
            self.displayAlert(title: "Uh Oh!", message: "Recording Failed")
        }
        updateUI(.recording)
    }
    
    func stopRecording(success: Bool) {
        delegate?.didFinishRecording()
        self.audioFile = nil
        self.audioEngine.inputNode.removeTap(onBus: 0)
        do {
            try AVAudioSession.sharedInstance().setActive(false)
        } catch let error as NSError {
            displayAlert(title: "Uh Oh!", message: "Recording Failed")
            print("Error in \(#function): \(error.localizedDescription) /n---/n \(error)")
            return
        }
        updateUI(.stopped)
    }
    
    func createAudioRecordFile() -> AVAudioFile? {
        let urlPath = self.createNewFileURL()
        do {
            let file = try AVAudioFile(forWriting: urlPath, settings: recordingSettings, commonFormat: .pcmFormatFloat32, interleaved: true)
            
//            let data = try Data(contentsOf: urlPath)
            return file
        } catch let error as NSError {
            print("Error in \(#function): \(error.localizedDescription) /n---/n \(error)")
            return nil
        }
    }
    
    //Gets path to Directory for URL Storage
    func createNewFileURL() -> URL {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "MM-dd-HH-mm-ss-SSS"
        let newFileName = "Recording: \(dateFormat.string(from: Date())).wav"
        //Search for uRLS in document direcoty
        let audioFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        //First Url as our path
        let documentDirectory = audioFilePath
        let audioURL = documentDirectory.appendingPathComponent(newFileName)
        return audioURL
    }
    
    //Alert User When Recording Fails
    func displayAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "dismiss", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
