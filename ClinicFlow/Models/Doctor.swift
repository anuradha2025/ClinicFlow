//
//  Doctor.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-020 on 2026-03-07.
//

import Foundation

struct Doctor: Identifiable, Codable, Hashable {
    let id: UUID
    var name: String
    var specialty: String
    var rating: Double
    var reviewCount: Int
    var chargeAmount: Double
    var isFavorite: Bool
    var imageName: String       // asset name or URL string
    var biography: String
    var experience: Int         // years
    var patientCount: Int
    var isAvailableToday: Bool
}
