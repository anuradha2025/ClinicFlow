//
//  AppState.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-020 on 2026-03-09.
//

import Foundation
import Combine

class AppState: ObservableObject {
    @Published var selectedTab: Int = 0
    @Published var popToRoot: Bool = false
}
