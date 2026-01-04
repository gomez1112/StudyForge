import SwiftUI

struct QuizView: View {
    @State private var viewModel: QuizViewModel

    init(questions: [QuizQuestionEntity]) {
        _viewModel = State(initialValue: QuizViewModel(questions: questions))
    }

    var body: some View {
        VStack(alignment: .leading) {
            if viewModel.questions.isEmpty {
                ContentUnavailableView("No Quiz Questions", systemImage: "checklist")
            } else {
                StudyProgressHeaderView(
                    title: "Quiz",
                    subtitle: "Check your understanding with quick recall.",
                    progress: Double(viewModel.completedCount) / Double(viewModel.questions.count),
                    detail: "\(viewModel.completedCount) of \(viewModel.questions.count) answered"
                )

                ForEach(viewModel.questions) { question in
                    CardSurface {
                        VStack(alignment: .leading) {
                            Text(question.prompt)
                                .font(.headline)

                            if let options = question.options {
                                ForEach(options) { option in
                                    let isSelected = viewModel.selectedOption(for: question)?.id == option.id
                                    QuizOptionRowView(
                                        option: option,
                                        isSelected: isSelected,
                                        isCorrect: option.isCorrect,
                                        action: {
                                            viewModel.select(option: option, for: question)
                                        }
                                    )
                                }
                            }

                            if let selection = viewModel.selectedOption(for: question) {
                                Text(question.explanation)
                                    .foregroundStyle(.secondary)
                                    .transition(.opacity)
                                    .accessibilityLabel("Explanation: \(question.explanation)")
                                    .padding(.top)
                                    .overlay(alignment: .topLeading) {
                                        HStack {
                                            Image(systemName: selection.isCorrect ? "checkmark.circle.fill" : "exclamationmark.triangle.fill")
                                                .foregroundStyle(selection.isCorrect ? .green : .orange)
                                            Text(selection.isCorrect ? "Correct" : "Review")
                                                .font(.caption)
                                                .foregroundStyle(.secondary)
                                        }
                                    }
                            }
                        }
                    }
                }
            }
        }
        .padding()
    }
}
