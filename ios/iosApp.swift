

import SwiftUI

@main
struct iosApp: App {
    @StateObject private var authVM = AuthViewModel()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(authVM)
        }
    }
}

struct RootView: View {
    @EnvironmentObject var authVM: AuthViewModel

    var body: some View {
        Group {
            if authVM.isLoggedIn {
                AppointmentView()
            } else {
                SplashView() 
            }
        }
        .animation(.easeInOut, value: authVM.isLoggedIn)
    }
}
