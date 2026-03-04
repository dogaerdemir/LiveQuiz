//
//  ChatMessage.swift
//  flashquiz
//

import Foundation

#if canImport(FirebaseFirestore)
import FirebaseFirestore
#endif

struct ChatMessage: Identifiable, Hashable {
    let id: String
    let playerId: String
    let playerName: String
    let text: String
    let sentAt: Date

    init(
        id: String,
        playerId: String,
        playerName: String,
        text: String,
        sentAt: Date
    ) {
        self.id = id
        self.playerId = playerId
        self.playerName = playerName
        self.text = text
        self.sentAt = sentAt
    }

    init?(id: String, dictionary: [String: Any]) {
        guard
            let playerId = dictionary["playerId"] as? String,
            let playerName = dictionary["playerName"] as? String,
            let text = dictionary["text"] as? String
        else {
            return nil
        }

        self.id = id
        self.playerId = playerId
        self.playerName = playerName
        self.text = text
        self.sentAt = ChatMessage.parseDate(from: dictionary["sentAt"]) ?? Date()
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
