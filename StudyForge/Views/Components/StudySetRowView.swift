import SwiftUI

struct StudySetRowView: View {
    let studySet: StudySetEntity

    var body: some View {
        CardSurface {
            VStack(alignment: .leading) {
                Text(studySet.title)
                    .font(.headline)
                Text(studySet.overview)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(3)
                HStack {
                    Label("\(studySet.flashcards?.count ?? 0) cards", systemImage: "rectangle.on.rectangle")
                    Spacer()
                    Label("\(studySet.quizQuestions?.count ?? 0) questions", systemImage: "checklist")
                }
                .font(.footnote)
                .foregroundStyle(.secondary)
            }
        }
    }
}
