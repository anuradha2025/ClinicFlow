//
//  TestReport.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-028 on 2026-03-10.
//

import Foundation

struct TestReport: Identifiable {
    let id       = UUID()
    let title:    String
    let subtitle: String
    let date:     String
    let size:     String
    let isNew:    Bool
}
