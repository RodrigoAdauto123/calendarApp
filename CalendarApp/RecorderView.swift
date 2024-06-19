//
//  RecorderView.swift
//  NoteCal
//
//  Created by Rodrigo Adauto Ortiz on 18/06/24.
//

import SwiftUI

struct RecorderView: View {

    @EnvironmentObject var recorderViewModel: AudioRecorder
    @State private var isStopRecording: Bool = false
    @Binding var hasRecording: Bool
    var audioRecorderName: String = .empty
    var typeTask: TypeTask
    
    var body: some View {
            if recorderViewModel.isRecording {
                Button(action: {
                    recorderViewModel.stopRecording()
                    isStopRecording = true
                    if typeTask == .EDIT {
                        hasRecording = false
                    }
                }, label: {
                    Image(systemName: "mic.circle.fill")
                        .frame(width: 50,height: 50)
                    Text("when you finish speaking press the icon again")
                        .frame(minWidth: .zero, maxWidth: .infinity, alignment: .center)
                    
                })
                
            } else {
                Button(action: {
                    recorderViewModel.startRecording(id: "tempAudioRecoder")
                    isStopRecording = false
                }, label: {
                    Image(systemName: "mic.circle")
                        .frame(width: 50,height: 50)
                    Text("Add some audio for your task")
                        .frame(minWidth: .zero, maxWidth: .infinity, alignment: .center)
                })
            }
            
            if isStopRecording || hasRecording {
                Button(action: {
                    recorderViewModel.playAudio(audioURL: hasRecording ? audioRecorderName : "tempAudioRecoder")
                }) {
                    Text("Play Audio")
                        .padding(.horizontal, 20)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .frame(minWidth: .zero, maxWidth: .infinity, alignment: .center)
                }
                .padding()
            }
    }
}
