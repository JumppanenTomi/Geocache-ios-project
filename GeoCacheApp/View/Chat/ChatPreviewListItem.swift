//
//  ChatPreview.swift
//  GeoCacheApp
//
//  Created by iosadmin on 4/26/23.
//

import SwiftUI

struct ChatPreviewListItem: View {
    let contact: String
    let message: String
    let timestamp: String
    
    func formatTimestamp(_ timestamp: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        guard let date = formatter.date(from: timestamp) else {
            return timestamp
        }
        
        let now = Date()
        if Calendar.current.isDateInToday(date) {
            formatter.dateFormat = "h:mm a"
            return formatter.string(from: date)
        } else if Calendar.current.isDate(date, equalTo: now, toGranularity: .year) {
            formatter.dateFormat = "MMM d 'at' h:mm a"
            return formatter.string(from: date)
        } else {
            formatter.dateFormat = "MMM d, yyyy 'at' h:mm a"
            return formatter.string(from: date)
        }
    }
    
    var body: some View {
        HStack {
            Image(systemName: "person.circle.fill")
                .font(.title)
                .foregroundColor(.gray)
                .padding(.trailing, 10)
            
            VStack(alignment: .leading) {
                Text(contact)
                    .font(.headline)
                
                Text(message)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(1)
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text(formatTimestamp(timestamp))
                    .font(.footnote)
                    .foregroundColor(.gray)
                
                Image(systemName: "circle.fill")
                    .font(.caption)
                    .foregroundColor(.green)
            }
        }
        .padding(.vertical, 8)
    }
}
