import SwiftUI

struct AddCardView: View {
    @ObservedObject var pharmVM: PharmacyViewModel
    @Environment(\.dismiss) var dismiss

    @State private var cardNumber = ""
    @State private var expiry = ""
    @State private var cvv = ""
    @State private var holderName = ""

    var formattedNumber: String {
        let digits = cardNumber.filter { $0.isNumber }.prefix(16)
        return stride(from: 0, to: digits.count, by: 4).map {
            let start = digits.index(digits.startIndex, offsetBy: $0)
            let end = digits.index(start, offsetBy: min(4, digits.count - $0))
            return String(digits[start..<end])
        }.joined(separator: " ")
    }

    var maskedDisplay: String {
        let digits = cardNumber.filter { $0.isNumber }
        if digits.count >= 4 {
            let last4 = String(digits.suffix(4))
            return "**** **** **** \(last4)"
        }
        return "**** **** **** ****"
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGray6).ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 20) {

      
                        ZStack {
                            LinearGradient(colors: [Color(red: 0.1, green: 0.3, blue: 0.8), Color(red: 0.2, green: 0.5, blue: 0.9)],
                                           startPoint: .topLeading, endPoint: .bottomTrailing)
                                .cornerRadius(20)

                            VStack(alignment: .leading, spacing: 20) {
                                HStack {
                                    Image(systemName: "creditcard.fill").foregroundColor(.white.opacity(0.8)).font(.system(size: 24))
                                    Spacer()
                                    Text("VISA").font(.system(size: 22, weight: .bold)).italic().foregroundColor(.white)
                                }
                                Spacer()
                                Text(maskedDisplay)
                                    .font(.system(size: 18, weight: .medium, design: .monospaced))
                                    .foregroundColor(.white)
                                HStack {
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text("EXPIRES").font(.system(size: 9)).foregroundColor(.white.opacity(0.7))
                                        Text(expiry.isEmpty ? "MM/YY" : expiry).font(.system(size: 14, weight: .semibold)).foregroundColor(.white)
                                    }
                                    Spacer()
                                    Text(holderName.isEmpty ? "CARD HOLDER" : holderName.uppercased())
                                        .font(.system(size: 13, weight: .semibold)).foregroundColor(.white)
                                }
                            }
                            .padding(24)
                        }
                        .frame(height: 180)
                        .shadow(color: .black.opacity(0.2), radius: 16, x: 0, y: 8)
                        .padding(.horizontal, 20)


                        VStack(spacing: 14) {
                            CardInputField(label: "Card Holder Name", placeholder: "JAMES ROBINSON", text: $holderName)
                            CardInputField(label: "Enter card number", placeholder: "3564 7567 3456 5678", text: Binding(
                                get: { formattedNumber },
                                set: { cardNumber = $0.filter { $0.isNumber } }
                            ), keyboardType: .numberPad)
                            HStack(spacing: 12) {
                                CardInputField(label: "Expires (MM/YY)", placeholder: "12/28", text: $expiry, keyboardType: .numberPad)
                                CardInputField(label: "CVV", placeholder: "•••", text: $cvv, keyboardType: .numberPad, isSecure: true,
                                               footnote: "Digits on the back of your card")
                            }
                        }
                        .padding(.horizontal, 20)

             
                        Button(action: {
                            let digits = cardNumber.filter { $0.isNumber }
                            let last4 = String(digits.suffix(4))
                            let card = SavedCard(last4: last4.isEmpty ? "0000" : last4,
                                                 brand: "Visa",
                                                 holderName: holderName.isEmpty ? "CARD HOLDER" : holderName,
                                                 expiry: expiry.isEmpty ? "MM/YY" : expiry)
                            pharmVM.addCard(card)
                            dismiss()
                        }) {
                            Text("Add Card")
                                .font(.system(size: 16, weight: .semibold, design: .rounded))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity).frame(height: 52)
                                .background(RoundedRectangle(cornerRadius: 14).fill(Color.blue))
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 32)
                    }
                    .padding(.top, 24)
                }
            }
            .navigationTitle("Payment")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left").foregroundColor(.black)
                    }
                }
            }
        }
    }
}

struct CardInputField: View {
    let label: String
    let placeholder: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default
    var isSecure: Bool = false
    var footnote: String = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(label).font(.system(size: 12, weight: .semibold, design: .rounded)).foregroundColor(.gray)
            Group {
                if isSecure {
                    SecureField("", text: $text, prompt: Text(placeholder).foregroundColor(.gray.opacity(0.5)))
                } else {
                    TextField("", text: $text, prompt: Text(placeholder).foregroundColor(.gray.opacity(0.5)))
                }
            }
            .font(.system(size: 15, design: .rounded))
            .keyboardType(keyboardType)
            .padding(12)
            .background(RoundedRectangle(cornerRadius: 10).fill(Color.white)
                .shadow(color: .black.opacity(0.05), radius: 4))
            if !footnote.isEmpty {
                Text(footnote).font(.system(size: 10, design: .rounded)).foregroundColor(.gray)
            }
        }
    }
}

#Preview {
    AddCardView(pharmVM: PharmacyViewModel())
        .environmentObject(AuthViewModel())
}
