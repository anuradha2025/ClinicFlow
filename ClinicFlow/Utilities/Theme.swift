import SwiftUI

struct Theme {
    static let gradientColors: [Color] = [
        Color(red: 0.05, green: 0.10, blue: 0.30),
        Color(red: 0.10, green: 0.25, blue: 0.55),
        Color(red: 0.20, green: 0.50, blue: 0.85)
    ]
    
    static let gradient = LinearGradient(
        colors: gradientColors,
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static let accent = Color(red: 0.55, green: 0.85, blue: 1.0)
    static let buttonText = Color(red: 0.10, green: 0.25, blue: 0.60)
    
    static func primaryButton(_ enabled: Bool = true) -> some View {
        RoundedRectangle(cornerRadius: 18)
            .fill(enabled ? Color.white : Color.white.opacity(0.35))
            .shadow(color: Color.black.opacity(0.2), radius: 16, x: 0, y: 8)
    }
}


struct AppBackground: View {
    var body: some View {
        ZStack {
            Theme.gradient.ignoresSafeArea()
            Circle().fill(Color.white.opacity(0.04)).frame(width: 350, height: 350).offset(x: -120, y: -280)
            Circle().fill(Color.white.opacity(0.06)).frame(width: 250, height: 250).offset(x: 140, y: 320)
        }
    }
}

struct AuthLightBackground: View {
    var body: some View {
        ZStack {
            Color.cfBg.ignoresSafeArea()

            Circle()
                .fill(Color.cfBlue.opacity(0.10))
                .frame(width: 320, height: 320)
                .offset(x: -140, y: -300)

            Circle()
                .fill(Color.cfBlueLight.opacity(0.9))
                .frame(width: 260, height: 260)
                .offset(x: 140, y: 340)
        }
    }
}


struct IconCircle: View {
    let systemName: String
    var size: CGFloat = 90
    var iconSize: CGFloat = 36
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.white.opacity(0.12))
                .frame(width: size, height: size)
                .overlay(Circle().stroke(Color.white.opacity(0.2), lineWidth: 1))
            Image(systemName: systemName)
                .resizable()
                .scaledToFit()
                .frame(width: iconSize, height: iconSize)
                .foregroundColor(.white)
        }
    }
}

struct AuthLightIconCircle: View {
    let systemName: String
    var size: CGFloat = 90
    var iconSize: CGFloat = 36

    var body: some View {
        ZStack {
            Circle()
                .fill(Color.cfBlue.opacity(0.12))
                .frame(width: size, height: size)
                .overlay(Circle().stroke(Color.cfBlue.opacity(0.22), lineWidth: 1))

            Image(systemName: systemName)
                .resizable()
                .scaledToFit()
                .frame(width: iconSize, height: iconSize)
                .foregroundColor(.cfBlue)
        }
    }
}


struct GlassTextField: View {
    let placeholder: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default
    var isSecure: Bool = false
    var icon: String = ""
    @FocusState.Binding var isFocused: Bool
    
    var body: some View {
        HStack(spacing: 12) {
            if !icon.isEmpty {
                Image(systemName: icon)
                    .foregroundColor(.white.opacity(0.5))
                    .frame(width: 20)
            }
            if isSecure {
                SecureField("", text: $text, prompt: Text(placeholder).foregroundColor(.white.opacity(0.3)))
                    .font(.system(size: 16, design: .rounded))
                    .foregroundColor(.white)
                    .focused($isFocused)
            } else {
                TextField("", text: $text, prompt: Text(placeholder).foregroundColor(.white.opacity(0.3)))
                    .font(.system(size: 16, design: .rounded))
                    .foregroundColor(.white)
                    .keyboardType(keyboardType)
                    .focused($isFocused)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 16)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color.white.opacity(0.10))
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(isFocused ? Color.white.opacity(0.6) : Color.white.opacity(0.2), lineWidth: 1.5)
                )
        )
    }
}


struct AuthPrimaryButton: View {
    let label: String
    let icon: String
    var isEnabled: Bool = true
    var isLoading: Bool = false
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 10) {
                if isLoading {
                    ProgressView().tint(Theme.buttonText)
                } else {
                    Text(label)
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                        .foregroundColor(Theme.buttonText)
                    Image(systemName: icon)
                        .font(.system(size: 16))
                        .foregroundColor(Theme.buttonText)
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 58)
            .background(Theme.primaryButton(isEnabled))
            .padding(.horizontal, 32)
        }
        .disabled(!isEnabled || isLoading)
    }
}
