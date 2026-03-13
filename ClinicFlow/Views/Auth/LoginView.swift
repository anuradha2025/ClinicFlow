import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authVM: AuthViewModel
    
    @State private var email = ""
    @State private var password = ""
    @State private var showPassword = false
    @State private var rememberMe = false
    @State private var shakeOffset: CGFloat = 0
    @State private var contentOpacity: Double = 0
    
    enum Field { case email, password }
    @FocusState private var focusedField: Field?
    
    var isFormValid: Bool {
        !email.isEmpty && !password.isEmpty
    }
    
    var body: some View {
        ZStack {
            AppBackground()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    Spacer().frame(height: 60)
                    
                  
                    IconCircle(systemName: "person.crop.circle.fill")
                    Spacer().frame(height: 28)
                    
                    Text("Welcome Back")
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                    Spacer().frame(height: 8)
                    Text("Sign in to your MediQueue account")
                        .font(.system(size: 15, design: .rounded))
                        .foregroundColor(.white.opacity(0.6))
                    
                    Spacer().frame(height: 44)
                
                    
                    VStack(spacing: 16) {
                        
               
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Gmail Address")
                                .font(.system(size: 13, weight: .semibold, design: .rounded))
                                .foregroundColor(.white.opacity(0.7))
                                .padding(.horizontal, 4)
                            
                            HStack(spacing: 12) {
                                Image(systemName: "envelope.fill")
                                    .foregroundColor(focusedField == .email ? Theme.accent : .white.opacity(0.4))
                                    .frame(width: 20)
                                    .animation(.easeInOut, value: focusedField)
                                
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
                                .onSubmit { focusedField = .password }
                                
                             
                                if email.lowercased().hasSuffix("@gmail.com") {
                                    Image(systemName: "checkmark.seal.fill")
                                        .foregroundColor(.green)
                                        .font(.system(size: 16))
                                        .transition(.scale.combined(with: .opacity))
                                }
                            }
                            .padding(.horizontal, 16).padding(.vertical, 16)
                            .background(
                                RoundedRectangle(cornerRadius: 14)
                                    .fill(Color.white.opacity(0.10))
                                    .overlay(RoundedRectangle(cornerRadius: 14)
                                        .stroke(focusedField == .email ? Color.white.opacity(0.6) : Color.white.opacity(0.2), lineWidth: 1.5))
                            )
                            .animation(.easeInOut(duration: 0.2), value: focusedField == .email)
                        }
                        
                 
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text("Password")
                                    .font(.system(size: 13, weight: .semibold, design: .rounded))
                                    .foregroundColor(.white.opacity(0.7))
                                    .padding(.horizontal, 4)
                                Spacer()
                                Button("Forgot Password?") {}
                                    .font(.system(size: 12, weight: .semibold, design: .rounded))
                                    .foregroundColor(Theme.accent)
                                    .padding(.trailing, 4)
                            }
                            
                            HStack(spacing: 12) {
                                Image(systemName: "lock.fill")
                                    .foregroundColor(focusedField == .password ? Theme.accent : .white.opacity(0.4))
                                    .frame(width: 20)
                                    .animation(.easeInOut, value: focusedField)
                                
                                if showPassword {
                                    TextField("", text: $password,
                                              prompt: Text("Enter your password")
                                        .foregroundColor(.white.opacity(0.3)))
                                    .font(.system(size: 16, design: .rounded))
                                    .foregroundColor(.white)
                                    .focused($focusedField, equals: .password)
                                    .submitLabel(.done)
                                    .onSubmit {
                                        focusedField = nil
                                        if isFormValid { handleLogin() }
                                    }
                                } else {
                                    SecureField("", text: $password,
                                                prompt: Text("Enter your password")
                                        .foregroundColor(.white.opacity(0.3)))
                                    .font(.system(size: 16, design: .rounded))
                                    .foregroundColor(.white)
                                    .focused($focusedField, equals: .password)
                                    .submitLabel(.done)
                                    .onSubmit {
                                        focusedField = nil
                                        if isFormValid { handleLogin() }
                                    }
                                }
                                
                                Button(action: { showPassword.toggle() }) {
                                    Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                                        .foregroundColor(.white.opacity(0.5))
                                }
                            }
                            .padding(.horizontal, 16).padding(.vertical, 16)
                            .background(
                                RoundedRectangle(cornerRadius: 14)
                                    .fill(Color.white.opacity(0.10))
                                    .overlay(RoundedRectangle(cornerRadius: 14)
                                        .stroke(focusedField == .password ? Color.white.opacity(0.6) : Color.white.opacity(0.2), lineWidth: 1.5))
                            )
                            .animation(.easeInOut(duration: 0.2), value: focusedField == .password)
                        }
                        
                 
                        HStack(spacing: 10) {
                            Button(action: { rememberMe.toggle() }) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 6)
                                        .fill(rememberMe ? Color.white : Color.white.opacity(0.1))
                                        .frame(width: 20, height: 20)
                                        .overlay(RoundedRectangle(cornerRadius: 6)
                                            .stroke(Color.white.opacity(0.3), lineWidth: 1))
                                    if rememberMe {
                                        Image(systemName: "checkmark")
                                            .font(.system(size: 11, weight: .bold))
                                            .foregroundColor(Theme.buttonText)
                                    }
                                }
                            }
                            Text("Remember me")
                                .font(.system(size: 13, design: .rounded))
                                .foregroundColor(.white.opacity(0.6))
                            Spacer()
                        }
                    }
                    .padding(.horizontal, 32)
                    .offset(x: shakeOffset)
                    

                    if authVM.showError {
                        Spacer().frame(height: 16)
                        HStack(spacing: 8) {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .font(.system(size: 13))
                            Text(authVM.errorMessage)
                                .font(.system(size: 13, design: .rounded))
                                .multilineTextAlignment(.leading)
                        }
                        .foregroundColor(.red.opacity(0.9))
                        .padding(.horizontal, 32)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                
                    Spacer().frame(height: 28)
                    PrimaryButton(
                        label: "Sign In",
                        icon: "arrow.right.circle.fill",
                        isEnabled: isFormValid,
                        isLoading: authVM.isLoading
                    ) {
                        focusedField = nil
                        handleLogin()
                    }
                    

                    Spacer().frame(height: 32)
                    HStack(spacing: 12) {
                        Rectangle().fill(Color.white.opacity(0.15)).frame(height: 1)
                        Text("or")
                            .font(.system(size: 13, design: .rounded))
                            .foregroundColor(.white.opacity(0.4))
                        Rectangle().fill(Color.white.opacity(0.15)).frame(height: 1)
                    }
                    .padding(.horizontal, 32)
                    
          
                    Spacer().frame(height: 24)
                    NavigationLink(destination: SignUpView()) {
                        HStack(spacing: 16) {
                            ZStack {
                                Circle()
                                    .fill(Color.white.opacity(0.12))
                                    .frame(width: 46, height: 46)
                                Image(systemName: "person.badge.plus.fill")
                                    .font(.system(size: 20))
                                    .foregroundColor(Theme.accent)
                            }
                            VStack(alignment: .leading, spacing: 3) {
                                Text("Don't have an account?")
                                    .font(.system(size: 13, design: .rounded))
                                    .foregroundColor(.white.opacity(0.5))
                                Text("Create a free account")
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
            .opacity(contentOpacity)
        }
        .navigationBarTitleDisplayMode(.inline)
        .onTapGesture { focusedField = nil }
        .onAppear {
            withAnimation(.easeOut(duration: 0.5)) { contentOpacity = 1 }
        }
        .onChange(of: authVM.showError) { _, isError in
            if isError { shake() }
        }
    }
    
    func handleLogin() {
        authVM.login(email: email, password: password)
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
}

#Preview {
    NavigationStack {
        LoginView()
            .environmentObject(AuthViewModel())
    }
}
