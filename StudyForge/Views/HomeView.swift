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
            if viewModel.filteredStudySets(studySets).isEmpty {
                EmptyStateView(action: navigateToCreate)
                    .listRowSeparator(.hidden)
            } else {
                ForEach(viewModel.filteredStudySets(studySets)) { studySet in
                    Button {
                        navigateToDetail(studySet)
                    } label: {
                        StudySetRowView(studySet: studySet)
                    }
                    .buttonStyle(.plain)
                }
                .onDelete(perform: deleteStudySets)
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle("StudyForge")
        .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .automatic))
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("New Study Set", systemImage: "plus", action: navigateToCreate)
            }
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
