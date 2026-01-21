# ThyPok - Advanced Pokémon Explorer

ThyPok is a production-ready Pokémon explorer application built with Flutter, showcasing Clean Architecture, advanced state management with Riverpod, and offline-first capabilities.

## 🚀 Features

- **Robust Pokémon List**: Paginated browsing of over 1000+ Pokémon.
- **Detailed Stats**: Comprehensive information including types, stats, and abilities.
- **Offline-First**: Reliable caching for a smooth experience without internet.
- **Favorites & Team Builder**: Save your favorite Pokémon and build your dream team.
- **Advanced Search**: Find Pokémon by name or ID with ease.
- **Premium UI**: Modern design with glassmorphism, smooth animations, and dark/light themes.

## 🏗 Architecture

The app follows **Clean Architecture** principles, organized into:
- **Presentation Layer**: UI widgets, pages, and Riverpod providers.
- **Domain Layer**: Entities, repository interfaces, and use cases.
- **Data Layer**: Models (JSON mapping), repository implementations, and data sources (Remote & Local).

## 🛠 Tech Stack

- **Flutter SDK**: High-performance UI framework.
- **Riverpod**: Predictable and scalable state management.
- **Dio**: Powerful HTTP client with interceptors.
- **GetIt**: Optimized dependency injection.
- **Hive/Shared Preferences**: Efficient local storage and caching.
- **Skeletonizer**: Smooth loading state transitions.

## 📥 Setup

1. **Clone the repository**
   ```bash
   git clone https://github.com/ThyPok/pokeman.git
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

## 📸 Screenshots

*(Screenshots will be added as the UI develops)*

## 🧪 Testing

The project includes unit, widget, and integration tests to ensure stability.
```bash
flutter test
```

## 📜 License

Distributed under the MIT License. See `LICENSE` for more information.
