//
//  AddCache.swift
//  GeoCacheApp
//
//  Created by iosdev on 9.4.2023.
//

import SwiftUI
import MapKit

struct AddCache: View {
    @State private var title: String = ""
    @State private var desc: String = ""
    @State private var difficulty: Int = 1
    @State private var size: Int = 1
    @State private var showAlert = false
    @State private var isEditingDif = false
    @State private var isEditingSize = false
    @State private var userLocation: CLLocationCoordinate2D?

    
    var body: some View {
         ZStack{
             ScrollView {
                Text("Add Cache")
                    .font(.title)
                    .padding()
                HStack {
                    TextField("Title", text: $title)
                        .padding(.horizontal)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16).fill(Color(.systemGray6)))
                .padding(.vertical, 5)
                .autocapitalization(.sentences)
                HStack {
                    TextField("Description", text: $desc)
                        .padding(.horizontal)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16).fill(Color(.systemGray6)))
                .padding(.vertical, 5)
                .autocapitalization(.sentences)
                VStack{
                    Text("Difficulty")
                        .font(.title2)
                        Slider(
                            value: Binding(
                                get: { Double(difficulty) },
                                set: { difficulty = Int($0) }
                            ),
                            in: 1...5,
                            step: 1,
                            onEditingChanged: { editing in
                                isEditingDif = editing
                            }
                        )
                        Text("\(difficulty)")
                            .foregroundColor(isEditingDif ? .red : .blue)
                }.padding(.bottom)
                VStack{
                    Text("Size")
                        .font(.title2)
                        Slider(
                            value: Binding(
                                get: { Double(size) },
                                set: { size = Int($0) }
                            ),
                            in: 1...5,
                            step: 1,
                            onEditingChanged: { editing in
                                isEditingSize = editing
                        }
                    )
                    Text("\(size)")
                    .foregroundColor(isEditingSize ? .red : .blue)
                }.padding(.bottom)
                Text("Your location will be marked as cache hiding spot")
                    .font(.title2)
                    .padding()
                UserLocationMap(coordinate: userLocation)
                    .edgesIgnoringSafeArea(.all)
                    .frame(height: 300)
                    .cornerRadius(16)
                    .onAppear {
                        getUserLocation { coordinate in
                        self.userLocation = coordinate
                    }
                    }.padding(.bottom, 80)
             }.padding([.top, .leading, .trailing])
             VStack {
                 Spacer()
                 Button(action: {submitForm()}) {
                     Text("Publish!")
                         .padding()
                         .font(.title2)
                         .foregroundColor(.white)
                         .background(Color.blue)
                         .cornerRadius(10)
                 }
             }
        }
         .alert(isPresented: $showAlert) {
                 Alert(title: Text("Error"), message: Text("One or more fields is empty."), dismissButton: .default(Text("Fix")))
         }
    }
    
    func submitForm(){
        if(title.isEmpty || desc.isEmpty){
            showAlert = true
        } else{
            print("Name: \(title) Description: \(desc) Difficulty: \(difficulty) Size: \(size) Location: \(userLocation)")
        }
    }
}


struct AddCache_Previews: PreviewProvider {
    static var previews: some View {
        AddCache()
    }
}
