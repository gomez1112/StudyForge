import SwiftUI
import PhotosUI

struct CreateStudySetView: View {
    @State private var viewModel = CreateViewModel()
    @State private var isFileImporterPresented = false

    let onGenerate: (GenerationContext) -> Void

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                CardSurface {
                    VStack(alignment: .leading) {
                        TextField("Study Set Title", text: $viewModel.title)
                            .textFieldStyle(.roundedBorder)

                        Picker("Input", selection: $viewModel.selectedInput) {
                            ForEach(InputSourceType.allCases) { source in
                                Text(source.rawValue).tag(source)
                            }
                        }
                        .pickerStyle(.segmented)

                        if viewModel.selectedInput == .photo {
                            PhotosPicker(selection: $viewModel.photosPickerItem, matching: .images) {
                                Label("Choose Photo", systemImage: "camera.viewfinder")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .onChange(of: viewModel.photosPickerItem) { _, newValue in
                                viewModel.handlePhotoSelection(newValue)
                            }
                        }

                        if viewModel.selectedInput == .pdf {
                            Button("Import PDF", systemImage: "doc.richtext") {
                                isFileImporterPresented = true
                            }
                            .glassButtonStyle()
                            .fileImporter(isPresented: $isFileImporterPresented, allowedContentTypes: [.pdf]) { result in
                                switch result {
                                case .success(let url):
                                    viewModel.handlePDFSelection(url)
                                case .failure(let error):
                                    viewModel.extractionError = error.localizedDescription
                                }
                            }
                        }

                        if viewModel.isExtracting {
                            HStack {
                                ProgressView()
                                Text("Extracting text…")
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }

                if let error = viewModel.extractionError {
                    CardSurface {
                        Label(error, systemImage: "exclamationmark.triangle")
                            .foregroundStyle(.secondary)
                    }
                }

                CardSurface {
                    VStack(alignment: .leading) {
                        Text("Source Text")
                            .font(.headline)
                        TextEditor(text: $viewModel.extractedText)
                            .frame(minHeight: 220)
                            .clipShape(.rect(cornerRadius: 16, style: .continuous))
                            .overlay {
                                RoundedRectangle(cornerRadius: 16, style: .continuous)
                                    .stroke(.quaternary)
                            }
                            .onChange(of: viewModel.extractedText) { _, newValue in
                                if viewModel.selectedInput == .paste {
                                    viewModel.handlePasteTextChange(newValue)
                                }
                            }
                    }
                }

                CardSurface {
                    VStack(alignment: .leading) {
                        Stepper("Flashcards: \(viewModel.flashcardCount)", value: $viewModel.flashcardCount, in: 4...20)
                        Stepper("Quiz Questions: \(viewModel.quizCount)", value: $viewModel.quizCount, in: 4...20)
                    }
                }

                Button("Generate", systemImage: "wand.and.stars") {
                    if let context = viewModel.buildContext() {
                        onGenerate(context)
                    }
                }
                .glassButtonStyle(isProminent: true)
                .disabled(viewModel.buildContext() == nil)
            }
            .padding()
        }
        .navigationTitle("Create")
        .navigationBarTitleDisplayMode(.inline)
    }
}
