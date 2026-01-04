# StudyForge

StudyForge is an iOS 26+ SwiftUI app that turns photos, PDFs, or pasted text into guided study sets with flashcards and quizzes. The experience is designed to feel like a first‑party Apple app while remaining fully on-device and privacy‑respecting.

## Features

- **Capture knowledge**: Photos with OCR (Vision), PDFs via PDFKit, or paste text.
- **Generate study sets**: On-device Foundation Models stream flashcards and quizzes.
- **Learn effectively**: Flip cards, take quizzes, and revisit source text.
- **SwiftData persistence**: Study sets are saved locally with provenance.

## Tech Stack

- SwiftUI (iOS 26+) with `@Observable` view models
- SwiftData for persistence
- Foundation Models for on-device generation
- Vision for OCR
- PDFKit for text extraction

## Project Structure

```
StudyForge/
├─ App/
├─ Models/
│  ├─ Generated/
│  └─ SwiftData/
├─ Services/
├─ Utilities/
├─ ViewModels/
└─ Views/
   └─ Components/
```

## Running the App

1. Open the project in Xcode 26 or later.
2. Ensure the deployment target is iOS 26.0.
3. Build and run on an Apple Intelligence‑capable device or simulator.

## Capabilities & Notes

- **Photos access**: required to pick images.
- **Files access**: required to import PDFs.
- **Apple Intelligence**: the app detects availability and shows dedicated screens for unavailable states.
- **PDF note**: scanned PDFs without selectable text will show a guidance message.

## Design Rationale

StudyForge emphasizes clarity and warmth using system typography, materials, and continuous‑corner cards. The interface focuses on large, legible headers, minimal chrome, and subtle motion so learners can focus on content rather than interface complexity.
