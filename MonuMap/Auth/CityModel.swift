//
//  CityModel.swift
//  MonuMap
//
//  Created by Hector Daniel Valdes Salas on 15/11/24.
//

import Foundation
import FirebaseFirestore

struct City: Identifiable, Codable {
    var id: String
    var name: String
//    var monuments: [Monument]
}
