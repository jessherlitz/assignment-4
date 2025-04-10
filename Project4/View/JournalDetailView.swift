//
//  JournalDetailView.swift
//  Project4
//
//  Created by Jessica Sampaio-Herlitz on 4/7/25.
//

import SwiftUI

struct JournalDetailView: View {
    var entry: JournalEntry
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 14) {
                Text(entry.title)
                    .font(.largeTitle)
                    .bold()
                Text(entry.date, style: .date)
                    .font(.subheadline)
                Divider()
                Text(entry.content)
                    .font(.body)
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Entry Details")
    }
}
