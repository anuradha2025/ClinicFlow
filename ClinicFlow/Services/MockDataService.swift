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
    
    private func sampleQueueEntries() -> [QueueEntry] {
        [
            QueueEntry(id: 1, time: "08:30 AM", status: .checkedIn),
            QueueEntry(id: 2, time: "09:15 AM", status: .ongoing),
            QueueEntry(id: 3, time: "10:00 AM", status: .cancelled),
            QueueEntry(id: 4, time: "10:45 AM", status: .cancelled),
            QueueEntry(id: 5, time: "11:30 AM", status: .cancelled),
            QueueEntry(id: 6, time: "12:00 PM", status: .new),
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
            Appointment(id: UUID(), doctor: doctors[0],
                        date: today, time: "12:00 PM",
                        status: .upcoming, queueNumber: 6, estimatedWaitNumber: 65,
                        prescription: [], labTests: [],
                        queueEntries: sampleQueueEntries()),

            Appointment(id: UUID(), doctor: doctors[2],
                        date: tomorrow, time: "10:30 AM",
                        status: .upcoming, queueNumber: 3, estimatedWaitNumber: 25,
                        prescription: [], labTests: [],
                        queueEntries: [
                            QueueEntry(id: 1, time: "09:00 AM", status: .checkedIn),
                            QueueEntry(id: 2, time: "09:45 AM", status: .ongoing),
                            QueueEntry(id: 3, time: "10:30 AM", status: .new),
                        ]),

            Appointment(id: UUID(), doctor: doctors[5],
                        date: nextWeek, time: "02:00 PM",
                        status: .upcoming, queueNumber: 8, estimatedWaitNumber: 45,
                        prescription: [], labTests: [],
                        queueEntries: [
                            QueueEntry(id: 1, time: "01:00 PM", status: .checkedIn),
                            QueueEntry(id: 2, time: "01:30 PM", status: .new),
                        ]),

            Appointment(id: UUID(), doctor: doctors[1],
                        date: yesterday, time: "09:00 AM",
                        status: .completed, queueNumber: 2, estimatedWaitNumber: 0,
                        prescription: [
                            PrescriptionItem(id: UUID(), name: "Paracetamol", dosage: "500mg"),
                            PrescriptionItem(id: UUID(), name: "Vitamin C", dosage: "500mg"),
                            PrescriptionItem(id: UUID(), name: "Salts", dosage: "550mg")
                        ],
                        labTests: [
                            LabTest(id: UUID(), name: "Complete Blood Count (CBC)"),
                            LabTest(id: UUID(), name: "Dengue NS1 Antigen Test")
                        ],
                        queueEntries: []),

            Appointment(id: UUID(), doctor: doctors[3],
                        date: lastWeek, time: "03:30 PM",
                        status: .completed, queueNumber: 5, estimatedWaitNumber: 0,
                        prescription: [
                            PrescriptionItem(id: UUID(), name: "Cetirizine", dosage: "10mg")
                        ],
                        labTests: [],
                        queueEntries: []),

            Appointment(id: UUID(), doctor: doctors[4],
                        date: twoWeeksAgo, time: "11:00 AM",
                        status: .cancelled, queueNumber: 4, estimatedWaitNumber: 0,
                        prescription: [], labTests: [],
                        queueEntries: [])
        ]
    }

    var reports: [Report] {
        [
            Report(id: UUID(), title: "Blood Test Results",
                   type: ReportType.labResult, date: Date(), fileSize: "2.4 MB", fileURL: nil),
            Report(id: UUID(), title: "Prescription",
                   type: ReportType.prescription, date: Date(), fileSize: "1.2 MB", fileURL: nil),
            Report(id: UUID(), title: "Lab Report",
                   type: ReportType.labReport, date: Date(), fileSize: "3.1 MB", fileURL: nil)
        ]
    }
}
