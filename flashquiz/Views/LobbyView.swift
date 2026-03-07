//
//  LobbyView.swift
//  flashquiz
//

import SwiftUI

struct LobbyView: View {
    @ObservedObject var session: AppSession
    @StateObject private var viewModel: LobbyViewModel

    init(session: AppSession, network: NetworkLayer) {
        self.session = session
        _viewModel = StateObject(wrappedValue: LobbyViewModel(session: session, network: network))
    }

    var body: some View {
        VStack(spacing: 16) {
            Text("Oda: \(viewModel.roomCode)")
                .font(.title2.bold())

            Text("Kategori: \(viewModel.selectedCategoryTitle)")
                .font(.footnote)
                .foregroundStyle(.appTextSecondary)

            Text("Oyuncular (\(viewModel.players.count)/\(viewModel.maxPlayers))")
                .font(.headline)

            List(viewModel.players) { player in
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(player.name)
                            .foregroundStyle(.appTextPrimary)
                        Text(player.isReady ? "Hazır" : "Hazır değil")
                            .font(.caption)
                            .foregroundStyle(player.isReady ? .appSuccess : .appWarning)
                    }
                    Spacer()
                    if player.isHost {
                        Text("Oda sahibi")
                            .font(.caption)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.appAccent.opacity(0.2))
                            .clipShape(Capsule())
                    }
                }
                .listRowBackground(Color.appSurface)
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .frame(height: 220)

            ChatPanelView(session: session, title: "Sohbet", height: 140)

            Button(viewModel.isCurrentPlayerReady ? "Hazır Değilim" : "Hazırım") {
                viewModel.toggleReady()
            }
            .buttonStyle(.bordered)

            Text("Hazır Oyuncular: \(viewModel.readyPlayersCount)/\(viewModel.players.count)")
                .font(.footnote)
                .foregroundStyle(.appTextSecondary)

            if viewModel.isHost {
                Button {
                    viewModel.startGame()
                } label: {
                    Text("Oyunu Başlat")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .disabled(!viewModel.canStart || viewModel.isStarting)

                if !viewModel.hasMinimumPlayers {
                    Text("Başlamak için en az 2 oyuncu gerekli.")
                        .font(.footnote)
                        .foregroundStyle(.appTextSecondary)
                } else if !viewModel.allPlayersReady {
                    Text("Oyunu başlatmak için tüm oyuncular hazır olmalı.")
                        .font(.footnote)
                        .foregroundStyle(.appTextSecondary)
                }
            } else {
                Text("Oda sahibi oyunu başlatınca sorular otomatik başlayacak.")
                    .font(.footnote)
                    .foregroundStyle(.appTextSecondary)
                    .multilineTextAlignment(.center)
            }

            Button("Odadan Çık") {
                viewModel.leaveRoom()
            }
            .buttonStyle(.bordered)

            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundStyle(.appDanger)
                    .font(.footnote)
                    .multilineTextAlignment(.center)
            }
        }
        .padding()
        .background(Color.appBackground.ignoresSafeArea())
        .dismissKeyboardOnTap()
    }
}
