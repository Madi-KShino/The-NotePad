//
//  RecordingListViewController.swift
//  Today
//
//  Created by Madison Kaori Shino on 7/31/19.
//  Copyright © 2019 Madi S. All rights reserved.
//

import UIKit
import AVFoundation

protocol RecordingsViewControllerDelegate: class {
    func didStartPlayback()
    func didFinishPlayback()
}

class RecordingListViewController: UIViewController {

    //Properties
    var recordings: [Audio] = [] 
    var audioPlayer: AVAudioPlayer?
    weak var delegate: RecordingsViewControllerDelegate?
    
    //Outlets
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var fadeView: UIView!
    
    //Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadRecordings()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if self.isPlaying() {
            self.stopPlayingAudio()
        }
        super.viewWillDisappear(animated)
    }
    
    //Helper Functions
    //Set Up Table View
    func setUpTableView() {
        self.listTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 180, right: 0)
    }
    
    //Retrieve Recordings from their URL
    func loadRecordings() {
        recordings.removeAll()
        let fileManager = FileManager.default
        let directory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        do {
            let paths = try fileManager.contentsOfDirectory(at: directory, includingPropertiesForKeys: nil, options: [])
            for path in paths {
                let recording = Audio(audioRecording: path, fileName: path.lastPathComponent)
                self.recordings.append(recording)
            }
            self.listTableView.reloadData()
        } catch {
            print(error, error.localizedDescription)
        }
    }
    
    //Function to check playing status of audio player
    func isPlaying() -> Bool {
        if let player = audioPlayer {
            return player.isPlaying
        }
        return false
    }
    
    //Play Audio Functions
    //Play
    func startPlayingAudio(audioFile: URL) {
        if let delegate = delegate {
            delegate.didStartPlayback()
        }
        do {
            //Activate playback session
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(.playAndRecord, options: .defaultToSpeaker)
            try session.setActive(true)
        } catch let error as NSError {
            print("Error in \(#function): \(error.localizedDescription) /n---/n \(error)")
            return
        }
        do {
            //With audio from file URL
            let data = try Data(contentsOf: audioFile)
            audioPlayer = try AVAudioPlayer(data: data, fileTypeHint: AVFileType.caf.rawValue)
        } catch let error as NSError {
            print("Error in \(#function): \(error.localizedDescription) /n---/n \(error)")
            return
        }
        if let player = audioPlayer {
            player.delegate = self
            player.prepareToPlay()
            player.volume = 1
            player.play()
        }
    }
    
    //Stop Playback
    func stopPlayingAudio() {
        if let delegate = delegate {
            delegate.didFinishPlayback()
        }
        if let paths = listTableView.indexPathsForSelectedRows {
            for path in paths {
                listTableView.deselectRow(at: path, animated: true)
            }
        }
        if let player = audioPlayer {
            player.pause()
        }
        audioPlayer = nil
        do {
            try AVAudioSession.sharedInstance().setActive(false)
        } catch let error as NSError {
            print("Error in \(#function): \(error.localizedDescription) /n---/n \(error)")
            return
        }
    }
}

//Table View Data Source
extension RecordingListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rowCount = recordings.count
        if rowCount > 0 {
            listTableView.isHidden = false
        } else {
            listTableView.isHidden = true
        }
        return rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recordingCell", for: indexPath)
        let audioFile = recordings[indexPath.row]
        cell.textLabel?.text = audioFile.fileName
        cell.detailTextLabel?.text = audioFile.audioRecording.absoluteString
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.isPlaying() {
            self.stopPlayingAudio()
        }
        let recording = recordings[indexPath.row]
        self.startPlayingAudio(audioFile: recording.audioRecording)
    }
}

//Audio Playback Data Source
extension RecordingListViewController: AVAudioPlayerDelegate {
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        if let error = error {
            print("Error in \(#function): \(error.localizedDescription) /n---/n \(error)")
        }
        self.stopPlayingAudio()
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        self.stopPlayingAudio()
    }
}
