//
//  Player.swift
//  flashquiz
//

import Foundation

#if canImport(FirebaseFirestore)
import FirebaseFirestore
#endif

struct Player: Identifiable, Hashable {
    let id: String
    let name: String
    let isHost: Bool
    let isReady: Bool
    let joinedAt: Date?

    init(id: String, name: String, isHost: Bool, isReady: Bool, joinedAt: Date?) {
        self.id = id
        self.name = name
        self.isHost = isHost
        self.isReady = isReady
        self.joinedAt = joinedAt
    }

    init?(id: String, dictionary: [String: Any]) {
        guard
            let name = dictionary["name"] as? String,
            let isHost = dictionary["isHost"] as? Bool
        else {
            return nil
        }

        self.id = id
        self.name = name
        self.isHost = isHost
        self.isReady = dictionary["isReady"] as? Bool ?? false
        self.joinedAt = Player.parseDate(from: dictionary["joinedAt"])
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
