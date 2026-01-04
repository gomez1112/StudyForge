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
}
