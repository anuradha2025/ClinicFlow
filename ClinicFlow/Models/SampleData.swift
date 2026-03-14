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
    ),
    LabTest(
            name: "Urine Full Report (UFR)",
            category: "Urology",
            price: 800,
            duration: "Same Day",
            iconName: "drop.triangle.fill",
            accentHex: "#F5A623",
            description: "A complete urine analysis that examines the appearance, concentration, and content of urine. Used to detect urinary tract infections, kidney disease, and diabetes.",
            beforeTest: [
                "Collect the first urine sample of the morning",
                "Clean the genital area before collecting the sample",
                "Use the sterile container provided by the lab",
                "Do not touch the inside of the container",
                "Deliver the sample to the lab within 2 hours",
                "Avoid heavy exercise the night before",
                "Stay well hydrated — drink plenty of water"
            ]
        ),
        LabTest(
            name: "Urine Culture & Sensitivity",
            category: "Urology",
            price: 1500,
            duration: "2–3 Days",
            iconName: "allergens",
            accentHex: "#F5A623",
            description: "Identifies bacteria or fungi causing a urinary tract infection (UTI) and determines which antibiotics will be most effective for treatment.",
            beforeTest: [
                "Collect midstream urine — discard the first and last stream",
                "Clean the genital area thoroughly before collecting",
                "Use only the sterile container provided",
                "Do NOT take antibiotics for at least 48 hours before the test",
                "Collect the sample in the morning for best results",
                "Deliver to the lab within 1 hour of collection"
            ]
        ),
        LabTest(
            name: "Urine Protein Test",
            category: "Urology",
            price: 600,
            duration: "Same Day",
            iconName: "drop.fill",
            accentHex: "#F5A623",
            description: "Measures the amount of protein in urine. Elevated protein levels can indicate kidney damage, kidney disease, or other conditions affecting kidney function.",
            beforeTest: [
                "Avoid strenuous exercise for 24 hours before the test",
                "Collect a midstream urine sample",
                "Use the sterile container provided by the lab",
                "Inform your doctor about any medications you are taking",
                "Avoid foods high in protein the night before",
                "Stay well hydrated before collection"
            ]
        ),
        LabTest(
            name: "Urine Microalbumin Test",
            category: "Urology",
            price: 1200,
            duration: "Same Day",
            iconName: "waveform.path",
            accentHex: "#F5A623",
            description: "Detects small amounts of albumin (protein) in urine, which is an early indicator of kidney damage — especially important for people with diabetes or high blood pressure.",
            beforeTest: [
                "Collect a first morning urine sample",
                "Avoid heavy exercise for 24 hours beforehand",
                "Do not collect during a urinary tract infection",
                "Inform your doctor about any medications",
                "Use only the sterile container provided"
            ]
        ),
    LabTest(
            name: "Erythrocyte Sedimentation Rate (ESR)",
            category: "Haematology",
            price: 700,
            duration: "Same Day",
            iconName: "timer",
            accentHex: "#E84A4A",
            description: "ESR measures how quickly red blood cells settle at the bottom of a test tube. A high ESR indicates inflammation in the body and is used to monitor conditions such as rheumatoid arthritis, lupus, and infections.",
            beforeTest: [
                "No fasting required for this test",
                "Inform your doctor about any current medications",
                "Avoid vigorous exercise 24 hours before the test",
                "Tell your doctor if you are pregnant or menstruating",
                "Inform your doctor of any recent infections or illness",
                "The test is best done in the morning for accurate results"
            ]
        )
]

let sampleReports: [TestReport] = [
    TestReport(title: "Fasting Blood Sugar", subtitle: "Diabetes Panel", date: "Dec 10, 2023", size: "2.4 MB", isNew: true),
    TestReport(title: "Full Blood Count", subtitle: "Complete Blood Count (CBC)", date: "Dec 10, 2023", size: "1.9 MB", isNew: true),
    TestReport(title: "Lipid Profile", subtitle: "Cholesterol Panel", date: "Nov 28, 2023", size: "2.1 MB", isNew: false),
    TestReport(title: "Thyroid Function", subtitle: "TSH · Free T3 · Free T4", date: "Nov 15, 2023", size: "3.1 MB", isNew: false),
    TestReport(title: "Liver Function", subtitle: "LFT Comprehensive Panel", date: "Oct 30, 2023", size: "2.7 MB", isNew: false),
    TestReport(title: "Urine Full Report", subtitle: "UFR - Complete Urine Analysis", date: "Dec 08, 2023", size: "1.2 MB", isNew: true),
    TestReport(title: "Urine Culture & Sensitivity", subtitle: "UTI Bacteria Panel", date: "Nov 30, 2023", size: "1.5 MB", isNew: false),
    TestReport(title: "Urine Protein Test", subtitle: "Kidney Function - Protein", date: "Nov 28, 2023", size: "0.9 MB", isNew: false),
    TestReport(title: "Urine Microalbumin", subtitle: "Early Kidney Damage Marker", date: "Nov 20, 2023", size: "1.1 MB", isNew: false),
    TestReport(title: "ESR Test Results", subtitle: "Erythrocyte Sedimentation Rate", date: "Dec 05, 2023", size: "0.8 MB", isNew: true),
]
