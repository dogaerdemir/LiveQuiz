//
//  NetworkLayer.swift
//  flashquiz
//

import Foundation

#if canImport(FirebaseFirestore)
import FirebaseFirestore
#endif

final class NetworkListenerToken {
    private let cancelClosure: () -> Void

    init(cancelClosure: @escaping () -> Void) {
        self.cancelClosure = cancelClosure
    }

    func cancel() {
        cancelClosure()
    }
}

enum NetworkLayerError: LocalizedError {
    case firebaseNotConfigured
    case unableToGenerateRoomCode
    case roomNotFound
    case roomAlreadyStarted
    case roomIsFull
    case notEnoughPlayers
    case playersNotReady
    case invalidRoomData
    case noQuestionLeft
    case noPlayersInRoom

    var errorDescription: String? {
        switch self {
        case .firebaseNotConfigured:
            return "Firebase bağımlılıkları henüz projeye eklenmemiş."
        case .unableToGenerateRoomCode:
            return "Uygun oda kodu üretilemedi. Tekrar deneyin."
        case .roomNotFound:
            return "Oda bulunamadı. Kodu kontrol edin."
        case .roomAlreadyStarted:
            return "Oyun başladı. Bu odaya artık katılım kapalı."
        case .roomIsFull:
            return "Oda dolu. En fazla 10 oyuncu katılabilir."
        case .notEnoughPlayers:
            return "Başlamak için en az 2 oyuncu gerekli."
        case .playersNotReady:
            return "Oyunu başlatmak için tüm oyuncular hazır olmalı."
        case .invalidRoomData:
            return "Oda verisi geçersiz veya eksik."
        case .noQuestionLeft:
            return "Soru kalmadı."
        case .noPlayersInRoom:
            return "Odada oyuncu bulunamadı."
        }
    }
}

final class NetworkLayer {
    static let shared = NetworkLayer()
    private static let defaultMaxPlayers = 10
    private static let defaultQuestionDuration = 20

    #if canImport(FirebaseFirestore)
    private let db = Firestore.firestore()
    #endif

    private init() {}

    func createRoom(
        hostName: String,
        questionCount: Int,
        selectedCategory: QuestionCategory,
        completion: @escaping (Result<(roomCode: String, player: Player), Error>) -> Void
    ) {
        #if canImport(FirebaseFirestore)
        createRoomAttempt(
            hostName: hostName,
            questionCount: questionCount,
            selectedCategory: selectedCategory,
            attemptsLeft: 8,
            completion: completion
        )
        #else
        completion(.failure(NetworkLayerError.firebaseNotConfigured))
        #endif
    }

    func joinRoom(
        roomCode: String,
        playerName: String,
        completion: @escaping (Result<Player, Error>) -> Void
    ) {
        #if canImport(FirebaseFirestore)
        let normalizedCode = roomCode.uppercased()
        let roomRef = db.collection("rooms").document(normalizedCode)
        let player = Player(
            id: UUID().uuidString,
            name: playerName,
            isHost: false,
            isReady: false,
            joinedAt: Date()
        )

        db.runTransaction({ transaction, errorPointer in
            let snapshot: DocumentSnapshot

            do {
                try snapshot = transaction.getDocument(roomRef)
            } catch let readError as NSError {
                errorPointer?.pointee = readError
                return nil
            }

            guard
                snapshot.exists,
                let data = snapshot.data(),
                let room = RoomState(id: snapshot.documentID, dictionary: data)
            else {
                errorPointer?.pointee = Self.nsError(for: .roomNotFound)
                return nil
            }

            guard room.phase == .waiting else {
                errorPointer?.pointee = Self.nsError(for: .roomAlreadyStarted)
                return nil
            }

            let currentPlayerCount = data["playerCount"] as? Int ?? 0
            let maxPlayers = data["maxPlayers"] as? Int ?? Self.defaultMaxPlayers

            guard currentPlayerCount < maxPlayers else {
                errorPointer?.pointee = Self.nsError(for: .roomIsFull)
                return nil
            }

            let playerRef = roomRef.collection("players").document(player.id)
            transaction.setData([
                "name": player.name,
                "isHost": false,
                "isReady": false,
                "joinedAt": FieldValue.serverTimestamp()
            ], forDocument: playerRef)

            transaction.updateData([
                "playerCount": currentPlayerCount + 1
            ], forDocument: roomRef)

            return nil
        }) { _, error in
            if let error {
                completion(.failure(error))
                return
            }

            completion(.success(player))
        }
        #else
        completion(.failure(NetworkLayerError.firebaseNotConfigured))
        #endif
    }

