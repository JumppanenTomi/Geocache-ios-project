//
//  ChatBuble.swift
//  GeoCacheApp
//
//  Created by iosadmin on 4/27/23.
//

import SwiftUI

enum ChatBubbleSide {
    case left, right
}

struct ChatBubbleListItem: View {
    let side: ChatBubbleSide
    let text: String
    let time: String
    let deleteAction: () -> Void
    
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
            Group {
                if side == .left {
                    HStack(alignment: .bottom) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(text)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(Color(.systemGray6))
                                .cornerRadius(16)
                                .contextMenu {
                                    Button(action: deleteAction) {
                                        Text("Delete")
                                        Image(systemName: "trash")
                                    }
                                }
                            
                            Text(formatTimestamp(time))
                                .font(.caption)
                                .foregroundColor(.gray)
                                .padding(.leading, 12)
                        }
                        Spacer()
                    }
                    .padding(.leading, 16)
                    .padding(.vertical, 8)
                    .onLongPressGesture(minimumDuration: 0.5) { // add long press gesture
                        deleteAction()
                    }
                } else {
                    HStack(alignment: .bottom) {
                        Spacer()
                        VStack(alignment: .trailing, spacing: 4) {
                            Text(text)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(16)
                                .contextMenu {
                                    Button(action: deleteAction) {
                                        Text("Delete")
                                        Image(systemName: "trash")
                                    }
                                }
                            
                            Text(formatTimestamp(time))
                                .font(.caption)
                                .foregroundColor(.gray)
                                .padding(.trailing, 12)
                        }
                    }
                    .padding(.trailing, 16)
                    .padding(.vertical, 8)
                    .onLongPressGesture(minimumDuration: 0.5) { // add long press gesture
                        deleteAction()
                    }
                }
            }
        }
    }
