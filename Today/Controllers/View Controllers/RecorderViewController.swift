//
//  RecorderViewController.swift
//  Today
//
//  Created by Madison Kaori Shino on 7/31/19.
//  Copyright © 2019 Madi S. All rights reserved.
//

import UIKit
import AVFoundation

enum RecordingState {
    case recording
    case stopped
}

protocol RecorderViewControllerDelegate: class {
    func didStartRecording()
    func didAddRecording()
    func didFinishRecording()
}

class RecorderViewController: UIViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate {

    //Properties
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!
    var recordCount: Int = 0
    var recordings: [Audio] = []
    var isRecording = false
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
        setInitialView()
        setUpRecorder()
        audioRecorder = nil
    }
    
    //Actions
    //Begin or Stop Recording
    @IBAction func recordButtonTapped(_ sender: Any) {
        if isRecording != true {
            recordButton.titleLabel?.text = "Stop Recording"
            recordingVisualView.isHidden = false
            recordingTimeLabel.isHidden = false
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.handleView.alpha = 1
                self.recordingTimeLabel.alpha = 1
                self.recordingVisualView.alpha = 1
                //self.view.frame = CGRect(x: 0, y: self.view.frame.height, width: self.view.bounds.width, height: -300)
                self.view.layoutIfNeeded()
            }, completion: nil)
            setInitialView()
            setUpRecorder()
            beginRecording()
            isRecording = true
        } else {
            setInitialView()
            stopRecording(success: true)
        }
    }
    
    //Helper Functions
    //Settings for small 'handle' bar line at top of movable view
    fileprivate func setUpHandleView() {
        handleView.layer.cornerRadius = 4
        handleView.backgroundColor = UIColor.white
    }
    
    //Settings for the Record Button
    fileprivate func setUpRecordButton() {
        recordButton.layer.cornerRadius = 10
        recordButton.setTitleColor(.white
            , for: .normal)
        recordButton.titleLabel?.text = "Begin Recording"
        isRecording = false
    }
    
    //Settings for Time Label
    fileprivate func setUpTimeLabel() {
//        recordingTimeLabel.text =
        recordingTimeLabel.textColor = UIColor.white
    }
    
    fileprivate func setUpAudioVisualView() {
        recordingVisualView.alpha = 0
        recordingVisualView.isHidden = true
        //autolayout constraints?
    }
    
    //Initial Settings for View
    fileprivate func setInitialView() {
        isRecording = false
        recordButton.titleLabel?.text = "Begin Recording"
        recordingVisualView.isHidden = true
        recordingTimeLabel.isHidden = true
//        self.view.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 150)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.handleView.alpha = 0
            self.recordingTimeLabel.alpha = 0
            self.recordingVisualView.alpha = 0
//            self.view.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 150)
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    //Update View Based off Recorder State
    private func updateUI(_ recorderState: RecordingState) {
        switch recorderState {
        case .recording:
            UIApplication.shared.isIdleTimerDisabled = true
            recordingVisualView.isHidden = false
            recordingTimeLabel.isHidden = false
            break
        case .stopped:
            UIApplication.shared.isIdleTimerDisabled = false
            recordingVisualView.isHidden = true
            recordingTimeLabel.isHidden = true
            break
        }
    }
    
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
    
    //Gets path to Directory
    func createNewFileURL() -> URL {
        //Search for uRLS in document direcoty
        let audioFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        //First Url as our path
        let documentDirectory = audioFilePath[0]
        let audioURL = documentDirectory.appendingPathComponent("\(recordCount).m4a")
        return audioURL
    }
    
    //Alert User When Recording Fails
    func displayAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "dismiss", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    //Recording Functions
    //Begin and create a new audio file
    func beginRecording() {
        recordCount += 1
        let audioFileName = createNewFileURL()
        let newAudioFile = Audio(audioRecording: audioFileName, fileName: "Audio File \(recordCount)")
        recordings.append(newAudioFile)
        do {
            audioRecorder = try AVAudioRecorder(url: audioFileName, settings: recordingSettings)
            try recordingSession.setCategory(AVAudioSession.Category.record)
            recordButton.setTitle("Stop Recording", for: .normal)
            audioRecorder.delegate = self
            audioRecorder.record()
        } catch {
            stopRecording(success: false)
            displayAlert(title: "Uh Oh!", message: "Recording Failed")
        }
        updateUI(.recording)
    }
    
    func stopRecording(success: Bool) {
        audioRecorder.stop()
        audioRecorder = nil
        if success {
            recordButton.setTitle("Begin Recording", for: .normal)
        } else {
            recordButton.setTitle("Re-Record Recording", for: .normal)
            displayAlert(title: "Uh Oh!", message: "Recording Failed")
            print("Recording Failed")
        }
        updateUI(.stopped)
    }
}

