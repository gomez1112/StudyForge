import SwiftUI

struct HomeHeroView: View {
    let summary: StudySetSummary
    let action: () -> Void

    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text("StudyForge")
                    .font(.largeTitle.bold())
                Text("Turn any material into polished flashcards and quizzes in minutes.")
                    .foregroundStyle(.secondary)
            }

            if #available(iOS 26, *) {
                GlassEffectContainer {
                    HStack {
                        MetricPillView(title: "sets", value: summary.studySetCount, systemImage: "square.stack.3d.up")
                        MetricPillView(title: "cards", value: summary.flashcardCount, systemImage: "rectangle.on.rectangle")
                        MetricPillView(title: "questions", value: summary.quizCount, systemImage: "checklist")
                    }
                }
            } else {
                HStack {
                    MetricPillView(title: "sets", value: summary.studySetCount, systemImage: "square.stack.3d.up")
                    MetricPillView(title: "cards", value: summary.flashcardCount, systemImage: "rectangle.on.rectangle")
                    MetricPillView(title: "questions", value: summary.quizCount, systemImage: "checklist")
                }
            }

            Button("Create Study Set", systemImage: "wand.and.stars", action: action)
                .glassButtonStyle(isProminent: true)
        }
        .padding()
        .glassSurface(cornerRadius: 28)
    }
}
