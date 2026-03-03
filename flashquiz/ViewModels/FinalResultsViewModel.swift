//
//  FinalResultsViewModel.swift
//  flashquiz
//

import Foundation
import Combine

struct PlayerGameStats: Identifiable {
    let id: String
    let playerName: String
    let correctCount: Int
    let wrongCount: Int
    let timeoutCount: Int
    let score: Int
}

@MainActor
final class FinalResultsViewModel: ObservableObject {
    @Published var isRestarting: Bool = false
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

    var totalQuestionCount: Int {
        session.room?.questions.count ?? 0
    }

    var statsRows: [PlayerGameStats] {
        guard let room = session.room else {
            return []
        }

        var rows: [PlayerGameStats] = []

        for player in session.players {
            var correctCount = 0
            var wrongCount = 0
            var timeoutCount = 0
            var score = 0

            for question in room.questions {
                let maybeAnswer = room.answerLog[question.id]?[player.id]

                let points = GameScoring.points(
                    for: maybeAnswer,
                    correctOptionIndex: question.correctOptionIndex
                )
                score += points

                switch points {
                case GameScoring.correctPoints:
                    correctCount += 1
                case GameScoring.wrongPoints:
                    wrongCount += 1
                default:
                    timeoutCount += 1
                }
            }

            rows.append(
                PlayerGameStats(
                    id: player.id,
                    playerName: player.name,
                    correctCount: correctCount,
                    wrongCount: wrongCount,
                    timeoutCount: timeoutCount,
                    score: score
                )
            )
        }

        return rows.sorted {
            if $0.score != $1.score {
                return $0.score > $1.score
            }

            if $0.correctCount != $1.correctCount {
                return $0.correctCount > $1.correctCount
            }

            return $0.playerName.localizedCaseInsensitiveCompare($1.playerName) == .orderedAscending
        }
    }

    func playAgain() {
        guard isHost else { return }
        guard let roomCode = session.roomCode else { return }

        errorMessage = nil
        isRestarting = true

        network.restartGame(roomCode: roomCode) { [weak self] error in
            guard let self else { return }
            Task { @MainActor in
                self.isRestarting = false
                if let error {
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func exitRoom() {
        session.leaveRoomAndReset()
    }
}
