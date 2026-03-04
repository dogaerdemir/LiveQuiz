//
//  ResultsViewModel.swift
//  flashquiz
//

import Foundation
import Combine

struct RankedPlayerResult: Identifiable {
    let id: String
    let rank: Int
    let player: Player
    let score: Int
}

@MainActor
final class ResultsViewModel: ObservableObject {
    @Published var isAdvancing: Bool = false
    @Published var errorMessage: String?

    private let session: AppSession
    private let network: NetworkLayer

    init(session: AppSession, network: NetworkLayer) {
        self.session = session
        self.network = network
    }

    var isHost: Bool {
        session.isHost
    }

    var isLastQuestion: Bool {
        guard let room = session.room else { return true }
        return room.currentQuestionIndex >= (room.questions.count - 1)
    }

    var rankedPlayers: [RankedPlayerResult] {
        let scoreByPlayerId = Dictionary(
            uniqueKeysWithValues: session.players.map { player in
                (player.id, scoreForPlayer(player))
            }
        )

        let sortedPlayers = session.players.sorted { lhs, rhs in
            let lhsScore = scoreByPlayerId[lhs.id] ?? 0
            let rhsScore = scoreByPlayerId[rhs.id] ?? 0

            if lhsScore != rhsScore {
                return lhsScore > rhsScore
            }

            return lhs.name.localizedCaseInsensitiveCompare(rhs.name) == .orderedAscending
        }

        return sortedPlayers.enumerated().map { index, player in
            RankedPlayerResult(
                id: player.id,
                rank: index + 1,
                player: player,
                score: scoreByPlayerId[player.id] ?? 0
            )
        }
    }

    func scoreForPlayer(_ player: Player) -> Int {
        guard let room = session.room else { return 0 }
        return GameScoring.score(room: room, playerId: player.id)
    }

    func labelForSelection(of player: Player) -> String {
        guard let room = session.room, let question = room.currentQuestion else {
            return "Veri yok"
        }

        guard let answerIndex = room.currentAnswers[player.id] else {
            return "Cevaplamadı"
        }

        if answerIndex < 0 {
            return "Süre bitti"
        }

        guard question.options.indices.contains(answerIndex) else {
            return "Geçersiz şık"
        }

        let option = question.options[answerIndex]
        return "\(OptionLabel.prefixed(answerIndex)) \(option)"
    }

    func isCorrectSelection(of player: Player) -> Bool {
        guard
            let room = session.room,
            let question = room.currentQuestion,
            let answerIndex = room.currentAnswers[player.id]
        else {
            return false
        }

        guard answerIndex >= 0 else {
            return false
        }

        return answerIndex == question.correctOptionIndex
    }

    func isWrongSelection(of player: Player) -> Bool {
        guard
            let room = session.room,
            let question = room.currentQuestion,
            let answerIndex = room.currentAnswers[player.id]
        else {
            return false
        }

        guard answerIndex >= 0 else {
            return false
        }

        return answerIndex != question.correctOptionIndex
    }

    func moveToNextQuestion() {
        guard let roomCode = session.roomCode else { return }

        isAdvancing = true
        errorMessage = nil
        network.moveToNextQuestion(roomCode: roomCode) { [weak self] error in
            guard let self else { return }
            Task { @MainActor in
                self.isAdvancing = false
                if let error {
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func leaveRoom() {
        session.leaveRoomAndReset()
    }
}
