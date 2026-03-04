//
//  QuestionViewModel.swift
//  flashquiz
//

import Foundation
import Combine

@MainActor
final class QuestionViewModel: ObservableObject {
    @Published var selectedOptionIndex: Int?
    @Published var hasSubmitted: Bool = false
    @Published var remainingSeconds: Int = 20
    @Published var isSubmitting: Bool = false
    @Published var errorMessage: String?

    private let session: AppSession
    private let network: NetworkLayer

    private var timer: Timer?
    private var lastSeenQuestionIndex: Int = -1
    private var lastAutoRevealQuestionIndex: Int = -1

    init(session: AppSession, network: NetworkLayer) {
        self.session = session
        self.network = network
    }

    func onAppear() {
        syncFromSession()
        startTimer()
    }

    func onDisappear() {
        timer?.invalidate()
        timer = nil
    }

    func onRoomOrPlayersChanged() {
        syncFromSession()
        evaluateAutoReveal()
    }

    func selectOption(_ index: Int) {
        guard !hasSubmitted else { return }
        selectedOptionIndex = index
    }

    func submitAnswer() {
        guard !hasSubmitted else { return }
        guard let selectedOptionIndex else {
            errorMessage = "Lütfen bir şık seç."
            return
        }
        guard let roomCode = session.roomCode, let playerId = session.currentPlayer?.id else { return }

        errorMessage = nil
        isSubmitting = true
        network.submitAnswer(
            roomCode: roomCode,
            playerId: playerId,
            selectedOptionIndex: selectedOptionIndex
        ) { [weak self] error in
            guard let self else { return }
            Task { @MainActor in
                self.isSubmitting = false
                if let error {
                    self.errorMessage = error.localizedDescription
                    return
                }

                self.hasSubmitted = true
            }
        }
    }

    private func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            DispatchQueue.main.async {
                self?.onRoomOrPlayersChanged()
            }
        }
    }

    private func syncFromSession() {
        guard let room = session.room else { return }

        if room.currentQuestionIndex != lastSeenQuestionIndex {
            lastSeenQuestionIndex = room.currentQuestionIndex
            selectedOptionIndex = nil
            hasSubmitted = false
        }

        if let playerId = session.currentPlayer?.id, let submittedAnswer = room.currentAnswers[playerId] {
            selectedOptionIndex = submittedAnswer
            hasSubmitted = true
        }

        updateRemainingSeconds()
    }

    private func updateRemainingSeconds() {
        guard let room = session.room else { return }
        guard let startDate = room.currentQuestionStartedAt else {
            remainingSeconds = room.questionDuration
            return
        }

        let elapsed = max(0, Int(Date().timeIntervalSince(startDate)))
        remainingSeconds = max(0, room.questionDuration - elapsed)
    }

    private func evaluateAutoReveal() {
        guard session.isHost else { return }
        guard let room = session.room, room.phase == .question else { return }
        guard let roomCode = session.roomCode else { return }

        let allAnswered = !session.players.isEmpty && room.currentAnswers.count >= session.players.count
        let timedOut = remainingSeconds <= 0
        guard allAnswered || timedOut else { return }

        guard room.currentQuestionIndex != lastAutoRevealQuestionIndex else { return }
        lastAutoRevealQuestionIndex = room.currentQuestionIndex

        network.revealResults(roomCode: roomCode) { [weak self] error in
            guard let self else { return }
            Task { @MainActor in
                if let error {
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
