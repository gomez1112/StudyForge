import SwiftUI

struct RootView: View {
    @State private var path: [AppRoute] = []

    var body: some View {
        NavigationStack(path: $path) {
            HomeView(navigateToCreate: {
                path.append(.create)
            }, navigateToDetail: { studySet in
                path.append(.studySetDetail(studySet))
            })
            .navigationDestination(for: AppRoute.self) { route in
                switch route {
                case .create:
                    CreateStudySetView { context in
                        path.append(.generating(context))
                    }
                case .generating(let context):
                    GeneratingView(context: context) { studySet in
                        path = [.studySetDetail(studySet)]
                    }
                case .studySetDetail(let studySet):
                    StudySetDetailView(studySet: studySet) { context in
                        path.append(.generating(context))
                    }
                }
            }
        }
    }
}
