import Foundation
import Combine

class AuthViewModel: ObservableObject {
    @Published var currentUser: User?
    @Published var isLoggedIn: Bool = false
    @Published var isLoading: Bool = false
    @Published var errorMessage: String = ""
    @Published var otpSent: Bool = false
    @Published var otpVerified: Bool = false
    @Published var showError: Bool = false
    @Published var signUpSuccess: Bool = false
    

    private var registeredUsers: [String: (password: String, user: User)] = [:]
    
    private let authService = AuthService.shared
    
    init() {
        if let user = authService.loadSession() {
            self.currentUser = user
            self.isLoggedIn = true
        }
        loadRegisteredUsers()
    }
    
    
 
    private let hardcodedOTP = "123456"

    func sendOTP(phone: String) {
        isLoading = true
        // Simulate small delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) { [weak self] in
            self?.isLoading = false
            self?.otpSent = true
            print("📱 OTP for \(phone): \(self?.hardcodedOTP ?? "")")
        }
    }

    func verifyOTP(phone: String, code: String) {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) { [weak self] in
            self?.isLoading = false
            if code == self?.hardcodedOTP {
                self?.otpVerified = true
            } else {
                self?.triggerError("Incorrect OTP. Use 123456")
            }
        }
    }
    
    func signUp(fullName: String, email: String, phone: String, password: String) {
        isLoading = true
        showError = false
        
        // Check if email already registered
        if registeredUsers[email.lowercased()] != nil {
            isLoading = false
            triggerError("An account with this email already exists.")
            return
        }
        
        authService.signUp(fullName: fullName, email: email, phone: phone, password: password) { [weak self] result in
            self?.isLoading = false
            switch result {
            case .success(let user):
              
                self?.registeredUsers[email.lowercased()] = (password: password, user: user)
                self?.saveRegisteredUsers()
              
                self?.signUpSuccess = true
            case .failure(let err):
                self?.triggerError(err.localizedDescription)
            }
        }
    }
    

    func login(email: String, password: String) {
        isLoading = true
        showError = false
        

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) { [weak self] in
            guard let self = self else { return }
            self.isLoading = false
            
            let key = email.lowercased()
            
       
            if let stored = self.registeredUsers[key] {
                if stored.password == password {
                    self.currentUser = stored.user
                    self.authService.saveSession(user: stored.user)
                    self.isLoggedIn = true
                } else {
                    self.triggerError("Incorrect password. Please try again.")
                }
                return
            }
            
            // Fallback demo account
            if key == "demo@mediqueue.com" && password == "password123" {
                let user = User(fullName: "Demo User", email: email, phone: "+94771234567")
                self.currentUser = user
                self.authService.saveSession(user: user)
                self.isLoggedIn = true
                return
            }
            
            self.triggerError("No account found with this email. Please sign up first.")
        }
    }
    
  
    func logout() {
        authService.clearSession()
        currentUser = nil
        isLoggedIn = false
        otpSent = false
        otpVerified = false
        showError = false
        errorMessage = ""
    }
    

    private func saveRegisteredUsers() {
        var store: [String: [String: String]] = [:]
        for (email, entry) in registeredUsers {
            store[email] = [
                "password": entry.password,
                "userId":   entry.user.id,
                "fullName": entry.user.fullName,
                "phone":    entry.user.phone
            ]
        }
        UserDefaults.standard.set(store, forKey: "registeredUsers")
    }
    private func loadRegisteredUsers() {
        guard let store = UserDefaults.standard.dictionary(forKey: "registeredUsers")
                as? [String: [String: String]] else { return }
        for (email, data) in store {
            guard let password = data["password"],
                  let fullName = data["fullName"],
                  let phone = data["phone"],
                  let userId = data["userId"] else { continue }
            let user = User(id: userId, fullName: fullName, email: email, phone: phone)
            registeredUsers[email] = (password: password, user: user)
        }
    }
    
    private func triggerError(_ message: String) {
        errorMessage = message
        showError = true
    }
}
