//
//  HospitalIndooeMap.swift
//  ClinicFlow
//
//  Created by COBSCCOMP242P-028 on 2026-03-13.
//

import SwiftUI

struct HospitalIndoorMapView: View {
    @Environment(\.dismiss) var dismiss
    @State private var selectedFloor = 0
    @State private var selectedRoom: IndoorRoom? = nil
    @State private var mapScale: CGFloat = 1.0
    @State private var mapOffset: CGSize = .zero
    @State private var lastScale: CGFloat = 1.0
    @State private var lastOffset: CGSize = .zero

    let floorNames = ["Ground Floor", "1st Floor", "2nd Floor"]
    let floorColors: [Color] = [.cfSuccess, .cfBlue, Color(red: 0.64, green: 0.17, blue: 0.17)]

    var currentRooms: [IndoorRoom] {
        switch selectedFloor {
        case 0: return groundRooms
        case 1: return firstRooms
        default: return secondRooms
        }
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            // Background grid pattern
            Color(red: 0.91, green: 0.93, blue: 0.97).ignoresSafeArea()

            VStack(spacing: 0) {

                // ── Header ────────────────────────────────────────────
                ZStack {
                    LinearGradient(
                        colors: [Color.cfBlue, Color(red: 0.11, green: 0.30, blue: 0.78)],
                        startPoint: .topLeading, endPoint: .bottomTrailing
                    )
                    // Decorative circles
                    Circle().fill(Color.white.opacity(0.06))
                        .frame(width: 120).offset(x: 140, y: -10)
                    Circle().fill(Color.white.opacity(0.04))
                        .frame(width: 80).offset(x: -130, y: 20)

                    HStack {
                        Button { dismiss() } label: {
                            ZStack {
                                Circle().fill(Color.white.opacity(0.18)).frame(width: 38, height: 38)
                                Image(systemName: "chevron.left")
                                    .font(.system(size: 15, weight: .semibold))
                                    .foregroundColor(.white)
                            }
                        }
                        Spacer()
                        VStack(spacing: 2) {
                            Text("Hospital Map")
                                .font(.system(size: 17, weight: .bold))
                                .foregroundColor(.white)
                            Text("City General Hospital")
                                .font(.system(size: 11))
                                .foregroundColor(.white.opacity(0.7))
                        }
                        Spacer()
                        ZStack {
                            Circle().fill(Color.white.opacity(0.18)).frame(width: 38, height: 38)
                            Image(systemName: "location.fill")
                                .font(.system(size: 14))
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 14)
                }
                .frame(height: 90)

                // ── Floor Selector ───────────────────────────────────
                HStack(spacing: 0) {
                    ForEach(floorNames.indices, id: \.self) { i in
                        Button {
                            withAnimation(.spring(response: 0.3)) {
                                selectedFloor = i
                                selectedRoom = nil
                                mapOffset = .zero
                                lastOffset = .zero
                                mapScale = 1.0
                                lastScale = 1.0
                            }
                        } label: {
                            VStack(spacing: 4) {
                                HStack(spacing: 5) {
                                    Circle()
                                        .fill(selectedFloor == i ? floorColors[i] : Color.cfTextTertiary)
                                        .frame(width: 7, height: 7)
                                    Text(floorNames[i])
                                        .font(.system(size: 12, weight: selectedFloor == i ? .bold : .medium))
                                        .foregroundColor(selectedFloor == i ? .cfTextPrimary : .cfTextSecondary)
                                }
                                Rectangle()
                                    .fill(selectedFloor == i ? floorColors[i] : Color.clear)
                                    .frame(height: 2.5)
                                    .cornerRadius(2)
                            }
                            .padding(.vertical, 10)
                            .frame(maxWidth: .infinity)
                        }
                    }
                }
                .background(Color.white)
                .overlay(Rectangle().fill(Color.cfDivider).frame(height: 0.5), alignment: .bottom)

                // ── Map Canvas ───────────────────────────────────────
                GeometryReader { geo in
                    ZStack {
                        // Dot grid background
                        DotGridBackground()

                        // The map itself — freely pannable & zoomable
                        FloorCanvas(
                            rooms: currentRooms,
                            selectedRoom: $selectedRoom,
                            showEntrance: selectedFloor == 0,
                            floorColor: floorColors[selectedFloor]
                        )
                        .scaleEffect(mapScale, anchor: .center)
                        .offset(mapOffset)
                        .gesture(
                            SimultaneousGesture(
                                MagnificationGesture()
                                    .onChanged { v in
                                        mapScale = max(0.5, min(lastScale * v, 3.5))
                                    }
                                    .onEnded { _ in lastScale = mapScale },
                                DragGesture()
                                    .onChanged { v in
                                        mapOffset = CGSize(
                                            width: lastOffset.width + v.translation.width,
                                            height: lastOffset.height + v.translation.height
                                        )
                                    }
                                    .onEnded { _ in lastOffset = mapOffset }
                            )
                        )

                        // Zoom hints
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                VStack(spacing: 1) {
                                    Button {
                                        withAnimation(.spring()) {
                                            mapScale = min(mapScale + 0.3, 3.5)
                                            lastScale = mapScale
                                        }
                                    } label: {
                                        Image(systemName: "plus")
                                            .font(.system(size: 14, weight: .bold))
                                            .foregroundColor(.cfTextPrimary)
                                            .frame(width: 36, height: 36)
                                            .background(Color.white)
                                            .cornerRadius(10)
                                    }
                                    Rectangle().fill(Color.cfDivider).frame(width: 36, height: 0.5)
                                    Button {
                                        withAnimation(.spring()) {
                                            mapScale = max(mapScale - 0.3, 0.5)
                                            lastScale = mapScale
                                        }
                                    } label: {
                                        Image(systemName: "minus")
                                            .font(.system(size: 14, weight: .bold))
                                            .foregroundColor(.cfTextPrimary)
                                            .frame(width: 36, height: 36)
                                            .background(Color.white)
                                            .cornerRadius(10)
                                    }
                                }
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(color: .black.opacity(0.10), radius: 6, x: 0, y: 2)
                                .padding(12)

                                Button {
                                    withAnimation(.spring()) {
                                        mapScale = 1.0
                                        lastScale = 1.0
                                        mapOffset = .zero
                                        lastOffset = .zero
                                    }
                                } label: {
                                    Image(systemName: "arrow.up.left.and.arrow.down.right")
                                        .font(.system(size: 13, weight: .semibold))
                                        .foregroundColor(.cfTextPrimary)
                                        .frame(width: 36, height: 36)
                                        .background(Color.white)
                                        .cornerRadius(10)
                                        .shadow(color: .black.opacity(0.10), radius: 6, x: 0, y: 2)
                                }
                                .padding(.trailing, 12)
                                .padding(.bottom, 12)
                                .offset(y: -4)
                            }
                        }
                    }
                    .clipped()
                }
                .frame(maxHeight: .infinity)

                // ── Legend ───────────────────────────────────────────
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 14) {
                        ForEach(IndoorRoomType.allCases, id: \.self) { type in
                            HStack(spacing: 5) {
                                Text(type.icon).font(.system(size: 11))
                                Text(type.label)
                                    .font(.system(size: 11, weight: .medium))
                                    .foregroundColor(.cfTextSecondary)
                            }
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .background(type.accentColor.opacity(0.08))
                            .cornerRadius(20)
                            .overlay(RoundedRectangle(cornerRadius: 20)
                                .stroke(type.accentColor.opacity(0.25), lineWidth: 0.5))
                        }
                    }
                    .padding(.horizontal, 14)
                    .padding(.vertical, 10)
                }
                .background(Color.white)
                .overlay(Rectangle().fill(Color.cfDivider).frame(height: 0.5), alignment: .top)

                Spacer().frame(height: selectedRoom != nil ? 160 : 0)
            }

            // ── Room Detail Card ─────────────────────────────────────
            if let room = selectedRoom {
                IndoorRoomCard(room: room) {
                    withAnimation(.spring(response: 0.3)) { selectedRoom = nil }
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
                .padding(.horizontal, 14)
                .padding(.bottom, 12)
                .animation(.spring(response: 0.35), value: selectedRoom?.id)
            }
        }
        .navigationBarHidden(true)
        .ignoresSafeArea(edges: .bottom)
    }
}

