import SwiftUI

struct OTPView: View {
    let phoneNumber: String
    @EnvironmentObject var authVM: AuthViewModel
    
    @State private var otpDigits: [String] = Array(repeating: "", count: 6)
    @FocusState private var focusedIndex: Int?
    @State private var timeRemaining: Int = 60
    @State private var canResend: Bool = false
    @State private var shakeOffset: CGFloat = 0
    @State private var timer: Timer?
    @State private var navigateToLogin: Bool = false
    
    var otpCode: String { otpDigits.joined() }
    var isComplete: Bool { otpDigits.allSatisfy { $0.count == 1 } }
    
    var body: some View {
        ZStack {
            AppBackground()
            
            VStack(spacing: 0) {
                Spacer()
                
             
                IconCircle(systemName: "message.badge.filled.fill", iconSize: 34)
                Spacer().frame(height: 32)
                
                Text("Verify Your Number")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                Spacer().frame(height: 10)
                
                VStack(spacing: 4) {
                    Text("We sent a 6-digit code to")
                        .font(.system(size: 15, design: .rounded))
                        .foregroundColor(.white.opacity(0.6))
                    Text(phoneNumber)
                        .font(.system(size: 15, weight: .semibold, design: .rounded))
                        .foregroundColor(Theme.accent)
                }
                .multilineTextAlignment(.center)
                
               
                
                Spacer().frame(height: 40)
                

                HStack(spacing: 12) {
                    ForEach(0..<6, id: \.self) { i in
                        OTPBox(
                            digit: otpDigits[i],
                            isFocused: focusedIndex == i,
                            isVerified: authVM.otpVerified
                        )
                        .onTapGesture { focusedIndex = i }
                        .overlay(
                            TextField("", text: $otpDigits[i])
                                .keyboardType(.numberPad)
                                .focused($focusedIndex, equals: i)
                                .opacity(0.01)
                                .onChange(of: otpDigits[i]) { _, v in
                                    handleInput(v, at: i)
                                }
                        )
                    }
                }
                .offset(x: shakeOffset)
                .padding(.horizontal, 24)
                
                Spacer().frame(height: 16)
                
                
                
                Spacer().frame(height: 20)
                

                if authVM.showError {
                    HStack(spacing: 6) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(.system(size: 12))
                        Text(authVM.errorMessage)
                            .font(.system(size: 13, design: .rounded))
                    }
                    .foregroundColor(.red.opacity(0.9))
                    Spacer().frame(height: 8)
                }
                

                if !canResend {
                    HStack(spacing: 6) {
                        Image(systemName: "clock")
                            .font(.system(size: 13))
                            .foregroundColor(.white.opacity(0.5))
                        Text("Resend code in \(timeRemaining)s")
                            .font(.system(size: 14, design: .rounded))
                            .foregroundColor(.white.opacity(0.5))
                    }
                } else {
                    Button(action: resendCode) {
                        HStack(spacing: 6) {
                            Image(systemName: "arrow.clockwise")
                                .font(.system(size: 13))
                            Text("Resend Code")
                                .font(.system(size: 14, weight: .semibold, design: .rounded))
                        }
                        .foregroundColor(Theme.accent)
                    }
                }
                
                Spacer().frame(height: 40)
                
   
                PrimaryButton(
                    label: authVM.otpVerified ? "Verified ✓" : "Verify Code",
                    icon: authVM.otpVerified ? "checkmark.circle.fill" : "shield.checkered",
                    isEnabled: isComplete,
                    isLoading: authVM.isLoading
                ) {
                    authVM.verifyOTP(phone: phoneNumber, code: otpCode)
                }
                
                Spacer()
            }
        }
        .navigationDestination(isPresented: $navigateToLogin) {
            LoginView()
        }
        .onChange(of: authVM.otpVerified) { _, verified in
            if verified {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                    navigateToLogin = true
                }
            }
        }
        .onChange(of: authVM.showError) { _, _ in
            if authVM.showError { shake() }
        }
        .onAppear {
            focusedIndex = 0
            startTimer()
        }
        .onDisappear { timer?.invalidate() }
        .navigationBarTitleDisplayMode(.inline)
    }
    

    
    func autoFill() {
        let code = "123456"
        for i in 0..<6 {
            otpDigits[i] = String(code[code.index(code.startIndex, offsetBy: i)])
        }
        focusedIndex = nil
    }
    
    func handleInput(_ value: String, at index: Int) {
        let filtered = value.filter { $0.isNumber }
        
        if filtered.count > 1 {
            let digits = Array(filtered.prefix(6))
            for i in 0..<6 {
                otpDigits[i] = i < digits.count ? String(digits[i]) : ""
            }
            focusedIndex = min(5, digits.count - 1)
            return
        }
        
        otpDigits[index] = String(filtered.prefix(1))
        
        if filtered.count == 1 && index < 5 {
            focusedIndex = index + 1
        } else if filtered.isEmpty && index > 0 {
            focusedIndex = index - 1
        }
    }
    
    func shake() {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.3)) { shakeOffset = -10 }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.3)) { shakeOffset = 10 }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.5)) { shakeOffset = 0 }
            }
        }
    }
    
    func startTimer() {
        timeRemaining = 60
        canResend = false
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if timeRemaining > 0 { timeRemaining -= 1 }
            else { canResend = true; timer?.invalidate() }
        }
    }
    
    func resendCode() {
        otpDigits = Array(repeating: "", count: 6)
        focusedIndex = 0
        authVM.otpVerified = false
        authVM.showError = false
        startTimer()
    }
}


struct OTPBox: View {
    let digit: String
    let isFocused: Bool
    let isVerified: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 14)
                .fill(Color.white.opacity(digit.isEmpty ? 0.08 : 0.18))
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(
                            isVerified ? Color.green.opacity(0.8) :
                            isFocused  ? Color.white.opacity(0.8) :
                            digit.isEmpty ? Color.white.opacity(0.15) : Color.white.opacity(0.4),
                            lineWidth: isFocused ? 2 : 1.5
                        )
                )
                .frame(width: 48, height: 58)
                .shadow(color: isFocused ? Color.white.opacity(0.1) : .clear, radius: 8)
            
            if isVerified && !digit.isEmpty {
                Image(systemName: "checkmark")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.green)
            } else {
                Text(digit)
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
            }
            
        
            if isFocused && digit.isEmpty {
                Rectangle()
                    .fill(Color.white.opacity(0.8))
                    .frame(width: 2, height: 24)
                    .cornerRadius(1)
            }
        }
        .animation(.easeInOut(duration: 0.15), value: isFocused)
        .animation(.easeInOut(duration: 0.15), value: digit)
        .animation(.easeInOut(duration: 0.2), value: isVerified)
    }
}

#Preview {
    NavigationStack {
        OTPView(phoneNumber: "+94 77 123 4567")
            .environmentObject(AuthViewModel())
    }
}
