//
//  ContentView.swift
//  flashquiz
//
//  Created by Doğa Erdemir on 2.03.2026.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var session: AppSession
    @StateObject private var homeViewModel: HomeViewModel

    init() {
        let session = AppSession(network: .shared)
        _session = StateObject(wrappedValue: session)
        _homeViewModel = StateObject(wrappedValue: HomeViewModel(session: session, network: .shared))
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            Color.appBackground
                .ignoresSafeArea()

            if session.roomCode == nil {
                HomeView(viewModel: homeViewModel)
            } else {
                RoomFlowView(session: session)
            }

            if let error = session.globalErrorMessage {
                Text(error)
                    .font(.footnote)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(Color.appDanger.opacity(0.9))
                    .clipShape(Capsule())
                    .padding(.bottom, 12)
            }
        }
        .tint(.appAccent)
        .dismissKeyboardOnTap()
    }
}

#Preview {
    ContentView()
}

private struct RoomFlowView: View {
    @ObservedObject var session: AppSession

    var body: some View {
        Group {
            if let room = session.room {
                switch room.phase {
                case .waiting:
                    LobbyView(session: session, network: .shared)
                case .question:
                    QuestionView(session: session, network: .shared)
                case .results:
                    ResultsView(session: session, network: .shared)
                case .finished:
                    FinishedView(session: session, network: .shared)
                }
            } else {
                VStack(spacing: 12) {
                    ProgressView()
                    Text("Oda bilgisi yükleniyor...")
                        .font(.footnote)
                        .foregroundStyle(.appTextSecondary)
                }
            }
        }
    }
}
