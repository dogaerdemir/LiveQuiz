//
//  HomeViewModel.swift
//  flashquiz
//

import Foundation
import Combine

enum HomeMode: String, CaseIterable, Identifiable {
    case create
    case join

    var id: String { rawValue }

    var title: String {
        switch self {
        case .create:
            return "Oda Kur"
        case .join:
            return "Odaya Katıl"
        }
    }
}

@MainActor
final class HomeViewModel: ObservableObject {
    let questionCountOptions: [Int] = [5, 10, 15, 20]
    let categoryOptions: [QuestionCategory] = QuestionCategory.allCases

    @Published var mode: HomeMode = .create
    @Published var playerName: String = ""
    @Published var selectedQuestionCount: Int = 10
    @Published var selectedCategory: QuestionCategory = .all
    @Published var roomCodeInput: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let session: AppSession
    private let network: NetworkLayer

    init(session: AppSession, network: NetworkLayer) {
        self.session = session
        self.network = network
    }

    func createRoom() {
        errorMessage = nil
        let trimmedName = playerName.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedName.isEmpty else {
            errorMessage = "Lütfen bir kullanıcı adı gir."
            return
        }

        isLoading = true
        network.createRoom(
            hostName: trimmedName,
            questionCount: selectedQuestionCount,
            selectedCategory: selectedCategory
        ) { [weak self] result in
            guard let self else { return }
            Task { @MainActor in
                self.isLoading = false
                switch result {
                case .success(let payload):
                    self.session.enterRoom(roomCode: payload.roomCode, player: payload.player)
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func joinRoom() {
        errorMessage = nil
        let trimmedName = playerName.trimmingCharacters(in: .whitespacesAndNewlines)
        let normalizedCode = roomCodeInput.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        guard !trimmedName.isEmpty else {
            errorMessage = "Lütfen bir kullanıcı adı gir."
            return
        }

        guard normalizedCode.count >= 4 else {
            errorMessage = "Geçerli bir oda kodu gir."
            return
        }

        isLoading = true
        network.joinRoom(roomCode: normalizedCode, playerName: trimmedName) { [weak self] result in
            guard let self else { return }
            Task { @MainActor in
                self.isLoading = false
                switch result {
                case .success(let player):
                    self.session.enterRoom(roomCode: normalizedCode, player: player)
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
