import SwiftUI
import SwiftData

struct GeneratingView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel = GeneratingViewModel()
    private let availabilityStatus = FoundationModelService().availabilityStatus()

    let context: GenerationContext
    let onComplete: (StudySetEntity) -> Void

    var body: some View {
        VStack(alignment: .leading) {
            if availabilityStatus != .available {
                ModelUnavailableView(status: availabilityStatus)
            } else if let error = viewModel.errorMessage {
                CardSurface {
                    Label(error, systemImage: "exclamationmark.triangle")
                        .foregroundStyle(.secondary)
                }
            } else {
                VStack(alignment: .leading) {
                    Text("Generating your study set")
                        .font(.largeTitle.bold())
                    Text("We’re streaming results as the model builds your cards and quiz.")
                        .foregroundStyle(.secondary)
                }

                TimelineProgressView(
                    progress: viewModel.progress,
                    flashcardTarget: context.flashcardCount,
                    quizTarget: context.quizCount
                )
            }
        }
        .padding()
        .navigationTitle("Generating")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            if availabilityStatus == .available {
                viewModel.startGeneration(context: context, modelContext: modelContext)
            }
        }
        .onChange(of: viewModel.completedStudySet) { _, newValue in
            if let studySet = newValue {
                onComplete(studySet)
            }
        }
    }
}
