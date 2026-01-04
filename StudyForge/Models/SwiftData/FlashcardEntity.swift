import Foundation
import SwiftData

@Model
final class FlashcardEntity {
    var id: UUID
    var front: String
    var back: String
    var orderIndex: Int
    var studySet: StudySetEntity?

    init(
        id: UUID = UUID(),
        front: String = "",
        back: String = "",
        orderIndex: Int = 0,
        studySet: StudySetEntity? = nil
    ) {
        self.id = id
        self.front = front
        self.back = back
        self.orderIndex = orderIndex
        self.studySet = studySet
    }
}
