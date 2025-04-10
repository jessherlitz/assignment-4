//
//  JournalViewModel.swift
//  Project4
//
//  Created by Jessica Sampaio-Herlitz on 4/7/25.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class JournalViewModel: ObservableObject {
    @Published var entries = [JournalEntry]()
    private var db = Firestore.firestore()
    private var listener: ListenerRegistration?
    private var authListenerHandle: AuthStateDidChangeListenerHandle?

    init() {
        authListenerHandle = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            guard let self = self else { return }
            if user == nil {
                self.entries.removeAll()
                self.listener?.remove()
                self.listener = nil
            } else {
                self.fetchEntries()
            }
        }
    }

    deinit {
        if let handle = authListenerHandle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
        listener?.remove()
    }

    func fetchEntries() {
        listener?.remove()
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        listener = db.collection("users").document(userID).collection("journalEntries")
            .order(by: "date", descending: true)
            .addSnapshotListener { [weak self] (querySnapshot, error) in
                guard let self = self else { return }
                if let error = error {
                    print("Error fetching entries: \(error)")
                    return
                }
                self.entries = querySnapshot?.documents.compactMap { document in
                    try? document.data(as: JournalEntry.self)
                } ?? []
            }
    }
    
    func addEntry(entry: JournalEntry) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        do {
            _ = try db.collection("users").document(userID).collection("journalEntries").addDocument(from: entry)
        } catch {
            print("Error adding entry: \(error)")
        }
    }
    
    func deleteEntry(entry: JournalEntry) {
        guard let userID = Auth.auth().currentUser?.uid,
              let entryID = entry.id else { return }
        db.collection("users").document(userID).collection("journalEntries").document(entryID).delete { error in
            if let error = error {
                print("Error deleting entry: \(error)")
            }
        }
    }
}
