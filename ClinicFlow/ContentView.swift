

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var nav: AppNavigation
    @EnvironmentObject var appState: AppState

    var body: some View {
        ZStack {
            TabView(selection: $appState.selectedTab) {
                HomeView()
                    .tabItem { Label("Home", systemImage: "house.fill") }
                    .tag(0)

                FindDoctorView()
                    .tabItem { Label("Doctors", systemImage: "stethoscope") }
                    .tag(1)

                MyAppointmentsView()
                    .tabItem { Label("Appointments", systemImage: "calendar") }
                    .tag(2)

                LaboratoryView()
                    .environmentObject(nav)
                    .tabItem { Label("Laboratory", systemImage: "cross.case.fill") }
                    .tag(3)

                PharmacyTabRoot()
                    .tabItem { Label("Pharmacy", systemImage: "pills.fill") }
                    .tag(4)
            }
            .tint(.cfBlue)

            if let test = nav.selectedTest {
                if nav.showSuccess {
                    LabPaymentSuccessView(test: test)
                        .environmentObject(nav)
                        .environmentObject(appState)
                        .transition(.move(edge: .trailing))
                } else if nav.showPayment {
                    LabPaymentView(test: test)
                        .environmentObject(nav)
                        .transition(.move(edge: .trailing))
                } else if nav.showBooking {
                    BookingView(test: test)
                        .environmentObject(nav)
                        .transition(.move(edge: .trailing))
                } else {
                    TestDetailView(test: test)
                        .environmentObject(nav)
                        .transition(.move(edge: .trailing))
                }
            } else if let appointment = nav.referralAppointment {
                AppointmentLaboratoryReferralView(appointment: appointment)
                    .environmentObject(nav)
                    .environmentObject(appState)
                    .transition(.move(edge: .trailing))
            }
        }
        .animation(.easeInOut(duration: 0.28), value: nav.selectedTest)
        .animation(.easeInOut(duration: 0.28), value: nav.showBooking)
        .animation(.easeInOut(duration: 0.28), value: nav.showPayment)
        .animation(.easeInOut(duration: 0.28), value: nav.showSuccess)
    }
}

struct PlaceholderView: View {
    let title: String
    let icon:  String
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 44))
                .foregroundColor(.cfBlue.opacity(0.4))
            Text(title)
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.cfTextSecondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.cfBg.ignoresSafeArea())
    }
}

private struct PharmacyTabRoot: View {
    @EnvironmentObject var appState: AppState
    @State private var navigationKey = 0

    var body: some View {
        NavigationStack {
            PharmacyView(showsBackButton: false)
        }
        .id(navigationKey)
        .onChange(of: appState.popToRoot) { shouldPop in
            if shouldPop && appState.selectedTab == 4 {
                navigationKey += 1
                appState.popToRoot = false
            }
        }
    }
}
