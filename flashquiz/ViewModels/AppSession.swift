//
//  AppSession.swift
//  flashquiz
//

import Foundation
import Combine

@MainActor
final class AppSession: ObservableObject {
    @Published private(set) var roomCode: String?
    @Published private(set) var currentPlayer: Player?
    @Published private(set) var room: RoomState?
    @Published private(set) var players: [Player] = []
    @Published private(set) var chatMessages: [ChatMessage] = []
    @Published var globalErrorMessage: String?

    private let network: NetworkLayer
    private var roomListenerToken: NetworkListenerToken?
    private var playersListenerToken: NetworkListenerToken?
    private var chatListenerToken: NetworkListenerToken?

    init(network: NetworkLayer) {
        self.network = network
    }

    var isHost: Bool {
        guard let currentPlayer else { return false }
        return currentPlayer.id == room?.hostId || currentPlayer.isHost
    }

    func enterRoom(roomCode: String, player: Player) {
        self.roomCode = roomCode.uppercased()
        self.currentPlayer = player
        startListening()
    }

    func leaveRoomAndReset() {
        let currentRoomCode = roomCode
        let currentPlayerId = currentPlayer?.id

        stopListening()
        room = nil
        players = []
        chatMessages = []
        roomCode = nil
        currentPlayer = nil

        guard let currentRoomCode, let currentPlayerId else {
            return
        }

        network.leaveRoom(roomCode: currentRoomCode, playerId: currentPlayerId)
    }

    private func startListening() {
        stopListening()

        guard let roomCode else {
            return
        }

        roomListenerToken = network.observeRoom(roomCode: roomCode) { [weak self] result in
            guard let self else { return }
            Task { @MainActor in
                switch result {
                case .success(let roomState):
                    self.room = roomState
                case .failure(let error):
                    self.globalErrorMessage = error.localizedDescription
                }
            }
        }

        playersListenerToken = network.observePlayers(roomCode: roomCode) { [weak self] result in
            guard let self else { return }
            Task { @MainActor in
                switch result {
                case .success(let players):
                    self.players = players
                case .failure(let error):
                    self.globalErrorMessage = error.localizedDescription
                }
            }
        }

        chatListenerToken = network.observeChatMessages(roomCode: roomCode) { [weak self] result in
            guard let self else { return }
            Task { @MainActor in
                switch result {
                case .success(let messages):
                    self.chatMessages = messages
                case .failure(let error):
                    self.globalErrorMessage = error.localizedDescription
                }
            }
        }
    }

    private func stopListening() {
        roomListenerToken?.cancel()
        playersListenerToken?.cancel()
        chatListenerToken?.cancel()
        roomListenerToken = nil
        playersListenerToken = nil
        chatListenerToken = nil
    }

    func sendChatMessage(_ text: String, completion: ((Error?) -> Void)? = nil) {
        guard let roomCode, let player = currentPlayer else {
            completion?(NetworkLayerError.invalidRoomData)
            return
        }

        network.sendChatMessage(
            roomCode: roomCode,
            playerId: player.id,
            playerName: player.name,
            text: text
        ) { [weak self] error in
            Task { @MainActor in
                if let error {
                    self?.globalErrorMessage = error.localizedDescription
                }
                completion?(error)
            }
        }
    }
}