    func observeRoom(
        roomCode: String,
        onChange: @escaping (Result<RoomState, Error>) -> Void
    ) -> NetworkListenerToken {
        #if canImport(FirebaseFirestore)
        let listener = db.collection("rooms")
            .document(roomCode.uppercased())
            .addSnapshotListener { snapshot, error in
                if let error {
                    onChange(.failure(error))
                    return
                }

                guard
                    let snapshot,
                    snapshot.exists,
                    let data = snapshot.data(),
                    let room = RoomState(id: snapshot.documentID, dictionary: data)
                else {
                    onChange(.failure(NetworkLayerError.invalidRoomData))
                    return
                }

                onChange(.success(room))
            }

        return NetworkListenerToken(cancelClosure: {
            listener.remove()
        })
        #else
        onChange(.failure(NetworkLayerError.firebaseNotConfigured))
        return NetworkListenerToken(cancelClosure: {})
        #endif
    }

    func observePlayers(
        roomCode: String,
        onChange: @escaping (Result<[Player], Error>) -> Void
    ) -> NetworkListenerToken {
        #if canImport(FirebaseFirestore)
        let listener = db.collection("rooms")
            .document(roomCode.uppercased())
            .collection("players")
            .order(by: "joinedAt")
            .addSnapshotListener { snapshot, error in
                if let error {
                    onChange(.failure(error))
                    return
                }

                guard let snapshot else {
                    onChange(.success([]))
                    return
                }

                let players = snapshot.documents.compactMap { document in
                    Player(id: document.documentID, dictionary: document.data())
                }
                onChange(.success(players))
            }

        return NetworkListenerToken(cancelClosure: {
            listener.remove()
        })
        #else
        onChange(.failure(NetworkLayerError.firebaseNotConfigured))
        return NetworkListenerToken(cancelClosure: {})
        #endif
    }

    func startGame(roomCode: String, completion: @escaping (Error?) -> Void) {
        #if canImport(FirebaseFirestore)
        let roomRef = db.collection("rooms").document(roomCode.uppercased())

        roomRef.collection("players").getDocuments { snapshot, error in
            if let error {
                completion(error)
                return
            }

            guard let snapshot else {
                completion(NetworkLayerError.noPlayersInRoom)
                return
            }

            let players = snapshot.documents.compactMap {
                Player(id: $0.documentID, dictionary: $0.data())
            }

            guard players.count >= 2 else {
                completion(NetworkLayerError.notEnoughPlayers)
                return
            }

            guard players.allSatisfy(\.isReady) else {
                completion(NetworkLayerError.playersNotReady)
                return
            }

            roomRef.updateData([
                "phase": RoomPhase.question.rawValue,
                "currentQuestionIndex": 0,
                "currentQuestionStartedAt": FieldValue.serverTimestamp(),
                "currentAnswers": [:],
                "answerLog": [:]
            ], completion: completion)
        }
        #else
        completion(NetworkLayerError.firebaseNotConfigured)
        #endif
    }

    func setPlayerReady(
        roomCode: String,
        playerId: String,
        isReady: Bool,
        completion: @escaping (Error?) -> Void
    ) {
        #if canImport(FirebaseFirestore)
        db.collection("rooms")
            .document(roomCode.uppercased())
            .collection("players")
            .document(playerId)
            .updateData(["isReady": isReady], completion: completion)
        #else
        completion(NetworkLayerError.firebaseNotConfigured)
        #endif
    }

    func submitAnswer(
        roomCode: String,
        playerId: String,
        selectedOptionIndex: Int,
        completion: @escaping (Error?) -> Void
    ) {
        #if canImport(FirebaseFirestore)
        let roomRef = db.collection("rooms").document(roomCode.uppercased())
        let answerField = "currentAnswers.\(playerId)"
        roomRef.updateData([
            answerField: selectedOptionIndex
        ], completion: completion)
        #else
        completion(NetworkLayerError.firebaseNotConfigured)
        #endif
    }