// MARK: - Dot Grid Background
struct DotGridBackground: View {
    var body: some View {
        Canvas { context, size in
            let spacing: CGFloat = 22
            let dotSize: CGFloat = 1.5
            var x: CGFloat = 0
            while x < size.width {
                var y: CGFloat = 0
                while y < size.height {
                    let rect = CGRect(x: x, y: y, width: dotSize, height: dotSize)
                    context.fill(Path(ellipseIn: rect), with: .color(Color(red: 0.65, green: 0.70, blue: 0.80).opacity(0.45)))
                    y += spacing
                }
                x += spacing
            }
        }
    }
}

// MARK: - Floor Canvas
struct FloorCanvas: View {
    let rooms: [IndoorRoom]
    @Binding var selectedRoom: IndoorRoom?
    let showEntrance: Bool
    let floorColor: Color

    var body: some View {
        ZStack {
            // Outer building glow
            RoundedRectangle(cornerRadius: 24)
                .fill(floorColor.opacity(0.06))
                .frame(width: 560, height: 440)

            // Building shell
            RoundedRectangle(cornerRadius: 22)
                .fill(Color(red: 0.96, green: 0.97, blue: 0.99))
                .frame(width: 540, height: 420)
                .overlay(
                    RoundedRectangle(cornerRadius: 22)
                        .stroke(floorColor.opacity(0.25), lineWidth: 2)
                )
                .shadow(color: floorColor.opacity(0.08), radius: 12, x: 0, y: 4)

            // Dotted path lines (decorative)
            DottedPathLines(floorColor: floorColor)

            // Wing labels
            Text("NORTH WING")
                .font(.system(size: 7, weight: .black))
                .foregroundColor(floorColor.opacity(0.35))
                .kerning(2.5)
                .offset(y: -195)

            Text("SOUTH WING")
                .font(.system(size: 7, weight: .black))
                .foregroundColor(floorColor.opacity(0.35))
                .kerning(2.5)
                .offset(y: 195)

            Text("WEST")
                .font(.system(size: 7, weight: .black))
                .foregroundColor(floorColor.opacity(0.25))
                .kerning(2)
                .rotationEffect(.degrees(-90))
                .offset(x: -258, y: 0)

            Text("EAST")
                .font(.system(size: 7, weight: .black))
                .foregroundColor(floorColor.opacity(0.25))
                .kerning(2)
                .rotationEffect(.degrees(90))
                .offset(x: 258, y: 0)

            // Centre hub circle
            ZStack {
                Circle()
                    .fill(floorColor.opacity(0.10))
                    .frame(width: 64, height: 64)
                Circle()
                    .stroke(floorColor.opacity(0.20), lineWidth: 1.5)
                    .frame(width: 64, height: 64)
                Circle()
                    .fill(floorColor.opacity(0.15))
                    .frame(width: 40, height: 40)
                VStack(spacing: 1) {
                    Text("⬆⬇").font(.system(size: 10))
                    Text("LIFT").font(.system(size: 6, weight: .black))
                        .foregroundColor(floorColor)
                        .kerning(0.5)
                }
            }
            .offset(x: 180, y: 0)

            // Stairs pod
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(red: 0.93, green: 0.91, blue: 0.89))
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(red: 0.72, green: 0.70, blue: 0.67), lineWidth: 1))
                VStack(spacing: 1) {
                    Text("🪜").font(.system(size: 13))
                    Text("STAIRS").font(.system(size: 5, weight: .black))
                        .foregroundColor(Color(red: 0.42, green: 0.40, blue: 0.38))
                        .kerning(0.5)
                }
            }
            .frame(width: 52, height: 44)
            .offset(x: -200, y: 0)

            // Floor badge — top right corner
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(floorColor)
                    .frame(width: 36, height: 36)
                Text(showEntrance ? "G" : "F1")
                    .font(.system(size: 13, weight: .black))
                    .foregroundColor(.white)
            }
            .offset(x: 240, y: -185)

            // Rooms
            ForEach(rooms) { room in
                IndoorRoomCell(
                    room: room,
                    isSelected: selectedRoom?.id == room.id
                ) {
                    withAnimation(.spring(response: 0.25)) {
                        selectedRoom = (selectedRoom?.id == room.id) ? nil : room
                    }
                }
            }

            // Entrance & Exit (ground floor only)
            if showEntrance {
                // Entrance — bottom left
                HStack(spacing: 5) {
                    Image(systemName: "arrow.right.circle.fill")
                        .font(.system(size: 14))
                        .foregroundColor(.cfSuccess)
                    Text("ENTRANCE")
                        .font(.system(size: 7, weight: .black))
                        .foregroundColor(.cfSuccess)
                        .kerning(1.2)
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .background(Color.cfSuccess.opacity(0.10))
                .cornerRadius(20)
                .overlay(RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.cfSuccess.opacity(0.4), lineWidth: 1))
                .offset(x: -150, y: 196)

                // Exit — bottom right
                HStack(spacing: 5) {
                    Text("EXIT")
                        .font(.system(size: 7, weight: .black))
                        .foregroundColor(.cfDanger)
                        .kerning(1.2)
                    Image(systemName: "arrow.right.circle.fill")
                        .font(.system(size: 14))
                        .foregroundColor(.cfDanger)
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .background(Color.cfDanger.opacity(0.10))
                .cornerRadius(20)
                .overlay(RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.cfDanger.opacity(0.4), lineWidth: 1))
                .offset(x: 150, y: 196)
            }
        }
        .frame(width: 540, height: 420)
    }
}

