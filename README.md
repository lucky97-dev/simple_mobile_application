## Table of Contents

1. [Features](#features)
2. [Setup Instructions](#setup-instructions)
3. [Architecture](#architecture)
   - [Project Structure](#project-structure)
   - [MVVM Pattern](#mvvm-pattern)
4. [State Management](#state-management)
5. [Error Handling](#error-handling)
6. [Assumptions](#assumptions)
7. [Customization](#customization)
8. [Dependencies](#dependencies)
9. [License](#license)

## Features

- Display a list of products with images, names, and prices.
- View detailed product information on a separate screen.
- Mark products as favorites and view all favorite products.
- Search for products by name.
- Error handling for failed API requests.
- Responsive UI for small, medium, and large devices.

## Setup Instructions

### Prerequisites

1. [Flutter SDK](https://flutter.dev/docs/get-started/install) installed.
2. [Dart](https://dart.dev/get-dart) installed.
3. An IDE like [VS Code](https://code.visualstudio.com/) or [Android Studio](https://developer.android.com/studio).

### Steps

1. **Clone the repository:**
   git clone https://github.com/lucky97-dev/simple_mobile_application.git
  
2. **Navigate to the project directory:**
   cd simple_mobile_application

3. **Install dependencies:**
   flutter pub get

4. **Run the application:**
   flutter run
   
   - Use `flutter run` for Android/iOS.
   - For web or desktop, ensure you have the appropriate configurations.

5. **Build for release:**
   - For Android: `flutter build apk`
   - For iOS: `flutter build ios`

## Architecture

### Project Structure

The project follows a clean architecture with a layered structure:

```
lib/
├── data/
│   ├── data_sources/
│   ├── repositories/
│   └── models/
├── domain/
│   ├── entities/
│   └── use_cases/
├── presentation/
│   ├── screens/
│   └── view_models/
│   └── widgets/
├── utils/
└── main.dart
```

### MVVM Pattern

The app uses the MVVM (Model-View-ViewModel) pattern to separate the business logic from the UI components:

1. **Model:** Represents the data and business logic. In our case, `Product` entities and repository interfaces.
2. **View:** UI components that display the data and handle user interactions. It listens to ViewModel changes.
3. **ViewModel:** Acts as a mediator between View and Model. It exposes data for the view and handles user actions.

This architecture ensures scalability and testability, making it easier to manage complex UIs and business logic.

## State Management

The app uses the `Provider` package for state management. `Provider` is chosen for its simplicity and efficiency in handling state changes and propagating them to UI components.

- **Why Provider?**
  - **Ease of Use:** It simplifies the process of passing data between widgets.
  - **Performance:** Efficient state updates with minimal rebuilds.
  - **Community Support:** Widely used in the Flutter community with extensive documentation.

### Key ViewModels

- **ProductViewModel:** Manages the state for fetching, filtering, and managing products, including favorites.

## Error Handling

Error handling is implemented using `try-catch` blocks in the `ViewModel` for network calls and business logic. Any errors encountered during API requests or data processing are caught and managed within the app:

- **Network Errors:** Handled with specific messages to the user.
- **Business Logic Errors:** For example, invalid product data is logged and gracefully managed.

## Assumptions

1. **API Structure:** The mock API follows a standard RESTful structure with endpoints for fetching products and toggling favorites.
2. **User Authentication:** Not implemented. All actions like marking favorites are local to the app.
3. **Product Data:** The product data contains fields such as `id`, `name`, `price`, `description`, `imageUrl`, and `isFavorite`.
4. **Responsiveness:** Assumes general device sizes for small, medium, and large screens.

## Customization

- **Change API URL:** Modify the base URL in the `data/data_sources/api_service.dart` file.
- **Theme Customization:** Update the `ThemeData` in the `main.dart` file to change the look and feel of the app.

## Dependencies

- [Flutter]- SDK for building the app.
- [Provider] - State management.
- [Dio] - HTTP client for network requests.
- [Flutter Material] - UI components.