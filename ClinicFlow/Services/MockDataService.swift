//
//  MockDataService.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-020 on 2026-03-07.
//

import Foundation

class MockDataService {
    static let shared = MockDataService()

    var doctors: [Doctor] = [
        Doctor(id: UUID(),
               name: "Dr. Emily Carter",
               specialty: "Cardiologist",
               rating: 4.9, reviewCount: 125,
               chargeAmount: 4500,
               isFavorite: false,
               imageName: "doctor_emily",
               biography: "Dr. Emily Carter is a board-certified cardiologist with over 10 years of experience treating heart conditions. She specializes in preventive cardiology and heart failure management.",
               experience: 10, patientCount: 1200,
               isAvailableToday: true),

        Doctor(id: UUID(),
               name: "Dr. James Wilson",
               specialty: "Paediatrician",
               rating: 4.7, reviewCount: 98,
               chargeAmount: 3500,
               isFavorite: true,
               imageName: "doctor_james",
               biography: "Dr. James Wilson is an experienced paediatrician dedicated to the health and wellbeing of children from newborns to teenagers.",
               experience: 8, patientCount: 900,
               isAvailableToday: false),

        Doctor(id: UUID(),
               name: "Dr. Sarah Mitchell",
               specialty: "Neurologist",
               rating: 4.8, reviewCount: 210,
               chargeAmount: 5500,
               isFavorite: false,
               imageName: "doctor_sarah",
               biography: "Dr. Sarah Mitchell is a leading neurologist specializing in migraines, epilepsy, and neurodegenerative diseases with 15 years of clinical experience.",
               experience: 15, patientCount: 2100,
               isAvailableToday: true),

        Doctor(id: UUID(),
               name: "Dr. Robert Chen",
               specialty: "Dermatologist",
               rating: 4.6, reviewCount: 183,
               chargeAmount: 4000,
               isFavorite: false,
               imageName: "doctor_robert",
               biography: "Dr. Robert Chen specializes in medical and cosmetic dermatology, treating skin conditions ranging from acne to complex dermatological disorders.",
               experience: 12, patientCount: 1800,
               isAvailableToday: true),

        Doctor(id: UUID(),
               name: "Dr. Priya Sharma",
               specialty: "Gynaecologist",
               rating: 4.9, reviewCount: 320,
               chargeAmount: 4800,
               isFavorite: true,
               imageName: "doctor_priya",
               biography: "Dr. Priya Sharma is a highly regarded gynaecologist and obstetrician with expertise in women's health, prenatal care, and minimally invasive surgery.",
               experience: 18, patientCount: 3200,
               isAvailableToday: false),

        Doctor(id: UUID(),
               name: "Dr. Michael Torres",
               specialty: "Orthopaedic",
               rating: 4.5, reviewCount: 145,
               chargeAmount: 5000,
               isFavorite: false,
               imageName: "doctor_michael",
               biography: "Dr. Michael Torres is an orthopaedic surgeon specializing in sports injuries, joint replacement, and spine disorders.",
               experience: 11, patientCount: 1400,
               isAvailableToday: true),

        Doctor(id: UUID(),
               name: "Dr. Aisha Rahman",
               specialty: "Psychiatrist",
               rating: 4.8, reviewCount: 267,
               chargeAmount: 4200,
               isFavorite: false,
               imageName: "doctor_aisha",
               biography: "Dr. Aisha Rahman provides compassionate psychiatric care for anxiety, depression, PTSD, and other mental health conditions.",
               experience: 9, patientCount: 1100,
               isAvailableToday: true),

        Doctor(id: UUID(),
               name: "Dr. David Lee",
               specialty: "Ophthalmologist",
               rating: 4.7, reviewCount: 192,
               chargeAmount: 3800,
               isFavorite: false,
               imageName: "doctor_david",
               biography: "Dr. David Lee is an eye specialist with expertise in cataract surgery, LASIK, and treatment of retinal diseases.",
               experience: 14, patientCount: 2000,
               isAvailableToday: false)
    ]