    func revealResults(roomCode: String, completion: @escaping (Error?) -> Void) {
        #if canImport(FirebaseFirestore)
        let normalizedCode = roomCode.uppercased()
        let roomRef = db.collection("rooms").document(normalizedCode)

        roomRef.getDocument { snapshot, error in
            if let error {
                completion(error)
                return
            }

            guard
                let snapshot,
                snapshot.exists,
                let data = snapshot.data(),
                let room = RoomState(id: snapshot.documentID, dictionary: data),
                let currentQuestion = room.currentQuestion
            else {
                completion(NetworkLayerError.invalidRoomData)
                return
            }

            roomRef.collection("players").getDocuments { playersSnapshot, playersError in
                if let playersError {
                    completion(playersError)
                    return
                }

                guard let playersSnapshot else {
                    completion(NetworkLayerError.noPlayersInRoom)
                    return
                }

                let playerIDs = playersSnapshot.documents.map(\.documentID)
                var finalizedAnswers = room.currentAnswers

                for playerID in playerIDs where finalizedAnswers[playerID] == nil {
                    finalizedAnswers[playerID] = -1
                }

                roomRef.updateData([
                    "phase": RoomPhase.results.rawValue,
                    "currentAnswers": finalizedAnswers,
                    "answerLog.\(currentQuestion.id)": finalizedAnswers
                ], completion: completion)
            }
        }
        #else
        completion(NetworkLayerError.firebaseNotConfigured)
        #endif
    }

    func moveToNextQuestion(roomCode: String, completion: @escaping (Error?) -> Void) {
        #if canImport(FirebaseFirestore)
        let roomRef = db.collection("rooms").document(roomCode.uppercased())
        roomRef.getDocument { snapshot, error in
            if let error {
                completion(error)
                return
            }

            guard
                let snapshot,
                snapshot.exists,
                let data = snapshot.data(),
                let room = RoomState(id: snapshot.documentID, dictionary: data)
            else {
                completion(NetworkLayerError.invalidRoomData)
                return
            }

            let nextQuestionIndex = room.currentQuestionIndex + 1
            let hasNextQuestion = nextQuestionIndex < room.questions.count

            if hasNextQuestion {
                roomRef.updateData([
                    "phase": RoomPhase.question.rawValue,
                    "currentQuestionIndex": nextQuestionIndex,
                    "currentQuestionStartedAt": FieldValue.serverTimestamp(),
                    "currentAnswers": [:]
                ], completion: completion)
            } else {
                roomRef.updateData([
                    "phase": RoomPhase.finished.rawValue
                ], completion: completion)
            }
        }
        #else
        completion(NetworkLayerError.firebaseNotConfigured)
        #endif
    }

    func restartGame(roomCode: String, completion: @escaping (Error?) -> Void) {
        #if canImport(FirebaseFirestore)
        let roomRef = db.collection("rooms").document(roomCode.uppercased())
        roomRef.getDocument { snapshot, error in
            if let error {
                completion(error)
                return
            }

            guard
                let snapshot,
                snapshot.exists,
                let data = snapshot.data(),
                let room = RoomState(id: snapshot.documentID, dictionary: data)
            else {
                completion(NetworkLayerError.invalidRoomData)
                return
            }

            roomRef.collection("players").getDocuments { playersSnapshot, playersError in
                if let playersError {
                    completion(playersError)
                    return
                }

                guard let playersSnapshot else {
                    completion(NetworkLayerError.noPlayersInRoom)
                    return
                }

                let batch = self.db.batch()
                batch.updateData([
                    "phase": RoomPhase.waiting.rawValue,
                    "questionDuration": Self.defaultQuestionDuration,
                    "currentQuestionIndex": 0,
                    "currentAnswers": [:],
                    "answerLog": [:],
                    "questions": Self.makeRoundQuestions(
                        count: room.questionCount,
                        category: room.selectedCategory
                    ).map { $0.asDictionary },
                    "currentQuestionStartedAt": FieldValue.delete(),
                    "playerCount": playersSnapshot.documents.count
                ], forDocument: roomRef)

                for player in playersSnapshot.documents {
                    batch.updateData(["isReady": false], forDocument: player.reference)
                }

                batch.commit(completion: completion)
            }
        }
        #else
        completion(NetworkLayerError.firebaseNotConfigured)
        #endif
    }