//
///*
// // MARK: - Navigation
//
// // In a storyboard-based application, you will often want to do a little preparation before navigation
// override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
// // Get the new view controller using segue.destination.
// // Pass the selected object to the new view controller.
// }
// */
//
//
//func preparePlayer(path: URL) {
//    var error: NSError?
//    do {
//        audioPlayer = try AVAudioPlayer(contentsOf: path)
//    } catch let error1 as NSError {
//        error = error1
//        audioPlayer = nil
//    }
//    if let err = error {
//        print(err.localizedDescription)
//    } else {
//        audioPlayer.delegate = self
//        audioPlayer.prepareToPlay()
//        audioPlayer.volume = 10
//    }
//}
//}
//



//
////Audio Visualizer Class for Setup
//class AudioVisualizerView: UIView {
//
//    // Bar width
//    var barWidth: CGFloat = 4.0
//
//    // Indicate that waveform should draw active/inactive state
//    var active = false {
//        didSet {
//            if self.active {
//                self.color = UIColor.red.cgColor
//            }
//            else {
//                self.color = UIColor.gray.cgColor
//            }
//        }
//    }
//    // Color for bars
//    var color = UIColor.gray.cgColor
//    // Given waveforms
//    var waveforms: [Int] = Array(repeating: 0, count: 100)
//
//    // MARK: - Init
//    override init (frame : CGRect) {
//        super.init(frame : frame)
//        self.backgroundColor = UIColor.clear
//    }
//
//    required init?(coder decoder: NSCoder) {
//        super.init(coder: decoder)
//        self.backgroundColor = UIColor.clear
//    }
//
//    // MARK: - Draw bars
//    override func draw(_ rect: CGRect) {
//        guard let context = UIGraphicsGetCurrentContext() else {
//            return
//        }
//        context.clear(rect)
//        context.setFillColor(red: 0, green: 0, blue: 0, alpha: 0)
//        context.fill(rect)
//        context.setLineWidth(1)
//        context.setStrokeColor(self.color)
//        let w = rect.size.width
//        let h = rect.size.height
//        let t = Int(w / self.barWidth)
//        let s = max(0, self.waveforms.count - t)
//        let m = h / 2
//        let r = self.barWidth / 2
//        let x = m - r
//        var bar: CGFloat = 0
//        for i in s ..< self.waveforms.count {
//            var v = h * CGFloat(self.waveforms[i]) / 50.0
//            if v > x {
//                v = x
//            }
//            else if v < 3 {
//                v = 3
//            }
//            let oneX = bar * self.barWidth
//            var oneY: CGFloat = 0
//            let twoX = oneX + r
//            var twoY: CGFloat = 0
//            var twoS: CGFloat = 0
//            var twoE: CGFloat = 0
//            var twoC: Bool = false
//            let threeX = twoX + r
//            let threeY = m
//            if i % 2 == 1 {
//                oneY = m - v
//                twoY = m - v
////                twoS = -180.degreesToRadians
////                twoE = 0.degreesToRadians
//                twoC = false
//            }
//            else {
//                oneY = m + v
//                twoY = m + v
////                twoS = 180.degreesToRadians
////                twoE = 0.degreesToRadians
//                twoC = true
//            }
//            context.move(to: CGPoint(x: oneX, y: m))
//            context.addLine(to: CGPoint(x: oneX, y: oneY))
//            context.addArc(center: CGPoint(x: twoX, y: twoY), radius: r, startAngle: twoS, endAngle: twoE, clockwise: twoC)
//            context.addLine(to: CGPoint(x: threeX, y: threeY))
//            context.strokePath()
//            bar += 1
//        }
//    }
//}
