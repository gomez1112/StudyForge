import SwiftUI

struct TimelineProgressView: View {
    let progress: GenerationProgress
    let flashcardTarget: Int
    let quizTarget: Int

    var body: some View {
        VStack(alignment: .leading) {
            TimelineRowView(title: "Title", subtitle: progress.title.isEmpty ? "Waiting…" : progress.title, isComplete: !progress.title.isEmpty)
            TimelineRowView(title: "Overview", subtitle: progress.overview.isEmpty ? "Drafting summary…" : progress.overview, isComplete: !progress.overview.isEmpty)
            TimelineRowView(title: "Flashcards", subtitle: "\(progress.flashcards.count) of \(flashcardTarget)", isComplete: progress.flashcards.count >= flashcardTarget)
            TimelineRowView(title: "Quiz", subtitle: "\(progress.quizQuestions.count) of \(quizTarget)", isComplete: progress.quizQuestions.count >= quizTarget)
        }
        .animation(.spring(response: 0.35, dampingFraction: 0.8), value: progress)
    }
}
