# Movie App

This project is a movie application developed using the TMDB API. Users can view popular movies, search for movies, and save their favorite movies.

## Features

### Project Requirements

#### Home Screen

- **Search Bar:** Located at the top of the screen.
- **Default List:** Displays the top-rated movies by default.
- **Search Functionality:** When a user performs a search, it will search and display movies when the query is at least 2 characters long. It shows trending movies when the search bar is empty.

#### Favorites Screen

- **Favorite Movies:** Displays the movies that the user has marked as favorites.

#### Movie Detail Screen

- **Detailed Information:** Provides detailed information about the selected movie, including its poster, description, and other relevant details.

#### Add/Remove Favorites

- **Add/Remove Favorites:** Allows users to add and remove movies from their favorites. These operations are handled locally (local storage).

#### Search Function Management

- **Minimum 2 Characters:** The search function activates when the user’s query is at least 2 characters long.
- **Graceful Handling:** The search function works smoothly and displays the results without disrupting the user experience.

### User Features

- 🎬 View popular movies
- 🔍 Search for movies
- ⭐ Save favorite movies
- 📱 Responsive design

### Technical Features

- 🏗️ MVVM (Model-View-ViewModel) Architecture
- 🎨 Theme support (Light/Dark)
- 🌍 Multi-language support (TR/EN)
- 🚀 Flavor support (Dev/QA/Prod)
- 📝 Logger integration
- 🔄 BaseView and BaseViewModel structure
- 💉 Dependency Injection
- 🧪 Unit and Widget Tests

## Technologies

### Core

- Flutter 3.1.3
- Provider (State Management)
- Dio (HTTP Client)
- Go Router (Navigation)

### Storage & Persistence

- Shared Preferences (Local Storage)
- SQLite (Offline Cache)

### UI & UX

- Shimmer (Loading Effects)
- Cached Network Image
- Flutter SVG

### Development & Tools

- Easy Localization (Internationalization)
- Logger (Debugging)
- Flutter Flavorizr (Environment Management)
- Flutter Lints (Code Quality)

## Getting Started

1. Get a TMDB API key:

````bash
https://www.themoviedb.org/settings/api

1. TMDB API anahtarı alın:

```bash
https://www.themoviedb.org/settings/api
````

2. `assets/config/config.json` dosyasındaki `api_key` değerini güncelleyin:

```json
{
  "base_url": "https://api.themoviedb.org/3",
  "api_key": "YOUR_API_KEY",
  "image_base_url": "https://image.tmdb.org/t/p/w500"
}
```

3. Install the dependencies:

```bash
flutter pub get
```

4. Run the app based on the flavor:

```bash
# Development
flutter run --flavor dev -t lib/main_dev.dart

# QA
flutter run --flavor qa -t lib/main_qa.dart

# Production
flutter run --flavor prod -t lib/main_prod.dart
```

## Proje Yapısı

```
lib/
  ├── core/
  │   ├── base/
  │   │   ├── base_view.dart
  │   │   └── base_view_model.dart
  │   ├── config/
  │   │   ├── app_config.dart
  │   │   └── flavors.dart
  │   ├── constants/
  │   │   ├── app_constants.dart
  │   │   └── theme_constants.dart
  │   ├── app_localization/
  │   │   └── app_router.dart
  │   ├── models/
  │   │   └── movie.dart
  │   ├── providers/
  │   │   └── language_provider.dart
  │   ├── router/
  │   │   └── app_router.dart
  │   ├── services/
  │   │   └── api_service.dart
  │   ├── theme/
  │       └── app_theme.dart
  │
  ├── features/
  │   ├── home/
  │   │   ├── model/
  │   │   ├── view/
  │   │   └── viewmodel/
  │   ├── favorites/
  │   │   ├── model/
  │   │   ├── view/
  │   │   └── viewmodel/
  │   └── movie_detail/
  │       ├── model/
  │       ├── view/
  │       └── viewmodel/
  ├── main/
      ├── main_dev.dart
      ├── main_qa.dart
      └── main_prod.dart
  ├── init.dart

```

## Mimari

### MVVM (Model-View-ViewModel)

- **Model**: Contains data models and business logic.
- **View**: Manages UI components and user interactions.
- **ViewModel**: Acts as a bridge between the View and the Model.

### Dependency Injection

- Dependencies are managed using GetIt.
- Singleton pattern is applied for service and ViewModels.

### State Management

- State management using Provider package.
- ChangeNotifier-based ViewModels.
- Granular rebuilds using Consumer widgets.

## Katkıda Bulunma

Create your feature branch (git checkout -b feature/amazing-feature).
Commit your changes (git commit -m 'feat: Add some amazing feature').
Push to the branch (git push origin feature/amazing-feature).
Create a Pull Request.

## Screenshots

| Home Screen                            | Search Screen                              | Favorites Screen                                 | Movie Detail Screen                              |
| -------------------------------------- | ------------------------------------------ | ------------------------------------------------ | ------------------------------------------------ |
| ![Home Screen](assets/images/home.png) | ![Search Screen](assets/images/search.png) | ![Favorites Screen](assets/images/favorites.png) | ![Movie Detail Screen](assets/images/detail.png) |
