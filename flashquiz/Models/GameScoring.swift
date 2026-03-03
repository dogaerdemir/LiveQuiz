//
//  GameScoring.swift
//  flashquiz
//

import Foundation

enum GameScoring {
    static let correctPoints = 10
    static let wrongPoints = -5
    static let timeoutPoints = -10

    static func points(for answer: Int?, correctOptionIndex: Int) -> Int {
        guard let answer else { return timeoutPoints }
        if answer < 0 { return timeoutPoints }
        return answer == correctOptionIndex ? correctPoints : wrongPoints
    }

    static func score(
        room: RoomState,
        playerId: String,
        includeUnrevealedAsTimeout: Bool = false
    ) -> Int {
        var total = 0

        for question in room.questions {
            guard let perQuestionAnswers = room.answerLog[question.id] else {
                if includeUnrevealedAsTimeout {
                    total += timeoutPoints
                }
                continue
            }

            total += points(
                for: perQuestionAnswers[playerId],
                correctOptionIndex: question.correctOptionIndex
            )
        }

        return total
    }
}
