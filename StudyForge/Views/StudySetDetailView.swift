import SwiftUI

struct StudySetDetailView: View {
    @State private var viewModel: StudySetDetailViewModel
    @State private var selectedTab: StudySetTab = .flashcards
    let regenerate: (GenerationContext) -> Void

    init(studySet: StudySetEntity, regenerate: @escaping (GenerationContext) -> Void) {
        _viewModel = State(initialValue: StudySetDetailViewModel(studySet: studySet))
        self.regenerate = regenerate
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                CardSurface {
                    VStack(alignment: .leading) {
                        Text(viewModel.studySet.title)
                            .font(.largeTitle.bold())
                        Text(viewModel.studySet.overview)
                            .foregroundStyle(.secondary)
                    }
                }

                TabView(selection: $selectedTab) {
                    Tab("Flashcards", systemImage: "rectangle.on.rectangle.angled", value: .flashcards) {
                        FlashcardsView(cards: viewModel.studySet.flashcards ?? [])
                    }
                    Tab("Quiz", systemImage: "checklist", value: .quiz) {
                        QuizView(questions: viewModel.studySet.quizQuestions ?? [])
                    }
                    Tab("Source", systemImage: "doc.text", value: .source) {
                        SourceView(sourceText: viewModel.studySet.sourceText) {
                            regenerate(
                                GenerationContext(
                                    title: viewModel.studySet.title,
                                    sourceText: viewModel.studySet.sourceText,
                                    flashcardCount: viewModel.studySet.flashcards?.count ?? 8,
                                    quizCount: viewModel.studySet.quizQuestions?.count ?? 6
                                )
                            )
                        }
                    }
                }
                .frame(minHeight: 520)
            }
            .padding()
        }
        .navigationTitle("Study Set")
        .navigationBarTitleDisplayMode(.inline)
    }
}
