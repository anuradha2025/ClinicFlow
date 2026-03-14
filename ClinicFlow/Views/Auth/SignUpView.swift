import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var authVM: AuthViewModel
    
    @State private var fullName = ""
    @State private var email = ""
    @State private var phone = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var showPassword = false
    @State private var showConfirmPassword = false
    @State private var agreedToTerms = false
    @State private var navigateToLogin = false
    
    enum Field { case fullName, email, phone, password, confirmPassword }
    @FocusState private var focusedField: Field?
    
    var passwordsMatch: Bool {
        confirmPassword.isEmpty || password == confirmPassword
    }
    
    var isFormValid: Bool {
        !fullName.isEmpty &&
        !email.isEmpty &&
        email.contains("@") &&
        !phone.isEmpty &&
        password.count >= 6 &&
        password == confirmPassword &&
        agreedToTerms
    }
    
    var passwordStrength: (label: String, color: Color, width: CGFloat) {
        switch password.count {
        case 0:    return ("", .clear, 0)
        case 1...5: return ("Weak", .red, 0.33)
        case 6...9: return ("Medium", .orange, 0.66)
        default:   return ("Strong", .green, 1.0)
        }
    }
    
    var body: some View {
        ZStack {
            AppBackground()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    Spacer().frame(height: 48)
                    

                    IconCircle(systemName: "person.badge.plus.fill")
                    Spacer().frame(height: 24)
                    
                    Text("Create Account")
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                    Spacer().frame(height: 8)
                    Text("Join MediQueue today")
                        .font(.system(size: 15, design: .rounded))
                        .foregroundColor(.white.opacity(0.6))
                    
                    Spacer().frame(height: 40)
                    
                    VStack(spacing: 16) {
                        

                        AuthField(
                            label: "Full Name",
                            icon: "person.fill",
                            isFocused: focusedField == .fullName
                        ) {
                            TextField("", text: $fullName,
                                      prompt: Text("John Doe")
                                .foregroundColor(.white.opacity(0.3)))
                            .font(.system(size: 16, design: .rounded))
                            .foregroundColor(.white)
                            .focused($focusedField, equals: .fullName)
                            .submitLabel(.next)
                            .onSubmit { focusedField = .email }
                        }
                        

                        AuthField(
                            label: "Gmail Address",
                            icon: "envelope.fill",
                            isFocused: focusedField == .email,
                            trailingView: {
                                if email.lowercased().hasSuffix("@gmail.com") {
                                    Image(systemName: "checkmark.seal.fill")
                                        .foregroundColor(.green)
                                        .font(.system(size: 16))
                                        .transition(.scale.combined(with: .opacity))
                                }
                            }
                        ) {
                            TextField("", text: $email,
                                      prompt: Text("yourname@gmail.com")
                                .foregroundColor(.white.opacity(0.3)))
                            .font(.system(size: 16, design: .rounded))
                            .foregroundColor(.white)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                            .autocorrectionDisabled()
                            .focused($focusedField, equals: .email)
                            .submitLabel(.next)
                            .onSubmit { focusedField = .phone }
                        }
                        

                        AuthField(
                            label: "Phone Number",
                            icon: "phone.fill",
                            isFocused: focusedField == .phone
                        ) {
                            TextField("", text: $phone,
                                      prompt: Text("+94 7X XXX XXXX")
                                .foregroundColor(.white.opacity(0.3)))
                            .font(.system(size: 16, design: .rounded))
                            .foregroundColor(.white)
                            .keyboardType(.phonePad)
                            .focused($focusedField, equals: .phone)
                            .submitLabel(.next)
                            .onSubmit { focusedField = .password }
                        }
                        

                        AuthField(
                            label: "Password",
                            icon: "lock.fill",
                            isFocused: focusedField == .password,
                            trailingView: {
                                Button(action: { showPassword.toggle() }) {
                                    Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                                        .foregroundColor(.white.opacity(0.5))
                                }
                            }
                        ) {
                            Group {
                                if showPassword {
                                    TextField("", text: $password,
                                              prompt: Text("Min. 6 characters")
                                        .foregroundColor(.white.opacity(0.3)))
                                } else {
                                    SecureField("", text: $password,
                                                prompt: Text("Min. 6 characters")
                                        .foregroundColor(.white.opacity(0.3)))
                                }
                            }
                            .font(.system(size: 16, design: .rounded))
                            .foregroundColor(.white)
                            .focused($focusedField, equals: .password)
                            .submitLabel(.next)
                            .onSubmit { focusedField = .confirmPassword }
                        }
                        
                
                        if !password.isEmpty {
                            VStack(alignment: .leading, spacing: 4) {
                                GeometryReader { geo in
                                    ZStack(alignment: .leading) {
                                        RoundedRectangle(cornerRadius: 4)
                                            .fill(Color.white.opacity(0.1))
                                            .frame(height: 4)
                                        RoundedRectangle(cornerRadius: 4)
                                            .fill(passwordStrength.color)
                                            .frame(width: geo.size.width * passwordStrength.width, height: 4)
                                            .animation(.spring(response: 0.4), value: password.count)
                                    }
                                }
                                .frame(height: 4)
                                Text(passwordStrength.label)
                                    .font(.system(size: 11, weight: .semibold, design: .rounded))
                                    .foregroundColor(passwordStrength.color)
                            }
                            .padding(.horizontal, 4)
                        }
                        

                        AuthField(
                            label: "Confirm Password",
                            icon: confirmPassword.isEmpty ? "lock.fill" :
                                  passwordsMatch ? "lock.fill" : "exclamationmark.shield.fill",
                            iconColor: confirmPassword.isEmpty ? .white.opacity(0.4) :
                                       passwordsMatch ? .green : .red.opacity(0.8),
                            isFocused: focusedField == .confirmPassword,
                            borderColor: !passwordsMatch && !confirmPassword.isEmpty ?
                                         .red.opacity(0.6) : nil,
                            trailingView: {
                                Button(action: { showConfirmPassword.toggle() }) {
                                    Image(systemName: showConfirmPassword ? "eye.slash.fill" : "eye.fill")
                                        .foregroundColor(.white.opacity(0.5))
                                }
                            }
                        ) {
                            Group {
                                if showConfirmPassword {
                                    TextField("", text: $confirmPassword,
                                              prompt: Text("Re-enter password")
                                        .foregroundColor(.white.opacity(0.3)))
                                } else {
                                    SecureField("", text: $confirmPassword,
                                                prompt: Text("Re-enter password")
                                        .foregroundColor(.white.opacity(0.3)))
                                }
                            }
                            .font(.system(size: 16, design: .rounded))
                            .foregroundColor(.white)
                            .focused($focusedField, equals: .confirmPassword)
                            .submitLabel(.done)
                            .onSubmit { focusedField = nil }
                        }
                        

                        if !confirmPassword.isEmpty {
                            HStack(spacing: 6) {
                                Image(systemName: passwordsMatch ? "checkmark.circle.fill" : "xmark.circle.fill")
                                    .font(.system(size: 12))
                                Text(passwordsMatch ? "Passwords match" : "Passwords do not match")
                                    .font(.system(size: 12, design: .rounded))
                            }
                            .foregroundColor(passwordsMatch ? .green.opacity(0.9) : .red.opacity(0.9))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 4)
                            .animation(.easeInOut(duration: 0.2), value: passwordsMatch)
                        }
                    }
                    .padding(.horizontal, 32)
                    

                    Spacer().frame(height: 24)
                    HStack(alignment: .top, spacing: 12) {
                        Button(action: { agreedToTerms.toggle() }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 6)
                                    .fill(agreedToTerms ? Color.white : Color.white.opacity(0.1))
                                    .frame(width: 22, height: 22)
                                    .overlay(RoundedRectangle(cornerRadius: 6)
                                        .stroke(Color.white.opacity(0.3), lineWidth: 1))
                                if agreedToTerms {
                                    Image(systemName: "checkmark")
                                        .font(.system(size: 12, weight: .bold))
                                        .foregroundColor(Theme.buttonText)
                                }
                            }
                        }
                        .padding(.top, 1)
                        
                        Text("I agree to the \(Text("Terms of Service").font(.system(size: 13, weight: .semibold, design: .rounded)).foregroundColor(Theme.accent)) and \(Text("Privacy Policy").font(.system(size: 13, weight: .semibold, design: .rounded)).foregroundColor(Theme.accent))")
                            .font(.system(size: 13, design: .rounded))
                            .foregroundColor(.white.opacity(0.6))
                    }
                    .padding(.horizontal, 32)
                    

                    if authVM.showError {
                        Spacer().frame(height: 16)
                        HStack(spacing: 8) {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .font(.system(size: 13))
                            Text(authVM.errorMessage)
                                .font(.system(size: 13, design: .rounded))
                        }
                        .foregroundColor(.red.opacity(0.9))
                        .padding(.horizontal, 32)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    

                    Spacer().frame(height: 28)
                    AuthPrimaryButton(
                        label: "Create Account",
                        icon: "checkmark.circle.fill",
                        isEnabled: isFormValid,
                        isLoading: authVM.isLoading
                    ) {
                        focusedField = nil
                        authVM.signUp(
                            fullName: fullName,
                            email: email,
                            phone: phone,
                            password: password
                        )
                    }
                    

                    Spacer().frame(height: 32)
                    HStack(spacing: 12) {
                        Rectangle().fill(Color.white.opacity(0.15)).frame(height: 1)
                        Text("or").font(.system(size: 13, design: .rounded)).foregroundColor(.white.opacity(0.4))
                        Rectangle().fill(Color.white.opacity(0.15)).frame(height: 1)
                    }
                    .padding(.horizontal, 32)
                    

                    Spacer().frame(height: 24)
                    NavigationLink(destination: LoginView()) {
                        HStack(spacing: 16) {
                            ZStack {
                                Circle()
                                    .fill(Color.white.opacity(0.12))
                                    .frame(width: 46, height: 46)
                                Image(systemName: "person.crop.circle.badge.checkmark")
                                    .font(.system(size: 20))
                                    .foregroundColor(Theme.accent)
                            }
                            VStack(alignment: .leading, spacing: 3) {
                                Text("Already have an account?")
                                    .font(.system(size: 13, design: .rounded))
                                    .foregroundColor(.white.opacity(0.5))
                                Text("Sign in here")
                                    .font(.system(size: 15, weight: .semibold, design: .rounded))
                                    .foregroundColor(.white)
                            }
                            Spacer()
                            Image(systemName: "chevron.right")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.white.opacity(0.4))
                        }
                        .padding(16)
                        .background(
                            RoundedRectangle(cornerRadius: 18)
                                .fill(Color.white.opacity(0.08))
                                .overlay(RoundedRectangle(cornerRadius: 18)
                                    .stroke(Color.white.opacity(0.15), lineWidth: 1))
                        )
                        .padding(.horizontal, 32)
                    }
                    
                    Spacer().frame(height: 48)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onTapGesture { focusedField = nil }
  
        .onChange(of: authVM.signUpSuccess) { _, success in
            if success {
                authVM.signUpSuccess = false // reset flag
                navigateToLogin = true
            }
        }
        .navigationDestination(isPresented: $navigateToLogin) {
            LoginView()
        }
    }
}


