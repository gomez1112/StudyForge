import SwiftUI
import SwiftData

@main
struct StudyForgeApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
        }
        .modelContainer(for: [StudySetEntity.self, FlashcardEntity.self, QuizQuestionEntity.self, QuizOptionEntity.self])
    }
}
