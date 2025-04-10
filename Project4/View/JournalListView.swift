//
//  JournalListView.swift
//  Project4
//
//  Created by Jessica Sampaio-Herlitz on 4/7/25.
//

import SwiftUI
import FirebaseAuth

struct JournalListView: View {
    @ObservedObject var viewModel = JournalViewModel()
    @State private var showNewEntry = false
    @State private var navigateToMain = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.entries) { entry in
                    NavigationLink(destination: JournalDetailView(entry: entry)) {
                        VStack(alignment: .leading) {
                            Text(entry.title)
                                .font(.headline)
                            Text(entry.date, style: .date)
                                .font(.subheadline)
                        }
                    }
                }
                .onDelete(perform: deleteEntry)
            }
            .navigationTitle("My Journal")
            .navigationBarItems(
                leading: Button("Log Out") { logOut() },
                trailing: Button(action: { showNewEntry.toggle() }) {
                    Image(systemName: "plus")
                }
            )
            .sheet(isPresented: $showNewEntry) {
                NewEntryView(viewModel: viewModel)
            }
            .navigationDestination(isPresented: $navigateToMain) {
                ContentView()
            }
            
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private func logOut() {
        do {
            try Auth.auth().signOut()
            navigateToMain = true
        } catch {
            print("Error signing out: \(error)")
        }
    }
    
    private func deleteEntry(at offsets: IndexSet) {
        offsets.forEach { index in
            let entry = viewModel.entries[index]
            viewModel.deleteEntry(entry: entry)
        }
    }
}
