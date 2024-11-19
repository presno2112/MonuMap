//
//  BadgeModel.swift
//  MonuMap
//
//  Created by Hector Daniel Valdes Salas on 18/11/24.
//

import Foundation

struct Badge: Identifiable, Codable {
    var id: String? = UUID().uuidString
    var name: String
    var description: String
    var image: String
}
