//
//  QuizQuestion.swift
//  flashquiz
//

import Foundation

struct QuizQuestion: Identifiable, Hashable {
    let id: String
    let text: String
    let options: [String]
    let correctOptionIndex: Int
    let category: QuestionCategory

    init(
        id: String = UUID().uuidString,
        text: String,
        options: [String],
        correctOptionIndex: Int,
        category: QuestionCategory = .generalKnowledge
    ) {
        self.id = id
        self.text = text
        self.options = options
        self.correctOptionIndex = correctOptionIndex
        self.category = category
    }

    init?(dictionary: [String: Any]) {
        guard
            let id = dictionary["id"] as? String,
            let text = dictionary["text"] as? String,
            let options = dictionary["options"] as? [String],
            let correctOptionIndex = dictionary["correctOptionIndex"] as? Int
        else {
            return nil
        }

        let categoryRaw = dictionary["category"] as? String
        let category = QuestionCategory(rawValue: categoryRaw ?? "") ?? .generalKnowledge

        self.id = id
        self.text = text
        self.options = options
        self.correctOptionIndex = correctOptionIndex
        self.category = category
    }

    var asDictionary: [String: Any] {
        [
            "id": id,
            "text": text,
            "options": options,
            "correctOptionIndex": correctOptionIndex,
            "category": category.rawValue
        ]
    }
}
