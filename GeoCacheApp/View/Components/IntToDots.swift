//
//  IntToDots.swift
//  GeoCacheApp
//
//  Created by iosdev on 6.4.2023.
//
//  This class receives int value and int scale after that it returns "progressbar" based on given values

import SwiftUI

struct IntToDots: View {
    var value: Int = 0
    var scale: Int = 5
    var fontSize: CGFloat = CGFloat(16)
    var iconSpacing: CGFloat = CGFloat(2)
    
    var body: some View {
        HStack(spacing: iconSpacing-10){
            ForEach(0..<scale){index in
                if index < value {
                    Label("", systemImage:"circle.fill")
                } else {
                    Label("", systemImage:"circle")
                }
            }
        }
        .font(.system(size: fontSize))
        .padding(.all, 0)
    }
}

struct IntToDots_Previews: PreviewProvider {
    static var previews: some View {
        IntToDots(value: 2, scale: 5, fontSize: CGFloat(5), iconSpacing: 2)
    }
}