// MARK: - Dotted Path Lines
struct DottedPathLines: View {
    let floorColor: Color

    var body: some View {
        Canvas { context, size in
            let cx = size.width / 2
            let cy = size.height / 2
            let color = GraphicsContext.Shading.color(floorColor.opacity(0.18))
            let dash: [CGFloat] = [4, 6]

            // Horizontal path
            var hPath = Path()
            hPath.move(to: CGPoint(x: 20, y: cy))
            hPath.addLine(to: CGPoint(x: size.width - 20, y: cy))
            context.stroke(hPath, with: color,
                           style: StrokeStyle(lineWidth: 1.5, dash: dash))

            // Vertical path
            var vPath = Path()
            vPath.move(to: CGPoint(x: cx, y: 20))
            vPath.addLine(to: CGPoint(x: cx, y: size.height - 20))
            context.stroke(vPath, with: color,
                           style: StrokeStyle(lineWidth: 1.5, dash: dash))

            // Diagonal accent lines
            var d1 = Path()
            d1.move(to: CGPoint(x: cx - 80, y: cy - 60))
            d1.addLine(to: CGPoint(x: cx + 80, y: cy - 60))
            context.stroke(d1, with: color,
                           style: StrokeStyle(lineWidth: 1, dash: dash))

            var d2 = Path()
            d2.move(to: CGPoint(x: cx - 80, y: cy + 60))
            d2.addLine(to: CGPoint(x: cx + 80, y: cy + 60))
            context.stroke(d2, with: color,
                           style: StrokeStyle(lineWidth: 1, dash: dash))
        }
        .frame(width: 540, height: 420)
    }
}
// MARK: - Indoor Room Cell
struct IndoorRoomCell: View {
    let room: IndoorRoom
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(room.type.bgColor)

