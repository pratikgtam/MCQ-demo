# MCQ Demo - Flutter Application

A Flutter application that displays interactive multiple choice questions with instant feedback.

## Summary

This is a simple and lightweight MCQ (Multiple Choice Question) app built in Flutter. The code is clean and organized with a clear separation between models, services, and screens. JSON data is parsed using Flutter’s built-in dart:convert, and errors are handled properly. The UI follows Material Design 3 and is easy to use, with smooth interactions and clear feedback. Since the app is straightforward, there was no need for external packages everything is handled using Flutter’s native tools like StatefulWidget for state management and built-in JSON parsing.

### Scalability:
If the app needs to grow in the future, we can easily add:
	•	API integration using the dio package to load lessons from a backend
	•	More advanced state management like the bloc pattern for bigger features
	•	Freezed package for immutable data classes and code generation for JSON serialization/deserialization

### Experience:
I've worked on a similar production app before. One example is The Mother Network (available on the App Store: https://apps.apple.com/ca/app/the-mother-network/id6736522961), which includes multiple-choice/poll features. In that project, I used bloc for state management, dio for API calls, freezed for immutable data classes and JSON serialization, and hive for local storage. So, I have hands-on experience in building and shipping Flutter apps with interactive question-based functionality.

## Getting Started

```bash
flutter pub get
flutter run
```

## Architecture

### State Management
- Uses `StatefulWidget` with local state management
- `MCQPage` manages lesson loading state (loading, error, data)
- `MCQQuestion` manages answer selection and feedback state

### Data Flow
1. `LessonService.loadLesson()` reads JSON from assets
2. JSON parsed using `dart:convert` and mapped to `Lesson` model
3. `MCQPage` loads lesson on `initState()`
4. First QCM activity extracted and passed to `MCQQuestion`
5. User interaction updates local state, triggering UI rebuild

### Services

**LessonService**
- Static service class for data loading
- Uses `rootBundle.loadString()` for asset access
- Returns `Future<Lesson>` with error handling
- Throws `Exception` on load failure

### Widgets

**MCQPage** (`StatefulWidget`)
- Handles async lesson loading
- Manages loading/error states
- Filters activities by type "qcm"
- Renders `MCQQuestion` with first matching activity

**MCQQuestion** (`StatefulWidget`)
- Manages `selectedAnswer` and `showAnswer` state
- Conditional styling based on answer correctness
- Visual feedback: green border/icon for correct, red for incorrect
- Reset functionality to clear state

## Project Structure

```
lib/
├── main.dart                 # MaterialApp entry, theme config
├── models/
│   └── lesson.dart          # Lesson, Activity data models
├── screens/
│   ├── mcq_page.dart        # Main container, lesson loader
│   └── mcq_question.dart    # Interactive question widget
└── services/
    └── lesson_service.dart  # Asset JSON loader

assets/lesson.json           # Lesson data source
```

## Data Format

Edit `assets/lesson.json`:

```json
{
  "id": "CP1_TEST_L1",
  "title": "Test Lesson",
  "activities": [
    {
      "type": "qcm",
      "question": "What is 2 + 2?",
      "options": ["3", "4", "5"],
      "answer": "4"
    }
  ]
}
```