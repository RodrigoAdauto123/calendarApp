//
//  AudioRecorder.swift
//  NoteCal
//
//  Created by Rodrigo Adauto Ortiz on 18/06/24.
//

import Foundation
import AVFoundation

class AudioRecorder: NSObject, ObservableObject {
    var audioRecorder: AVAudioRecorder?
    var audioPlayer: AVAudioPlayer?
    @Published var isRecording = false
    var currentAudioFilename: String?
    var currentAudioURL: URL?
    
    func setUpRecoder(id: String) throws {
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(.playAndRecord, mode: .default)
        try audioSession.setActive(true)
        
        let recorderSettings: [String : Any] = [
            AVFormatIDKey: kAudioFormatMPEG4AAC,
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.medium.rawValue
        ]
        
        guard let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let audioFileName = documentPath.appendingPathComponent(id + ".m4a")
        currentAudioFilename = audioFileName.lastPathComponent
        currentAudioURL = audioFileName
        
        audioRecorder = try AVAudioRecorder(url: audioFileName, settings: recorderSettings)
        audioRecorder?.delegate = self
        audioRecorder?.prepareToRecord()
    }
    
    func startRecording(id: String) {
        do {
            try setUpRecoder(id: id)
            audioRecorder?.record()
            isRecording = true
        } catch {
            print("Failed to start recording: \(error)")
        }
    }
    
    func stopRecording() {
        audioRecorder?.stop()
        isRecording = false
        
        do {
            try AVAudioSession.sharedInstance().setActive(false)
        } catch {
            print("Failed to deactivate audio session: \(error)")
        }
    }
    
    func playAudio(audioURL: String) {
        guard let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let audioFileName = documentPath.appendingPathComponent(audioURL + ".m4a")
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioFileName)
            audioPlayer?.play()
        } catch {
            print("Failed to play audio: \(error)")
        }
    }
    
    
}

extension AudioRecorder: AVAudioRecorderDelegate {
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            print("Recording finished successfully.")
        } else {
            print("Recording failed.")
        }
    }
}
