//
//  JournalEntry.swift
//  Project4
//
//  Created by Jessica Sampaio-Herlitz on 4/7/25.


import Foundation
import FirebaseFirestore

struct JournalEntry: Identifiable, Codable {
    @DocumentID var id: String?
    var title: String
    var content: String
    var date: Date = Date()
}
