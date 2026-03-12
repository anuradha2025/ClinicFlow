//
//  LabTest.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-028 on 2026-03-10.
//

import Foundation

struct LabTest: Identifiable, Hashable, Equatable {
    let id:          UUID = UUID()
    let name:        String
    let category:    String
    let price:       Int
    let duration:    String
    let iconName:    String
    let accentHex:   String
    let description: String
    let beforeTest:  [String]

    static func == (lhs: LabTest, rhs: LabTest) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

