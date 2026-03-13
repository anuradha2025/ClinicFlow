import SwiftUI
import AuthenticationServices

struct PhoneEntryView: View {
    
    @EnvironmentObject var authVM: AuthViewModel
    @State private var phoneNumber: String = ""
    @State private var contentOpacity: Double = 0
    @FocusState private var isPhoneFocused: Bool
    @State private var navigateToOTP: Bool = false

    var body: some View {
        
        ZStack {
            AppBackground()

            ScrollView(showsIndicators: false) {
                
                VStack(spacing: 0) {
                    
                    Spacer().frame(height: 60)

                    // ICON
                    IconCircle(systemName: "phone.fill")

                    Spacer().frame(height: 32)

                    Text("Enter Your Number")
                        .font(.system(size: 30, weight: .bold, design: .rounded))
                        .foregroundColor(.white)

                    Spacer().frame(height: 10)

                    Text("We'll send a verification code\nto confirm your identity")
                        .font(.system(size: 15, design: .rounded))
                        .foregroundColor(.white.opacity(0.6))
                        .multilineTextAlignment(.center)
                        .lineSpacing(4)

                    Spacer().frame(height: 48)

                    // PHONE FIELD
                    VStack(alignment: .leading, spacing: 8) {

                        Text("Phone Number")
                            .font(.system(size: 13, weight: .semibold, design: .rounded))
                            .foregroundColor(.white.opacity(0.7))
                            .padding(.horizontal, 4)

                        HStack(spacing: 12) {

                            HStack(spacing: 6) {
                                Text("🇱🇰")
                                Text("+94")
                                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                                    .foregroundColor(.white)
                            }
                            .padding(.horizontal, 14)
                            .padding(.vertical, 14)
                            .background(
                                RoundedRectangle(cornerRadius: 14)
                                    .fill(Color.white.opacity(0.12))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 14)
                                            .stroke(Color.white.opacity(0.2), lineWidth: 1)
                                    )
                            )

                            HStack {

                                TextField("", text: $phoneNumber,
                                          prompt: Text("7X XXX XXXX")
                                            .foregroundColor(.white.opacity(0.3)))
                                
                                    .font(.system(size: 18, weight: .medium, design: .rounded))
                                    .foregroundColor(.white)
                                    .keyboardType(.phonePad)
                                    .focused($isPhoneFocused)

                                    .onChange(of: phoneNumber) { _, v in
                                        phoneNumber = String(v.filter { $0.isNumber }.prefix(9))
                                    }

                                Text("\(phoneNumber.count)/9")
                                    .font(.system(size: 11, design: .rounded))
                                    .foregroundColor(phoneNumber.count == 9 ? .green : .white.opacity(0.3))
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 16)
                            .background(
                                RoundedRectangle(cornerRadius: 14)
                                    .fill(Color.white.opacity(0.10))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 14)
                                            .stroke(
                                                isPhoneFocused ?
                                                Color.white.opacity(0.6)
                                                :
                                                Color.white.opacity(0.2),
                                                lineWidth: 1.5
                                            )
                                    )
                            )
                        }
                    }
                    .padding(.horizontal, 32)

                    Spacer().frame(height: 16)

                    // ERROR
                    if authVM.showError {
                        Text(authVM.errorMessage)
                            .font(.system(size: 13, design: .rounded))
                            .foregroundColor(.red.opacity(0.9))
                            .padding(.horizontal, 32)
                    }

                    Spacer().frame(height: 20)

                    // SEND CODE BUTTON
                    PrimaryButton(
                        label: "Send Code",
                        icon: "paperplane.fill",
                        isEnabled: phoneNumber.count >= 9,
                        isLoading: authVM.isLoading
                    ) {
                        authVM.sendOTP(phone: "+94\(phoneNumber)")
                    }

                    Spacer().frame(height: 28)

                    // DIVIDER
                    HStack(spacing: 12) {

                        Rectangle()
                            .fill(Color.white.opacity(0.2))
                            .frame(height: 1)

                        Text("or continue with")
                            .font(.system(size: 12, design: .rounded))
                            .foregroundColor(.white.opacity(0.4))
                            .fixedSize()

                        Rectangle()
                            .fill(Color.white.opacity(0.2))
                            .frame(height: 1)
                    }
                    .padding(.horizontal, 32)

                    Spacer().frame(height: 20)

                    // SOCIAL BUTTONS
                    VStack(spacing: 12) {

                        // GOOGLE LOGIN
                        Button(action: {
                            authVM.signInWithGoogle()
                        }) {
                            HStack(spacing: 10) {
                                
                                Image("google")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 22, height: 22)

                                Text("Continue with Google")
                                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                                    .foregroundColor(.white)
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 54)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color.white.opacity(0.10))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(Color.white.opacity(0.2), lineWidth: 1)
                                    )
                            )
                        }


                        // APPLE LOGIN
                        SignInWithAppleButton(.continue) { request in
                            request.requestedScopes = [.fullName, .email]
                        } onCompletion: { result in
                            authVM.handleAppleSignIn(result: result)
                        }
                        .signInWithAppleButtonStyle(.white)
                        .frame(height: 54)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.white.opacity(0.2), lineWidth: 1)
                        )
                    }
                    .padding(.horizontal, 32)

                    Spacer().frame(height: 24)

                    // TERMS
                    Text("By continuing, you agree to our Terms of Service\nand Privacy Policy")
                        .font(.system(size: 12, design: .rounded))
                        .foregroundColor(.white.opacity(0.4))
                        .multilineTextAlignment(.center)
                        .lineSpacing(4)

                    Spacer().frame(height: 40)
                }
                .opacity(contentOpacity)
            }
        }
        .navigationDestination(isPresented: $navigateToOTP) {
            OTPView(phoneNumber: "+94 \(phoneNumber)")
        }
        .onChange(of: authVM.otpSent) { _, sent in
            if sent { navigateToOTP = true }
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.6).delay(0.1)) {
                contentOpacity = 1
            }
            isPhoneFocused = true
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        PhoneEntryView()
    }
    .environmentObject(AuthViewModel())
}
