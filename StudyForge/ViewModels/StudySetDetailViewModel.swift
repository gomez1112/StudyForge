import Foundation
import Observation

@MainActor
@Observable
final class StudySetDetailViewModel {
    var studySet: StudySetEntity

    init(studySet: StudySetEntity) {
        self.studySet = studySet
    }
}
