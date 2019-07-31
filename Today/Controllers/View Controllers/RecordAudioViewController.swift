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
    var recordingsViewController: RecordingListViewController? {
        get {
            return children.compactMap({$0 as? RecordingListViewController}).first
        }
    }
    var recorderViewController: RecorderViewController? {
        get {
            return children.compactMap({$0 as? RecorderViewController}).first
        }
    }

    //Outlets
    //Container Views
    @IBOutlet weak var recordingListView: UIView!
    @IBOutlet weak var recorderView: UIView!
    
    //Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension RecordAudioViewController: RecorderViewControllerDelegate {
    func didStartRecording() {
        if let recordings = self.recordingsViewController {
            recordings.fadeView.isHidden = false
            UIView.animate(withDuration: 0.5, animations: {
                recordings.fadeView.alpha = 1
            })
        }
    }
    
    func didAddRecording() {
        if let recording = self.recordingsViewController {
            recording.loadView()
        }
    }
    
    func didFinishRecording() {
        if let recordings = self.recordingsViewController {
            recordings.view.isUserInteractionEnabled = true
            UIView.animate(withDuration: 0.5, animations: {
                recordings.fadeView.alpha = 0
            }, completion: { (finished) in
                if finished {
                    recordings.fadeView.isHidden = true
                    DispatchQueue.main.async {
                        recordings.loadRecordings()
                    }
                }
            })
        }
    }
}

extension RecordAudioViewController: RecordingsViewControllerDelegate {
    func didStartPlayback() {
        if let recorder = self.recordingsViewController {
            recorder.fadeView.isHidden = false
            UIView.animate(withDuration: 0.5, animations: {
                recorder.fadeView.alpha = 1
            })
        }
    }
    
    func didFinishPlayback() {
        if let recorder = self.recordingsViewController {
            recorder.view.isUserInteractionEnabled = true
            UIView.animate(withDuration: 0.5, animations: {
                recorder.fadeView.alpha = 0
            }, completion: { (finished) in
                if finished {
                    recorder.fadeView.isHidden = false
                }
            })
        }
    }
}
