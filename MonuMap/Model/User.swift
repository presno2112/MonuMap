//
//  User.swift
//  MonuMap
//
//  Created by Sebastian Presno on 09/11/24.
//
import FirebaseFirestore
import Foundation

struct User: Identifiable, Codable {
    @DocumentID var id: String? // Firestore document ID
    var username: String
    var email: String
    var name: String
    var surname: String
    var profilePic: String? // URL to profile picture
    var badges: [String] = [] // Array of Badge document IDs
    var itinerary: [String] = [] // Array of Monument document IDs

    init(username: String, email: String, name: String, surname: String, profilePic: String? = nil) {
        self.username = username
        self.email = email
        self.name = name
        self.surname = surname
        self.profilePic = profilePic
    }
}
