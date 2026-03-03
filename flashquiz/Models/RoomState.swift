//
//  RoomState.swift
//  flashquiz
//

import Foundation

#if canImport(FirebaseFirestore)
import FirebaseFirestore
#endif

struct RoomState: Identifiable, Hashable {
    let id: String
    let code: String
    let hostId: String
    let phase: RoomPhase
    let questionDuration: Int
    let questionCount: Int
    let selectedCategory: QuestionCategory
    let maxPlayers: Int
    let playerCount: Int
    let currentQuestionIndex: Int
    let currentQuestionStartedAt: Date?
    let currentAnswers: [String: Int]
    let answerLog: [String: [String: Int]]
    let questions: [QuizQuestion]

    var currentQuestion: QuizQuestion? {
        guard questions.indices.contains(currentQuestionIndex) else {
            return nil
        }

        return questions[currentQuestionIndex]
    }

    init?(
        id: String,
        dictionary: [String: Any]
    ) {
        guard
            let code = dictionary["code"] as? String,
            let hostId = dictionary["hostId"] as? String,
            let phaseRaw = dictionary["phase"] as? String,
            let phase = RoomPhase(rawValue: phaseRaw),
            let questionDuration = dictionary["questionDuration"] as? Int,
            let currentQuestionIndex = dictionary["currentQuestionIndex"] as? Int,
            let questionDictionaries = dictionary["questions"] as? [[String: Any]]
        else {
            return nil
        }

        let parsedQuestions = questionDictionaries.compactMap { QuizQuestion(dictionary: $0) }
        guard !parsedQuestions.isEmpty else {
            return nil
        }

        self.id = id
        self.code = code
        self.hostId = hostId
        self.phase = phase
        self.questionDuration = questionDuration
        self.questionCount = dictionary["questionCount"] as? Int ?? QuestionBank.defaultRoundQuestionCount
        self.selectedCategory = QuestionCategory(rawValue: dictionary["selectedCategory"] as? String ?? "") ?? .all
        self.maxPlayers = dictionary["maxPlayers"] as? Int ?? 10
        self.playerCount = dictionary["playerCount"] as? Int ?? 0
        self.currentQuestionIndex = currentQuestionIndex
        self.questions = parsedQuestions

        if let rawAnswers = dictionary["currentAnswers"] as? [String: Any] {
            var parsedAnswers: [String: Int] = [:]
            for (playerId, answerValue) in rawAnswers {
                if let intValue = answerValue as? Int {
                    parsedAnswers[playerId] = intValue
                }
            }
            self.currentAnswers = parsedAnswers
        } else {
            self.currentAnswers = [:]
        }

        if let rawAnswerLog = dictionary["answerLog"] as? [String: Any] {
            var parsedLog: [String: [String: Int]] = [:]
            for (questionId, perPlayerRaw) in rawAnswerLog {
                guard let perPlayerRaw = perPlayerRaw as? [String: Any] else {
                    continue
                }

                var perPlayerParsed: [String: Int] = [:]
                for (playerId, answerValue) in perPlayerRaw {
                    if let intValue = answerValue as? Int {
                        perPlayerParsed[playerId] = intValue
                    }
                }
                parsedLog[questionId] = perPlayerParsed
            }
            self.answerLog = parsedLog
        } else {
            self.answerLog = [:]
        }

        self.currentQuestionStartedAt = RoomState.parseDate(from: dictionary["currentQuestionStartedAt"])
    }

    private static func parseDate(from rawValue: Any?) -> Date? {
        #if canImport(FirebaseFirestore)
        if let timestamp = rawValue as? Timestamp {
            return timestamp.dateValue()
        }
        #endif

        return rawValue as? Date
    }
}
