import Foundation

enum InputSourceType: String, CaseIterable, Identifiable {
    case photo = "Photo"
    case pdf = "PDF"
    case paste = "Paste"

    var id: String { rawValue }
}
