//
//  SampleData.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-028 on 2026-03-10.
//

import Foundation

let sampleTests: [LabTest] = [
    LabTest(
        name: "Fasting Blood Sugar Test",
        category: "Diabetes",
        price: 2500,
        duration: "Same Day",
        iconName: "drop.fill",
        accentHex: "#2D72F5",
        description: "Measures your blood glucose level after an overnight fast. Widely used to diagnose Type 1 & Type 2 diabetes and to monitor ongoing blood sugar control.",
        beforeTest: [
            "Fast for 8–12 hours before the test",
            "Do NOT eat any food during the fasting period",
            "Do NOT drink milk, tea, coffee, or juice",
            "Plain water is allowed — stay hydrated",
            "Avoid heavy exercise the morning of the test",
            "Avoid alcohol for at least 24 hours beforehand",
            "If you take regular medication, ask your doctor whether to take it before the test"
        ]
    ),
    LabTest(
        name: "Full Blood Count Test",
        category: "Haematology",
        price: 1800,
        duration: "Same Day",
        iconName: "cross.vial.fill",
        accentHex: "#E84A4A",
        description: "A comprehensive blood panel that evaluates all major blood cell types. Used to detect anaemia, infection, clotting disorders, and many other conditions.",
        beforeTest: [
            "No special fasting required",
            "Stay well hydrated before the test",
            "Wear a short-sleeved or loose-sleeved shirt",
            "Inform your doctor of any current medications"
        ]
    ),
    LabTest(
        name: "Lipid Profile",
        category: "Cardiology",
        price: 3200,
        duration: "Same Day",
        iconName: "heart.fill",
        accentHex: "#FF6B6B",
        description: "Measures total cholesterol, LDL, HDL, and triglycerides to assess cardiovascular risk. Essential for monitoring heart health and guiding treatment.",
        beforeTest: [
            "Fast for 9–12 hours before the test",
            "Drink only plain water during the fasting period",
            "Avoid fatty or fried foods the day before",
            "Avoid alcohol for 24 hours beforehand",
            "Inform your doctor about cholesterol medications"
        ]
    ),
    LabTest(
        name: "Thyroid Function Test",
        category: "Endocrinology",
        price: 4500,
        duration: "1–2 Days",
        iconName: "waveform.path.ecg",
        accentHex: "#8C5CF6",
        description: "Measures TSH, Free T3, and Free T4 levels to assess how well your thyroid gland is working. Used to diagnose hypothyroidism, hyperthyroidism, and thyroid disorders.",
        beforeTest: [
            "Fast for at least 8 hours",
            "Best done early in the morning",
            "Inform your doctor about thyroid medications",
            "Avoid biotin supplements for 24 hours"
        ]
    ),
    LabTest(
        name: "Liver Function Test",
        category: "Gastroenterology",
        price: 3800,
        duration: "Same Day",
        iconName: "staroflife.fill",
        accentHex: "#F5A623",
        description: "A panel of blood tests used to evaluate liver health by measuring enzymes, proteins, and bilirubin. Detects liver inflammation, damage, or disease.",
        beforeTest: [
            "Fast for 8–10 hours before the test",
            "Avoid alcohol completely for 24 hours",
            "Inform your doctor of all medications and supplements",
            "Avoid strenuous exercise the day before"
        ]
    ),
    LabTest(
        name: "HbA1c (Glycated Haemoglobin)",
        category: "Diabetes",
        price: 2800,
        duration: "Same Day",
        iconName: "chart.line.uptrend.xyaxis",
        accentHex: "#2D72F5",
        description: "Reflects your average blood sugar level over the past 2–3 months. The gold-standard test for long-term diabetes management and diagnosis.",
        beforeTest: [
            "No fasting required",
            "Can be done at any time of day",
            "Inform your doctor of recent illness or blood transfusions"
        ]
    )
]

let sampleReports: [TestReport] = [
    TestReport(title: "Fasting Blood Sugar", subtitle: "Diabetes Panel", date: "Dec 10, 2023", size: "2.4 MB", isNew: true),
    TestReport(title: "Full Blood Count", subtitle: "Complete Blood Count (CBC)", date: "Dec 10, 2023", size: "1.9 MB", isNew: true),
    TestReport(title: "Lipid Profile", subtitle: "Cholesterol Panel", date: "Nov 28, 2023", size: "2.1 MB", isNew: false),
    TestReport(title: "Thyroid Function", subtitle: "TSH · Free T3 · Free T4", date: "Nov 15, 2023", size: "3.1 MB", isNew: false),
    TestReport(title: "Liver Function", subtitle: "LFT Comprehensive Panel", date: "Oct 30, 2023", size: "2.7 MB", isNew: false)
]
