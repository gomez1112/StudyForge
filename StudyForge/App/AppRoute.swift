import Foundation

enum AppRoute: Hashable {
    case create
    case generating(GenerationContext)
    case studySetDetail(StudySetEntity)
}
