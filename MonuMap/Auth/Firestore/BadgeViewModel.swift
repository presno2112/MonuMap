//
//  BadgeViewModel.swift
//  MonuMap
//
//  Created by Hector Daniel Valdes Salas on 18/11/24.
//

import Foundation

final class BadgeViewModel: ObservableObject {
    @Published var badges: [Badge] = []

    func loadBadges(for badgeNames: [String]) async {
        var loadedBadges: [Badge] = []

        for name in badgeNames {
            do {
                if let badge = try await BadgeManager.shared.getBadge(named: name) {
                    loadedBadges.append(badge)
                } else {
                    print("Badge not found for name: \(name)")
                }
            } catch {
                print("Error loading badge \(name): \(error)")
            }
        }
        
        // Actualizar el estado de la vista una vez que se hayan cargado todos los badges
        await MainActor.run {
            self.badges = loadedBadges
        }
    }
}