struct AuthField<Content: View, Trailing: View>: View {
    let label: String
    let icon: String
    var iconColor: Color = .white.opacity(0.5)
    var isFocused: Bool = false
    var borderColor: Color? = nil
    var trailingView: (() -> Trailing)?
    @ViewBuilder let content: () -> Content
    
    init(
        label: String,
        icon: String,
        iconColor: Color = .white.opacity(0.5),
        isFocused: Bool = false,
        borderColor: Color? = nil,
        @ViewBuilder trailingView: @escaping () -> Trailing,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.label = label
        self.icon = icon
        self.iconColor = iconColor
        self.isFocused = isFocused
        self.borderColor = borderColor
        self.trailingView = trailingView
        self.content = content
    }
    
    var resolvedBorder: Color {
        borderColor ?? (isFocused ? .white.opacity(0.6) : .white.opacity(0.2))
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(label)
                .font(.system(size: 13, weight: .semibold, design: .rounded))
                .foregroundColor(.white.opacity(0.7))
                .padding(.horizontal, 4)
            
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .foregroundColor(iconColor)
                    .frame(width: 20)
                    .animation(.easeInOut, value: iconColor)
                
                content()
                
                trailingView?()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 16)
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .fill(Color.white.opacity(0.10))
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(resolvedBorder, lineWidth: 1.5)
                    )
            )
            .animation(.easeInOut(duration: 0.2), value: isFocused)
        }
    }
}


extension AuthField where Trailing == EmptyView {
    init(
        label: String,
        icon: String,
        iconColor: Color = .white.opacity(0.5),
        isFocused: Bool = false,
        borderColor: Color? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.label = label
        self.icon = icon
        self.iconColor = iconColor
        self.isFocused = isFocused
        self.borderColor = borderColor
        self.trailingView = nil
        self.content = content
    }
}

#Preview {
    NavigationStack {
        SignUpView()
            .environmentObject(AuthViewModel())
    }
}
