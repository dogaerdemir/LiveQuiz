//
//  LobbyViewModel.swift
//  flashquiz
//

import Foundation
import Combine

@MainActor
final class LobbyViewModel: ObservableObject {
    @Published var isStarting: Bool = false
    @Published var errorMessage: String?

    private let session: AppSession
    private let network: NetworkLayer

    init(session: AppSession, network: NetworkLayer) {
        self.session = session
        self.network = network
    }

    var roomCode: String {
        session.roomCode ?? "-"
    }

    var players: [Player] {
        session.players
    }

    var selectedCategoryTitle: String {
        session.room?.selectedCategory.title ?? QuestionCategory.all.title
    }

    var maxPlayers: Int {
        session.room?.maxPlayers ?? 10
    }

    var hasMinimumPlayers: Bool {
        players.count >= 2
    }

    var readyPlayersCount: Int {
        players.filter(\.isReady).count
    }

    var allPlayersReady: Bool {
        hasMinimumPlayers && players.allSatisfy(\.isReady)
    }

    var isCurrentPlayerReady: Bool {
        guard let currentPlayerId = session.currentPlayer?.id else { return false }
        return players.first(where: { $0.id == currentPlayerId })?.isReady ?? false
    }

    var canStart: Bool {
        session.isHost && allPlayersReady
    }

    var isHost: Bool {
        session.isHost
    }

    func startGame() {
        guard let roomCode = session.roomCode else { return }
        guard canStart else { return }

        isStarting = true
        errorMessage = nil
        network.startGame(roomCode: roomCode) { [weak self] error in
            guard let self else { return }
            Task { @MainActor in
                self.isStarting = false
                if let error {
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func leaveRoom() {
        session.leaveRoomAndReset()
    }

    func toggleReady() {
        guard let roomCode = session.roomCode, let playerId = session.currentPlayer?.id else { return }
        errorMessage = nil

        network.setPlayerReady(
            roomCode: roomCode,
            playerId: playerId,
            isReady: !isCurrentPlayerReady
        ) { [weak self] error in
            guard let self else { return }
            Task { @MainActor in
                if let error {
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
