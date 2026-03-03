//
//  QuestionCategory.swift
//  flashquiz
//

import Foundation

enum QuestionCategory: String, CaseIterable, Identifiable {
    case all
    case history
    case sports
    case technology
    case generalKnowledge
    case biology

    var id: String { rawValue }

    var title: String {
        switch self {
        case .all:
            return "Karışık"
        case .history:
            return "Tarih"
        case .sports:
            return "Spor"
        case .technology:
            return "Teknoloji"
        case .generalKnowledge:
            return "Genel Kültür"
        case .biology:
            return "Biyoloji"
        }
    }
}