                RoundedRectangle(cornerRadius: 10)
                    .stroke(
                        room.type.accentColor.opacity(isSelected ? 1.0 : 0.4),
                        lineWidth: isSelected ? 2.5 : 1.5
                    )

                if isSelected {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(room.type.accentColor.opacity(0.08))
                }

                VStack(spacing: 4) {
                    Text(room.type.icon)
                        .font(.system(size: room.size.width > 100 ? 18 : 13))
                    Text(room.name)
                        .font(.system(size: room.size.width > 100 ? 9 : 7, weight: .bold))
                        .foregroundColor(room.type.textColor)
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .padding(.horizontal, 3)
                }
            }
            .frame(width: room.size.width, height: room.size.height)
            .scaleEffect(isSelected ? 1.04 : 1.0)
            .shadow(
                color: isSelected ? room.type.accentColor.opacity(0.3) : .clear,
                radius: 8, x: 0, y: 2
            )
        }
        .offset(x: room.position.x, y: room.position.y)
        .zIndex(isSelected ? 10 : 1)
        .animation(.spring(response: 0.25), value: isSelected)
    }
}

// MARK: - Room Detail Card
struct IndoorRoomCard: View {
    let room: IndoorRoom
    let onClose: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            // Drag handle
            RoundedRectangle(cornerRadius: 3)
                .fill(Color.cfDivider)
                .frame(width: 36, height: 4)
                .padding(.top, 10)
                .padding(.bottom, 12)

