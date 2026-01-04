import Foundation
import Observation

@MainActor
@Observable
final class HomeViewModel {
    var searchText: String = ""

    func filteredStudySets(_ sets: [StudySetEntity]) -> [StudySetEntity] {
        guard !searchText.isEmpty else { return sets }
        return sets.filter { $0.title.localizedStandardContains(searchText) }
    }

    func summary(for sets: [StudySetEntity]) -> StudySetSummary {
        let flashcards = sets.reduce(0) { $0 + ($1.flashcards?.count ?? 0) }
        let quizzes = sets.reduce(0) { $0 + ($1.quizQuestions?.count ?? 0) }
        return StudySetSummary(
            studySetCount: sets.count,
            flashcardCount: flashcards,
            quizCount: quizzes
        )
    }
}
