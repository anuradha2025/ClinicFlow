
import SwiftUI

struct SplashView: View {
    @State private var logoScale: CGFloat = 0.5
    @State private var logoOpacity: Double = 0
    @State private var titleOffset: CGFloat = 40
    @State private var titleOpacity: Double = 0
    @State private var subtitleOpacity: Double = 0
    @State private var buttonOpacity: Double = 0
    @State private var buttonOffset: CGFloat = 30
    @State private var pulseAnimation: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                AuthLightBackground()
                
                VStack(spacing: 0) {
                    Spacer()
                    
               
                    ZStack {
                        Circle()
                            .stroke(Color.cfBlue.opacity(0.18), lineWidth: 1.5)
                            .frame(width: pulseAnimation ? 160 : 130, height: pulseAnimation ? 160 : 130)
                            .animation(.easeOut(duration: 1.6).repeatForever(autoreverses: true), value: pulseAnimation)
                        Circle()
                            .stroke(Color.cfBlue.opacity(0.10), lineWidth: 1)
                            .frame(width: pulseAnimation ? 200 : 160, height: pulseAnimation ? 200 : 160)
                            .animation(.easeOut(duration: 1.6).repeatForever(autoreverses: true).delay(0.2), value: pulseAnimation)
                        Circle()
                            .fill(LinearGradient(colors: [Color.cfBlue.opacity(0.22), Color.cfBlue.opacity(0.12)], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .frame(width: 120, height: 120)
                            .overlay(Circle().stroke(Color.cfBlue.opacity(0.3), lineWidth: 1))
                        Image(systemName: "heart.text.square.fill")
                            .resizable()
                            .frame(width: 55, height: 55)
                            .foregroundStyle(LinearGradient(colors: [Color.cfBlue, Color.cfBlueDark], startPoint: .top, endPoint: .bottom))
                    }
                    .scaleEffect(logoScale)
                    .opacity(logoOpacity)
                    
                    Spacer().frame(height: 48)
                    
                    VStack(spacing: 8) {
                        Text("MediQueue")
                            .font(.system(size: 42, weight: .bold, design: .rounded))
                            .foregroundColor(.cfTextPrimary)
                        Text("HOSPITAL")
                            .font(.system(size: 18, weight: .semibold, design: .rounded))
                            .foregroundColor(.cfTextSecondary)
                            .kerning(10)
                    }
                    .offset(y: titleOffset)
                    .opacity(titleOpacity)
                    
                    Spacer().frame(height: 14)
                    
                    HStack(spacing: 6) {
                        Image(systemName: "sparkles").font(.system(size: 11))
                        Text("A U T O M A N A G E R")
                            .font(.system(size: 11, weight: .semibold, design: .rounded)).kerning(2)
                    }
                    .foregroundColor(.cfBlue)
                    .padding(.horizontal, 18).padding(.vertical, 8)
                    .background(Capsule().fill(Color.cfBlueLight).overlay(Capsule().stroke(Color.cfBlue.opacity(0.16), lineWidth: 1)))
                    .opacity(subtitleOpacity)
                    
                    Spacer().frame(height: 20)
                    Text("Book Hospital Appointments Easily")
                        .font(.system(size: 16, design: .rounded))
                        .foregroundColor(.cfTextSecondary)
                        .opacity(subtitleOpacity)
                    
                    Spacer()
                    
                    HStack(spacing: 24) {
                        FeaturePill(icon: "calendar.badge.checkmark", label: "Easy Booking")
                        FeaturePill(icon: "bell.badge.fill", label: "Reminders")
                        FeaturePill(icon: "lock.shield.fill", label: "Secure")
                    }
                    .opacity(buttonOpacity)
                    
                    Spacer().frame(height: 36)
                    
                    NavigationLink(destination: PhoneEntryView()) {
                        HStack(spacing: 12) {
                            Text("Get Started")
                                .font(.system(size: 18, weight: .semibold, design: .rounded))
                                .foregroundColor(.white)
                            Image(systemName: "arrow.right.circle.fill")
                                .font(.system(size: 20))
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity).frame(height: 58)
                        .background(
                            RoundedRectangle(cornerRadius: 18)
                                .fill(Color.cfBlue)
                                .shadow(color: Color.cfBlue.opacity(0.28), radius: 14, x: 0, y: 8)
                        )
                        .padding(.horizontal, 32)
                    }
                    .opacity(buttonOpacity)
                    .offset(y: buttonOffset)
                    
                    Spacer().frame(height: 48)
                }
            }
            .navigationBarHidden(true)
            .onAppear {
                withAnimation(.spring(response: 0.7, dampingFraction: 0.6).delay(0.1)) { logoScale = 1.0; logoOpacity = 1.0 }
                withAnimation(.easeOut(duration: 0.6).delay(0.5)) { titleOffset = 0; titleOpacity = 1.0 }
                withAnimation(.easeOut(duration: 0.5).delay(0.8)) { subtitleOpacity = 1.0 }
                withAnimation(.spring(response: 0.6, dampingFraction: 0.7).delay(1.0)) { buttonOpacity = 1.0; buttonOffset = 0 }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { pulseAnimation = true }
            }
        }
    }
}

struct FeaturePill: View {
    let icon: String; let label: String
    var body: some View {
        VStack(spacing: 6) {
            Image(systemName: icon).font(.system(size: 18)).foregroundColor(.cfBlue)
            Text(label).font(.system(size: 11, weight: .medium, design: .rounded)).foregroundColor(.cfTextSecondary)
        }
        .frame(width: 80).padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color.white)
                .overlay(RoundedRectangle(cornerRadius: 14).stroke(Color.cfDivider, lineWidth: 1))
        )
    }
}

#Preview {
    SplashView()
        .environmentObject(AuthViewModel())
}
