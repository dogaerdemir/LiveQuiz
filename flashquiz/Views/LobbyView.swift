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
                .foregroundStyle(.secondary)

            Text("Oyuncular (\(viewModel.players.count)/\(viewModel.maxPlayers))")
                .font(.headline)

            List(viewModel.players) { player in
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(player.name)
                        Text(player.isReady ? "Hazır" : "Hazır değil")
                            .font(.caption)
                            .foregroundStyle(player.isReady ? .green : .orange)
                    }
                    Spacer()
                    if player.isHost {
                        Text("Oda sahibi")
                            .font(.caption)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.blue.opacity(0.15))
                            .clipShape(Capsule())
                    }
                }
            }
            .listStyle(.plain)

            Button(viewModel.isCurrentPlayerReady ? "Hazır Değilim" : "Hazırım") {
                viewModel.toggleReady()
            }
            .buttonStyle(.bordered)

            Text("Hazır Oyuncular: \(viewModel.readyPlayersCount)/\(viewModel.players.count)")
                .font(.footnote)
                .foregroundStyle(.secondary)

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
                        .foregroundStyle(.secondary)
                } else if !viewModel.allPlayersReady {
                    Text("Oyunu başlatmak için tüm oyuncular hazır olmalı.")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
            } else {
                Text("Oda sahibi oyunu başlatınca sorular otomatik başlayacak.")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }

            Button("Odadan Çık") {
                viewModel.leaveRoom()
            }
            .buttonStyle(.bordered)

            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundStyle(.red)
                    .font(.footnote)
                    .multilineTextAlignment(.center)
            }
        }
        .padding()
    }
}