            HStack(spacing: 14) {
                ZStack {
                    RoundedRectangle(cornerRadius: 14)
                        .fill(room.type.bgColor)
                        .frame(width: 52, height: 52)
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(room.type.accentColor.opacity(0.3), lineWidth: 1.5)
                        .frame(width: 52, height: 52)
                    Text(room.type.icon).font(.system(size: 24))
                }
                VStack(alignment: .leading, spacing: 3) {
                    Text(room.name)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.cfTextPrimary)
                    HStack(spacing: 4) {
                        Text(room.floorName)
                            .font(.system(size: 11, weight: .medium))
                            .foregroundColor(room.type.textColor)
                            .padding(.horizontal, 7)
                            .padding(.vertical, 2)
                            .background(room.type.bgColor)
                            .cornerRadius(6)
                        Text("·").foregroundColor(.cfTextTertiary)
                        Text(room.wing)
                            .font(.system(size: 11))
                            .foregroundColor(.cfTextSecondary)
                    }
                }
                Spacer()
                Button(action: onClose) {
                    Image(systemName: "xmark")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.cfTextSecondary)
                        .frame(width: 28, height: 28)
                        .background(Color.cfBg)
                        .clipShape(Circle())
                }
            }
            .padding(.horizontal, 16)

            Rectangle().fill(Color.cfDivider).frame(height: 0.5)
                .padding(.vertical, 14)
                .padding(.horizontal, 16)

            HStack(alignment: .top, spacing: 16) {
                VStack(alignment: .leading, spacing: 5) {
                    Label("Description", systemImage: "info.circle")
                        .font(.system(size: 10, weight: .semibold))
                        .foregroundColor(.cfTextTertiary)
                    Text(room.description)
                        .font(.system(size: 13))
                        .foregroundColor(.cfTextSecondary)
                }
                Spacer()
                VStack(alignment: .trailing, spacing: 5) {
                    Label("Hours", systemImage: "clock")
                        .font(.system(size: 10, weight: .semibold))
                        .foregroundColor(.cfTextTertiary)
                    Text(room.hours)
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(room.type.textColor)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(room.type.bgColor)
                        .cornerRadius(8)
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
        }
        .background(Color.white)
        .cornerRadius(24)
        .shadow(color: .black.opacity(0.12), radius: 20, x: 0, y: -4)
    }
}

