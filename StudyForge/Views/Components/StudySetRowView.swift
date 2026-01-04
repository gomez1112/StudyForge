import SwiftUI

struct StudySetRowView: View {
    let studySet: StudySetEntity

    var body: some View {
        CardSurface {
            VStack(alignment: .leading) {
                HStack(alignment: .firstTextBaseline) {
                    Text(studySet.title)
                        .font(.headline)
                    Spacer()
                    Text(studySet.createdAt, format: .dateTime.month().day())
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                Text(studySet.overview)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(3)

                HStack {
                    MetricPillView(title: "cards", value: studySet.flashcards?.count ?? 0, systemImage: "rectangle.on.rectangle")
                    MetricPillView(title: "questions", value: studySet.quizQuestions?.count ?? 0, systemImage: "checklist")
                }
            }
        }
    }
}
