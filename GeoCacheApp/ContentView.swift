import SwiftUI
import Speech

struct ContentView: View {
    @State private var searchText: String = ""
    @State private var isRecording: Bool = false
    @ObservedObject private var speechRecognizer = SpeechRecognizer()

    var body: some View {
        VStack {
            HStack {
                TextField("Search", text: $searchText)
                    .padding(7)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal)

                Button(action: {
                    if isRecording {
                        speechRecognizer.stopRecording()
                    } else {
                        speechRecognizer.startRecording { (text, error) in
                            if let text = text {
                                self.searchText = text
                            }
                        }
                    }
                    isRecording.toggle()
                }) {
                    Image(systemName: isRecording ? "stop.fill" : "mic.fill")
                        .padding()
                }
            }
            Spacer()
        }
    }
}

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