    // Today's queue entries (for today's appointment)
    private func sampleQueueEntries() -> [QueueEntry] {
        [
            QueueEntry(id: 1, time: "08:30 AM", status: .finished),
            QueueEntry(id: 2, time: "09:15 AM", status: .checkedIn),
            QueueEntry(id: 3, time: "10:00 AM", status: .ongoing),
            QueueEntry(id: 4, time: "10:45 AM", status: .cancelled),
            QueueEntry(id: 5, time: "11:30 AM", status: .notAvailable),
            QueueEntry(id: 6, time: "12:00 PM", status: .you),
        ]
    }

    var appointments: [Appointment] {
        let calendar = Calendar.current
        let today = Date()
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: today)!
        let nextWeek = calendar.date(byAdding: .day, value: 7, to: today)!
        let yesterday = calendar.date(byAdding: .day, value: -1, to: today)!
        let lastWeek = calendar.date(byAdding: .day, value: -7, to: today)!
        let twoWeeksAgo = calendar.date(byAdding: .day, value: -14, to: today)!

        return [

            // ── UPCOMING ──────────────────────────────────────

            // Today
            Appointment(
                id: UUID(),
                doctor: doctors[0],
                date: today,
                time: "12:00 PM",
                status: .upcoming,
                queueNumber: 6,
                estimatedWaitNumber: 65,
                prescription: [],
                labTests: [],
                queueEntries: sampleQueueEntries()
            ),

            // Tomorrow
            Appointment(
                id: UUID(),
                doctor: doctors[2],
                date: tomorrow,
                time: "10:30 AM",
                status: .upcoming,
                queueNumber: 3,
                estimatedWaitNumber: 25,
                prescription: [],
                labTests: [],
                queueEntries: [
                    QueueEntry(id: 1, time: "09:00 AM", status: .finished),
                    QueueEntry(id: 2, time: "09:45 AM", status: .checkedIn),
                    QueueEntry(id: 3, time: "10:30 AM", status: .you),
                ]
            ),

            // Next week
            Appointment(
                id: UUID(),
                doctor: doctors[5],
                date: nextWeek,
                time: "02:00 PM",
                status: .upcoming,
                queueNumber: 8,
                estimatedWaitNumber: 45,
                prescription: [],
                labTests: [],
                queueEntries: [
                    QueueEntry(id: 1, time: "01:00 PM", status: .finished),
                    QueueEntry(id: 2, time: "01:30 PM", status: .you),
                ]
            ),

            // ── PREVIOUS ─────────────────────────────────────

            // Yesterday — completed with prescription & lab tests
            Appointment(
                id: UUID(),
                doctor: doctors[1],
                date: yesterday,
                time: "09:00 AM",
                status: .completed,
                queueNumber: 2,
                estimatedWaitNumber: 0,
                prescription: [
                    PrescriptionItem(id: UUID(), name: "Paracetamol", dosage: "500mg"),
                    PrescriptionItem(id: UUID(), name: "Vitamin C", dosage: "500mg"),
                    PrescriptionItem(id: UUID(), name: "Salts", dosage: "550mg")
                ],
                labTests: [
                    AppointmentLabTest(id: UUID(), name: "Complete Blood Count (CBC)"),
                    AppointmentLabTest(id: UUID(), name: "Dengue NS1 Antigen Test")
                ],
                queueEntries: []
            ),

            // Last week — completed with prescription only
            Appointment(
                id: UUID(),
                doctor: doctors[3],
                date: lastWeek,
                time: "03:30 PM",
                status: .completed,
                queueNumber: 5,
                estimatedWaitNumber: 0,
                prescription: [
                    PrescriptionItem(id: UUID(), name: "Cetirizine", dosage: "10mg")
                ],
                labTests: [],
                queueEntries: []
            ),

            // Two weeks ago — cancelled
            Appointment(
                id: UUID(),
                doctor: doctors[4],
                date: twoWeeksAgo,
                time: "11:00 AM",
                status: .cancelled,
                queueNumber: 4,
                estimatedWaitNumber: 0,
                prescription: [],
                labTests: [],
                queueEntries: []
            )
        ]
    }

    var reports: [Report] {
        let calendar = Calendar.current
        let today = Date()
        let twoDaysAgo   = calendar.date(byAdding: .day, value: -2,  to: today)!
        let lastWeek     = calendar.date(byAdding: .day, value: -7,  to: today)!
        let twoWeeksAgo  = calendar.date(byAdding: .day, value: -14, to: today)!
        let lastMonth    = calendar.date(byAdding: .day, value: -30, to: today)!
        let twoMonths    = calendar.date(byAdding: .day, value: -60, to: today)!

        return [
            Report(id: UUID(),
                   title: "Complete Blood Count (CBC)",
                   type: .labResult,
                   date: twoDaysAgo,
                   fileSize: "1.2 MB",
                   doctorName: "Dr. James Wilson"),

            Report(id: UUID(),
                   title: "Dengue NS1 Antigen Test",
                   type: .labResult,
                   date: twoDaysAgo,
                   fileSize: "0.8 MB",
                   doctorName: "Dr. James Wilson"),

            Report(id: UUID(),
                   title: "Paracetamol & Vitamin C",
                   type: .prescription,
                   date: twoDaysAgo,
                   fileSize: "0.5 MB",
                   doctorName: "Dr. James Wilson"),

            Report(id: UUID(),
                   title: "Observation Report",
                   type: .observation,
                   date: twoDaysAgo,
                   fileSize: "1.4 MB",
                   doctorName: "Dr. James Wilson"),

            Report(id: UUID(),
                   title: "Cetirizine Prescription",
                   type: .prescription,
                   date: lastWeek,
                   fileSize: "0.4 MB",
                   doctorName: "Dr. Robert Chen"),

            Report(id: UUID(),
                   title: "Skin Allergy Observation",
                   type: .observation,
                   date: lastWeek,
                   fileSize: "2.1 MB",
                   doctorName: "Dr. Robert Chen"),

            Report(id: UUID(),
                   title: "Chest X-Ray",
                   type: .imaging,
                   date: twoWeeksAgo,
                   fileSize: "4.8 MB",
                   doctorName: "Dr. Emily Carter"),

            Report(id: UUID(),
                   title: "ECG Report",
                   type: .imaging,
                   date: twoWeeksAgo,
                   fileSize: "3.2 MB",
                   doctorName: "Dr. Emily Carter"),

            Report(id: UUID(),
                   title: "Cardiology Observation",
                   type: .observation,
                   date: twoWeeksAgo,
                   fileSize: "1.8 MB",
                   doctorName: "Dr. Emily Carter"),

            Report(id: UUID(),
                   title: "Thyroid Function Test",
                   type: .labResult,
                   date: lastMonth,
                   fileSize: "1.1 MB",
                   doctorName: "Dr. Sarah Mitchell"),

            Report(id: UUID(),
                   title: "Neurology Discharge Summary",
                   type: .discharge,
                   date: lastMonth,
                   fileSize: "2.4 MB",
                   doctorName: "Dr. Sarah Mitchell"),

            Report(id: UUID(),
                   title: "MRI Brain Scan",
                   type: .imaging,
                   date: twoMonths,
                   fileSize: "8.6 MB",
                   doctorName: "Dr. Sarah Mitchell"),

            Report(id: UUID(),
                   title: "Annual Checkup Summary",
                   type: .discharge,
                   date: twoMonths,
                   fileSize: "1.9 MB",
                   doctorName: "Dr. Emily Carter")
        ]
    }
}
