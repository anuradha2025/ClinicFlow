//
//  AppointmentLabTest.swift
//  ClinicFlow
//
//  Lightweight lab test model used inside Appointment history.
//

import Foundation

struct AppointmentLabTest: Identifiable, Codable, Hashable {
    let id:   UUID
    let name: String
}

extension AppointmentLabTest {
    func asBookableLabTest() -> LabTest {
        if let matchedTest = sampleTests.first(where: matchesCatalogTest) {
            return matchedTest
        }

        return LabTest(
            name: name,
            category: inferredCategory,
            price: inferredPrice,
            duration: inferredDuration,
            iconName: inferredIconName,
            accentHex: "#2D72F5",
            description: "This laboratory investigation was recommended during your appointment. Book a convenient slot to complete the test and receive your report once processing is complete.",
            beforeTest: preparationNotes
        )
    }

    private func matchesCatalogTest(_ test: LabTest) -> Bool {
        let appointmentName = normalized(name)
        let catalogName = normalized(test.name)
        let aliases = catalogAliases(for: catalogName)

        return appointmentName == catalogName ||
            appointmentName.contains(catalogName) ||
            catalogName.contains(appointmentName) ||
            aliases.contains(appointmentName)
    }

    private func catalogAliases(for catalogName: String) -> Set<String> {
        switch catalogName {
        case normalized("Full Blood Count Test"):
            return [
                normalized("Complete Blood Count"),
                normalized("Complete Blood Count CBC"),
                normalized("CBC")
            ]
        case normalized("Fasting Blood Sugar Test"):
            return [normalized("FBS"), normalized("Blood Sugar Test")]
        case normalized("HbA1c (Glycated Haemoglobin)"):
            return [normalized("HbA1c"), normalized("Glycated Haemoglobin")]
        default:
            return []
        }
    }

    private var inferredCategory: String {
        let lowered = name.lowercased()

        if lowered.contains("blood") || lowered.contains("cbc") || lowered.contains("platelet") {
            return "Haematology"
        }
        if lowered.contains("sugar") || lowered.contains("glucose") || lowered.contains("hba1c") {
            return "Diabetes"
        }
        if lowered.contains("lipid") || lowered.contains("cholesterol") || lowered.contains("cardiac") {
            return "Cardiology"
        }
        if lowered.contains("thyroid") || lowered.contains("hormone") {
            return "Endocrinology"
        }
        if lowered.contains("liver") || lowered.contains("bilirubin") {
            return "Gastroenterology"
        }

        return "General"
    }

    private var inferredPrice: Int {
        let lowered = name.lowercased()

        if lowered.contains("dengue") {
            return 4200
        }
        if lowered.contains("cbc") || lowered.contains("blood count") {
            return 1800
        }

        return 3000
    }

    private var inferredDuration: String {
        name.lowercased().contains("dengue") ? "1 Day" : "Same Day"
    }

    private var inferredIconName: String {
        let lowered = name.lowercased()

        if lowered.contains("dengue") {
            return "cross.case.fill"
        }
        if lowered.contains("blood") || lowered.contains("cbc") {
            return "cross.vial.fill"
        }

        return "testtube.2"
    }

    private var preparationNotes: [String] {
        let lowered = name.lowercased()

        if lowered.contains("dengue") {
            return [
                "Bring your doctor referral or appointment note to the laboratory.",
                "Stay hydrated before sample collection.",
                "Inform the staff about fever, medication, or recent travel history."
            ]
        }

        return [
            "Bring your doctor referral or appointment note to the laboratory.",
            "Drink water before arrival unless your doctor advised otherwise.",
            "Inform the staff about any regular medication before the sample is taken."
        ]
    }

    private func normalized(_ value: String) -> String {
        value
            .lowercased()
            .replacingOccurrences(of: "(", with: " ")
            .replacingOccurrences(of: ")", with: " ")
            .replacingOccurrences(of: "-", with: " ")
            .components(separatedBy: CharacterSet.alphanumerics.inverted)
            .filter { !$0.isEmpty }
            .joined(separator: " ")
    }
}