    func leaveRoom(
        roomCode: String,
        playerId: String,
        completion: ((Error?) -> Void)? = nil
    ) {
        #if canImport(FirebaseFirestore)
        let roomRef = db.collection("rooms").document(roomCode.uppercased())
        let playerRef = roomRef.collection("players").document(playerId)

        playerRef.delete { error in
            if let error {
                completion?(error)
                return
            }

            roomRef.collection("players").getDocuments { snapshot, readError in
                if let readError {
                    completion?(readError)
                    return
                }

                guard let snapshot else {
                    completion?(nil)
                    return
                }

                if snapshot.documents.isEmpty {
                    roomRef.delete(completion: completion)
                } else {
                    roomRef.updateData([
                        "playerCount": snapshot.documents.count
                    ]) { countUpdateError in
                        completion?(countUpdateError)
                    }
                }
            }
        }
        #else
        completion?(NetworkLayerError.firebaseNotConfigured)
        #endif
    }
}

private extension NetworkLayer {
    #if canImport(FirebaseFirestore)
    func createRoomAttempt(
        hostName: String,
        questionCount: Int,
        selectedCategory: QuestionCategory,
        attemptsLeft: Int,
        completion: @escaping (Result<(roomCode: String, player: Player), Error>) -> Void
    ) {
        if attemptsLeft <= 0 {
            completion(.failure(NetworkLayerError.unableToGenerateRoomCode))
            return
        }

        let roomCode = Self.generateRoomCode()
        let roomRef = db.collection("rooms").document(roomCode)

        roomRef.getDocument { snapshot, error in
            if let error {
                completion(.failure(error))
                return
            }

            if snapshot?.exists == true {
                self.createRoomAttempt(
                    hostName: hostName,
                    questionCount: questionCount,
                    selectedCategory: selectedCategory,
                    attemptsLeft: attemptsLeft - 1,
                    completion: completion
                )
                return
            }

            let hostPlayer = Player(
                id: UUID().uuidString,
                name: hostName,
                isHost: true,
                isReady: false,
                joinedAt: Date()
            )

            let roomData: [String: Any] = [
                "code": roomCode,
                "hostId": hostPlayer.id,
                "phase": RoomPhase.waiting.rawValue,
                "questionDuration": Self.defaultQuestionDuration,
                "questionCount": questionCount,
                "selectedCategory": selectedCategory.rawValue,
                "maxPlayers": Self.defaultMaxPlayers,
                "playerCount": 1,
                "currentQuestionIndex": 0,
                "currentAnswers": [:],
                "answerLog": [:],
                "questions": Self.makeRoundQuestions(
                    count: questionCount,
                    category: selectedCategory
                ).map { $0.asDictionary },
                "createdAt": FieldValue.serverTimestamp()
            ]

            let playerData: [String: Any] = [
                "name": hostPlayer.name,
                "isHost": true,
                "isReady": false,
                "joinedAt": FieldValue.serverTimestamp()
            ]

            let batch = self.db.batch()
            batch.setData(roomData, forDocument: roomRef)
            batch.setData(playerData, forDocument: roomRef.collection("players").document(hostPlayer.id))

            batch.commit { writeError in
                if let writeError {
                    completion(.failure(writeError))
                    return
                }

                completion(.success((roomCode, hostPlayer)))
            }
        }
    }
    #endif

    static func generateRoomCode(length: Int = 6) -> String {
        let letters = Array("ABCDEFGHJKLMNPQRSTUVWXYZ23456789")
        return String((0..<length).compactMap { _ in letters.randomElement() })
    }

    static func makeRoundQuestions(count: Int, category: QuestionCategory) -> [QuizQuestion] {
        let pool = QuestionBank.questions(for: category)
        let shuffled = pool.shuffled()
        let safeCount = min(max(count, 1), shuffled.count)
        return Array(shuffled.prefix(safeCount))
    }

    static func nsError(for error: NetworkLayerError) -> NSError {
        NSError(
            domain: "flashquiz.networklayer",
            code: nsCode(for: error),
            userInfo: [NSLocalizedDescriptionKey: error.localizedDescription]
        )
    }

    static func nsCode(for error: NetworkLayerError) -> Int {
        switch error {
        case .firebaseNotConfigured: return 1001
        case .unableToGenerateRoomCode: return 1002
        case .roomNotFound: return 1003
        case .roomAlreadyStarted: return 1004
        case .roomIsFull: return 1005
        case .notEnoughPlayers: return 1006
        case .playersNotReady: return 1007
        case .invalidRoomData: return 1008
        case .noQuestionLeft: return 1009
        case .noPlayersInRoom: return 1010
        }
    }
}