// MARK: - Room Type (unchanged)
enum IndoorRoomType: CaseIterable {
    case reception, emergency, pharmacy, lab, doctor, theatre, ward, icu, xray, toilet
    var icon: String {
        switch self {
        case .reception: return "🛎"; case .emergency: return "🚨"
        case .pharmacy:  return "💊"; case .lab:       return "🧪"
        case .doctor:    return "🩺"; case .theatre:   return "⚕️"
        case .ward:      return "🛏"; case .icu:       return "❤️"
        case .xray:      return "🔬"; case .toilet:    return "🚻"
        }
    }
    var label: String {
        switch self {
        case .reception: return "Reception"; case .emergency: return "Emergency"
        case .pharmacy:  return "Pharmacy";  case .lab:       return "Laboratory"
        case .doctor:    return "Consulting"; case .theatre:  return "Theatre"
        case .ward:      return "Ward";       case .icu:      return "ICU"
        case .xray:      return "Radiology";  case .toilet:   return "Facilities"
        }
    }
    var accentColor: Color {
        switch self {
        case .reception: return Color(red: 0.73, green: 0.46, blue: 0.09)
        case .emergency: return Color(red: 0.89, green: 0.29, blue: 0.27)
        case .pharmacy:  return Color(red: 0.39, green: 0.60, blue: 0.13)
        case .lab:       return Color(red: 0.50, green: 0.47, blue: 0.87)
        case .doctor:    return Color(red: 0.22, green: 0.54, blue: 0.87)
        case .theatre:   return Color(red: 0.64, green: 0.17, blue: 0.17)
        case .ward:      return Color(red: 0.11, green: 0.62, blue: 0.46)
        case .icu:       return Color(red: 0.89, green: 0.29, blue: 0.27)
        case .xray:      return Color(red: 0.83, green: 0.33, blue: 0.49)
        case .toilet:    return Color(red: 0.53, green: 0.53, blue: 0.56)
        }
    }
    var bgColor: Color { accentColor.opacity(0.12) }
    var textColor: Color { accentColor }
}

// MARK: - Room Model (unchanged)
struct IndoorRoom: Identifiable {
    let id = UUID()
    let name: String
    let type: IndoorRoomType
    let position: CGPoint
    let size: CGSize
    let description: String
    let hours: String
    let floorName: String
    let wing: String
}

// MARK: - Room Data (unchanged)
let groundRooms: [IndoorRoom] = [
    IndoorRoom(name: "Main Reception", type: .reception, position: CGPoint(x: -175, y: -155), size: CGSize(width: 140, height: 80), description: "Patient registration & inquiries", hours: "24 hrs", floorName: "Ground floor", wing: "North wing"),
    IndoorRoom(name: "Emergency", type: .emergency, position: CGPoint(x: -20, y: -155), size: CGSize(width: 90, height: 80), description: "Trauma & urgent medical care", hours: "24 hrs", floorName: "Ground floor", wing: "North wing"),
    IndoorRoom(name: "Pharmacy", type: .pharmacy, position: CGPoint(x: 105, y: -155), size: CGSize(width: 120, height: 80), description: "Medications & prescriptions", hours: "7AM–10PM", floorName: "Ground floor", wing: "North wing"),
    IndoorRoom(name: "X-Ray / MRI", type: .xray, position: CGPoint(x: 220, y: -155), size: CGSize(width: 110, height: 80), description: "Radiology & imaging", hours: "8AM–6PM", floorName: "Ground floor", wing: "North wing"),
    IndoorRoom(name: "Laboratory", type: .lab, position: CGPoint(x: -175, y: 60), size: CGSize(width: 130, height: 90), description: "Blood tests & pathology", hours: "7AM–8PM", floorName: "Ground floor", wing: "South wing"),
    IndoorRoom(name: "Pharmacy 2", type: .pharmacy, position: CGPoint(x: -30, y: 60), size: CGSize(width: 110, height: 90), description: "Outpatient dispensary", hours: "8AM–9PM", floorName: "Ground floor", wing: "South wing"),
    IndoorRoom(name: "Consultation 1", type: .doctor, position: CGPoint(x: 95, y: 60), size: CGSize(width: 115, height: 90), description: "General physician – Room 101", hours: "8AM–5PM", floorName: "Ground floor", wing: "South wing"),
    IndoorRoom(name: "Consultation 2", type: .doctor, position: CGPoint(x: 222, y: 60), size: CGSize(width: 115, height: 90), description: "General physician – Room 102", hours: "8AM–5PM", floorName: "Ground floor", wing: "South wing"),
]

