//
//  Journal.swift
//  Project4
//
//  Created by Jessica Sampaio-Herlitz on 4/7/25.
//

import SwiftUI

struct NewEntryView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: JournalViewModel
    @State private var title: String = ""
    @State private var content: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Title")) {
                    TextField("Enter title", text: $title)
                }
                Section(header: Text("Content")) {
                    TextEditor(text: $content)
                        .frame(height: 200)
                }
            }
            .navigationTitle("New Journal Entry")
            .navigationBarItems(
                leading: Button("Cancel") { presentationMode.wrappedValue.dismiss() },
                trailing: Button("Save") {
                    let entry = JournalEntry(title: title, content: content, date: Date())
                    viewModel.addEntry(entry: entry)
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }
}
