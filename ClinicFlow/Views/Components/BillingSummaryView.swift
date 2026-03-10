//
//  BillingSummaryView.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-020 on 2026-03-07.
//

import SwiftUI

struct BillingSummaryView: View {
    let billing: BillingInfo

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Billing")
                .font(.headline)
            HStack {
                Text("Doctor Charge")
                    .foregroundColor(.cfTextSecondary)
                Spacer()
                Text("Rs. \(Int(billing.doctorCharge))")
            }
            HStack {
                Text("Hospital Fee")
                    .foregroundColor(.cfTextSecondary)
                Spacer()
                Text("Rs. \(Int(billing.hospitalFee))")
            }
            Divider()
            HStack {
                Text("Total").bold()
                Spacer()
                Text("Rs. \(Int(billing.total))").bold().foregroundColor(.cfPrimary)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 2)
        .font(.subheadline)
    }
}
