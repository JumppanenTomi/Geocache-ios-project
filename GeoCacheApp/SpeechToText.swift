//
//  SpeechToText.swift
//  GeoCacheApp
//
//  Created by iosdev on 8.4.2023.
//

import SwiftUI
import Speech

class SpeechRecognizer: NSObject, ObservableObject, SFSpeechRecognizerDelegate {
    private let audioEngine = AVAudioEngine()
    private let speechRecognizer = SFSpeechRecognizer()
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?

    override init() {
        super.init()
        speechRecognizer?.delegate = self
        SFSpeechRecognizer.requestAuthorization { (status) in
            // Handle authorization status here
        }
    }

    func startRecording(completion: @escaping (String?, Error?) -> Void) {
        guard let recognizer = speechRecognizer, recognizer.isAvailable else {
            completion(nil, NSError(domain: "SpeechRecognizer", code: -1, userInfo: [NSLocalizedDescriptionKey: "Speech recognition is not available"]))
            return
        }

        do {
            try setupRecognition(completion: completion)
        } catch {
            completion(nil, error)
        }
    }

    func stopRecording() {
        audioEngine.stop()
        recognitionRequest?.endAudio()
    }

    private func setupRecognition(completion: @escaping (String?, Error?) -> Void) throws {
        let inputNode = audioEngine.inputNode
        let recordingFormat = inputNode.outputFormat(forBus: 0)

        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        guard let recognitionRequest = recognitionRequest else {
            fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
        }
        recognitionRequest.shouldReportPartialResults = true

        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest) { result, error in
            if let result = result {
                let text = result.bestTranscription.formattedString
                DispatchQueue.main.async {
                    completion(text, nil)
                }
                if result.isFinal {
                    self.audioEngine.stop()
                    inputNode.removeTap(onBus: 0)
                    self.recognitionRequest = nil
                    self.recognitionTask = nil
                }
            } else if let error = error {
                self.stopRecording()
                completion(nil, error)
            }
        }

        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            self.recognitionRequest?.append(buffer)
        }

        audioEngine.prepare()
        try audioEngine.start()
    }
}
