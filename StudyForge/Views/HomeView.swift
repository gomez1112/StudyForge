import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: [SortDescriptor(\StudySetEntity.createdAt, order: .reverse)])
    private var studySets: [StudySetEntity]

    @State private var viewModel = HomeViewModel()
    let navigateToCreate: () -> Void
    let navigateToDetail: (StudySetEntity) -> Void

    var body: some View {
        List {
            Section {
                HomeHeroView(summary: viewModel.summary(for: studySets), action: navigateToCreate)
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
            }

            if viewModel.filteredStudySets(studySets).isEmpty {
                EmptyStateView(action: navigateToCreate)
                    .listRowSeparator(.hidden)
            } else {
                Section("Your Study Sets") {
                    ForEach(viewModel.filteredStudySets(studySets)) { studySet in
                        Button {
                            navigateToDetail(studySet)
                        } label: {
                            StudySetRowView(studySet: studySet)
                        }
                        .buttonStyle(.plain)
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                    }
                    .onDelete(perform: deleteStudySets)
                }
            }
        }
        .listStyle(.insetGrouped)
        .scrollContentBackground(.hidden)
        .navigationTitle("StudyForge")
        .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .automatic))
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("New Study Set", systemImage: "plus", action: navigateToCreate)
                    .glassButtonStyle()
            }
        }
        .background {
            LinearGradient(
                colors: [.indigo.opacity(0.18), .cyan.opacity(0.12)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
        }
    }

    private func deleteStudySets(offsets: IndexSet) {
        let filtered = viewModel.filteredStudySets(studySets)
        for index in offsets {
            let studySet = filtered[index]
            modelContext.delete(studySet)
        }
    }
}
