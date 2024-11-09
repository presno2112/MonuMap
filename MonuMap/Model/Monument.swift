//
//  Monument.swift
//  MonuMap
//
//  Created by Sebastian Presno on 09/11/24.
//

import FirebaseFirestore
import Foundation

struct Monument: Identifiable, Codable {
    @DocumentID var id: String? // Firestore document ID
    var name: String
    var creator: String? // Optional field
    var date: Date
    var description: String
    var picture: String // URL to monument picture
    var location: String
    var coordinates: GeoPoint // Use Firestore’s GeoPoint type for coordinates

    init(name: String, creator: String?, date: Date, description: String, picture: String, location: String, coordinates: GeoPoint) {
        self.name = name
        self.creator = creator
        self.date = date
        self.description = description
        self.picture = picture
        self.location = location
        self.coordinates = coordinates
    }
}