let firstRooms: [IndoorRoom] = [
    IndoorRoom(name: "Doctor Room 1", type: .doctor, position: CGPoint(x: -175, y: -155), size: CGSize(width: 130, height: 80), description: "Cardiology consultations", hours: "9AM–5PM", floorName: "1st floor", wing: "North wing"),
    IndoorRoom(name: "Doctor Room 2", type: .doctor, position: CGPoint(x: -30, y: -155), size: CGSize(width: 110, height: 80), description: "Neurology consultations", hours: "10AM–4PM", floorName: "1st floor", wing: "North wing"),
    IndoorRoom(name: "Doctor Room 3", type: .doctor, position: CGPoint(x: 100, y: -155), size: CGSize(width: 115, height: 80), description: "Orthopaedics", hours: "8AM–3PM", floorName: "1st floor", wing: "North wing"),
    IndoorRoom(name: "Doctor Room 4", type: .doctor, position: CGPoint(x: 225, y: -155), size: CGSize(width: 115, height: 80), description: "Paediatrics", hours: "8AM–5PM", floorName: "1st floor", wing: "North wing"),
    IndoorRoom(name: "Nurse Station", type: .ward, position: CGPoint(x: -175, y: 60), size: CGSize(width: 140, height: 90), description: "Central nursing & patient care", hours: "24 hrs", floorName: "1st floor", wing: "South wing"),
    IndoorRoom(name: "Ward A", type: .ward, position: CGPoint(x: -20, y: 60), size: CGSize(width: 90, height: 90), description: "General inpatient – 8 beds", hours: "24 hrs", floorName: "1st floor", wing: "South wing"),
    IndoorRoom(name: "Ward B", type: .ward, position: CGPoint(x: 90, y: 60), size: CGSize(width: 90, height: 90), description: "General inpatient – 8 beds", hours: "24 hrs", floorName: "1st floor", wing: "South wing"),
    IndoorRoom(name: "Waiting Lounge", type: .reception, position: CGPoint(x: 205, y: 60), size: CGSize(width: 140, height: 90), description: "Patient & visitor waiting area", hours: "24 hrs", floorName: "1st floor", wing: "South wing"),
]

let secondRooms: [IndoorRoom] = [
    IndoorRoom(name: "Theatre 1", type: .theatre, position: CGPoint(x: -175, y: -155), size: CGSize(width: 140, height: 80), description: "Main operating theatre", hours: "24 hrs", floorName: "2nd floor", wing: "North wing"),
    IndoorRoom(name: "Theatre 2", type: .theatre, position: CGPoint(x: -20, y: -155), size: CGSize(width: 100, height: 80), description: "Minor procedures", hours: "8AM–8PM", floorName: "2nd floor", wing: "North wing"),
    IndoorRoom(name: "Scrub Room", type: .theatre, position: CGPoint(x: 100, y: -155), size: CGSize(width: 110, height: 80), description: "Pre-op scrub & preparation", hours: "As required", floorName: "2nd floor", wing: "North wing"),
    IndoorRoom(name: "Anaesthesia", type: .theatre, position: CGPoint(x: 220, y: -155), size: CGSize(width: 120, height: 80), description: "Anaesthesia preparation room", hours: "As required", floorName: "2nd floor", wing: "North wing"),
    IndoorRoom(name: "ICU", type: .icu, position: CGPoint(x: -175, y: 60), size: CGSize(width: 140, height: 90), description: "Intensive care – 6 beds", hours: "24 hrs", floorName: "2nd floor", wing: "South wing"),
    IndoorRoom(name: "HDU", type: .icu, position: CGPoint(x: -20, y: 60), size: CGSize(width: 100, height: 90), description: "High dependency – 4 beds", hours: "24 hrs", floorName: "2nd floor", wing: "South wing"),
    IndoorRoom(name: "Recovery", type: .ward, position: CGPoint(x: 100, y: 60), size: CGSize(width: 115, height: 90), description: "Post-surgery recovery room", hours: "24 hrs", floorName: "2nd floor", wing: "South wing"),
    IndoorRoom(name: "Ward C", type: .ward, position: CGPoint(x: 225, y: 60), size: CGSize(width: 120, height: 90), description: "Surgical inpatient – 10 beds", hours: "24 hrs", floorName: "2nd floor", wing: "South wing"),
]
