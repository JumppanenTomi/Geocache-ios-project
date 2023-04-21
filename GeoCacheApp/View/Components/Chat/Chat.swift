//
//  Chat.swift
//  GeoCacheApp
//
//  Created by iosdev on 20.4.2023.
//

import SwiftUI

struct Chat: View {
    var image: Image = Image("profile-image")
    var contact: String
    @State private var isRecording: Bool = false
    @ObservedObject private var speechRecognizer = SpeechRecognizer()
    @State private var message = ""

    var body: some View {
        VStack {
            HStack{
                image
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 50, height: 50)
                Spacer()
                Text(contact)
                    .font(.title2)
            }.padding(.bottom, 20)
            ScrollView(.vertical){
                Message(message: "Hello! Did you find this one cache already?", sender: false)
                Message(message: "Hi! No I didnt. I was looking for it and then some local told me that its no longer there.", sender: true)
            }
            HStack {
                if message != ""{
                    Button(action: {message = ""}) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.red)
                            .font(.system(size: 14))
                            .padding(.leading, 10)
                    }
                }
                TextField("Message", text: $message)
                    .padding(.horizontal)
                    .onSubmit {
                        print("Message sended")
                    }
                Button(action: {
                    if isRecording {
                        speechRecognizer.stopRecording()
                    } else {
                        speechRecognizer.startRecording { (text, error) in
                            if let text = text {
                                self.message = text
                            }
                        }
                    }
                    isRecording.toggle()
                }) {
                    Image(systemName: isRecording ? "stop.fill" : "mic.fill")
                        .foregroundColor(.blue)
                        .font(.system(size: 20))
                }
                if message != ""{
                    Button(action: {}) {
                        Image(systemName: "arrow.up.circle.fill")
                            .foregroundColor(.green)
                            .font(.system(size: 20))
                            .padding(.leading, 10)
                    }
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 50).fill(Color(.systemGray6)))
                    .padding(.vertical, 5)
                    .autocapitalization(.sentences)
        }
        .padding()
    }
}

struct Chat_Previews: PreviewProvider {
    static var previews: some View {
        Chat(contact: "John Doe")
    }
}
