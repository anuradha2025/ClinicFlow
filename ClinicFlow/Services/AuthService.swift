import Foundation


class AuthService {
    static let shared = AuthService()
    private init() {}
    
    
    private var otpStore: [String: String] = [:]
    
    func sendOTP(to phone: String, completion: @escaping (Result<String, Error>) -> Void) {
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            let otp = String(format: "%06d", Int.random(in: 100000...999999))
            self.otpStore[phone] = otp
            print("📱 OTP for \(phone): \(otp)")
            DispatchQueue.main.async {
                completion(.success("OTP sent successfully"))
            }
        }
    }
    
    func verifyOTP(phone: String, code: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            let stored = self.otpStore[phone]
            let isValid = stored == code || code == "123456"
            DispatchQueue.main.async {
                completion(.success(isValid))
            }
        }
    }
    
    func login(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.2) {
           
            if email == "demo@mediqueue.com" && password == "password123" {
                let user = User(fullName: "Kasun Perera", email: email, phone: "+94771234567")
                DispatchQueue.main.async { completion(.success(user)) }
            } else {
                DispatchQueue.main.async {
                    completion(.failure(NSError(domain: "", code: 401,
                        userInfo: [NSLocalizedDescriptionKey: "Invalid email or password"])))
                }
            }
        }
    }
    
    func signUp(fullName: String, email: String, phone: String, password: String,
                completion: @escaping (Result<User, Error>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.5) {
            let user = User(fullName: fullName, email: email, phone: phone)
            DispatchQueue.main.async { completion(.success(user)) }
        }
    }
    
    func saveSession(user: User) {
        if let data = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(data, forKey: "currentUser")
        }
    }
    
    func loadSession() -> User? {
        guard let data = UserDefaults.standard.data(forKey: "currentUser"),
              let user = try? JSONDecoder().decode(User.self, from: data) else { return nil }
        return user
    }
    
    func clearSession() {
        UserDefaults.standard.removeObject(forKey: "currentUser")
    }
}
