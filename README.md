# Grad Project - University Management App

A Flutter application following Clean Architecture principles with role-based authentication for managing university canteen, rooms, schedules, and more.

## 🎯 Features

### 🔐 Role-Based Authentication
- **Students**: Full access to all features (Canteen, Rooms/Teaching, Schedule/Assignments, Profile)
- **Cooks**: Canteen management interface (Add, Edit, Delete meals)

### 🍽️ Canteen Management
**For Students:**
- View available meals with images
- See meal details (calories, ingredients, price)
- Browse by categories
- Real-time updates when cooks make changes

**For Cooks:**
- Add new meals with photos (camera or gallery)
- Edit existing meals
- Manage inventory (quantity, availability)
- Upload meal images to Firebase Storage
- Delete meals with confirmation
- Real-time sync with student views

### 🏫 Other Features
- **Rooms & Teaching**: Manage classroom information
- **Schedule & Assignments**: Academic calendar and tasks
- **Profile**: User information and logout

## 🏗️ Architecture

This project follows Clean Architecture with a feature-based structure:

```
lib/
├── core/                    # Shared resources
│   ├── theme/              # Colors, text styles
│   ├── widgets/            # Reusable UI components
│   └── utils/              # Validators, extensions
├── navigation/             # Routing configuration
│   ├── app_router.dart     # Role-based routing
│   ├── nav_scaffold.dart   # Student navigation (4 tabs)
│   └── cook_nav_scaffold.dart  # Cook navigation (2 tabs)
├── features/               # Feature modules
│   ├── auth/              # Authentication with role detection
│   ├── canteen/           # Canteen menu (student + cook)
│   ├── rooms_teaching/    # Rooms & peer teaching
│   ├── schedule_assignments/  # Schedule, assignments, GPA
│   └── profile/           # User profile & settings
└── main.dart              # App entry point with Firebase init
```

### Tech Stack
- **Framework**: Flutter 3.9.2+
- **State Management**: Riverpod (riverpod_annotation)
- **Navigation**: go_router with StatefulShellRoute
- **Firebase**: Authentication, Firestore, Storage
- **Code Generation**: freezed, json_serializable, build_runner
- **Image Handling**: image_picker

### Principles
- ✅ **Clean Architecture** - Separation of concerns (Domain, Data, Presentation)
- ✅ **SOLID** - Single responsibility, open-closed, dependency inversion
- ✅ **DRY** - Reusable widgets and utilities
- ✅ **Immutability** - Freezed for value objects
- ✅ **Type Safety** - Strict null safety

### Feature Structure (Clean Architecture)

Each feature follows the same layered structure:

```
feature/
├── domain/                # Business logic layer
│   ├── entities/         # Domain models (Freezed)
│   ├── repositories/     # Repository interfaces
│   └── usecases/         # Business use cases
├── data/                 # Data layer
│   ├── datasources/      # Data sources (local/remote)
│   ├── repositories/     # Repository implementations
│   └── models/           # DTOs (if needed)
└── presentation/         # UI layer
    ├── screens/          # Screen widgets
    ├── widgets/          # Feature-specific widgets
    ├── providers/        # Riverpod providers
    └── state/            # State classes (Freezed)
```

## 🎨 Features

### 1. Canteen Menu 🍽️
- Daily/weekly menu display
- Filter by tags (vegetarian, vegan, healthy, etc.)
- View item details (calories, price, description)
- Date selector for different days

### 2. Rooms & Peer Teaching 🏫
- **Rooms Tab**: View available study rooms with capacity and equipment info
- **Tutors Tab**: Browse peer tutors by subject with ratings

### 3. Schedule & Academics 📅
- **Schedule Tab**: View daily class schedule
- **Assignments Tab**: Track pending assignments with priorities
- **GPA Tab**: Calculate and track GPA by semester

### 4. Profile & Settings 👤
- User profile information
- Dark/Light theme toggle
- Language and notification settings
- App information

## 🛠️ Tech Stack

- **Framework**: Flutter 3.9.2+
- **State Management**: Riverpod 2.6.1
- **Navigation**: go_router 14.6.2
- **Code Generation**: 
  - Freezed 2.5.7 (immutable models)
  - json_serializable 6.8.0 (JSON serialization)
  - riverpod_generator 2.6.2 (providers)
- **Utilities**: intl 0.19.0 (internationalization)

## 📦 Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd grad_project
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run code generation**
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

## 🔧 Development

### Code Generation

When you modify Freezed models or add Riverpod providers, run:

```bash
# One-time build
dart run build_runner build --delete-conflicting-outputs

# Watch mode (auto-rebuild on changes)
dart run build_runner watch --delete-conflicting-outputs
```

### Project Principles

#### ✅ SOLID Principles
- **Single Responsibility**: Each class has one reason to change
- **Open/Closed**: Open for extension, closed for modification
- **Liskov Substitution**: Subtypes must be substitutable
- **Interface Segregation**: Many specific interfaces > one general
- **Dependency Inversion**: Depend on abstractions, not concretions

#### ✅ Clean Architecture
- **Domain Layer**: Business logic, entities, use cases (no Flutter dependencies)
- **Data Layer**: Repository implementations, data sources
- **Presentation Layer**: UI, state management, user interactions

#### ✅ Flutter Best Practices
- Small, composable widgets (< 200 lines)
- Reusable UI components in `core/widgets/`
- No business logic in UI
- Use `const` constructors where possible
- Meaningful naming conventions

## 📁 Key Files

### Core Components
- `app_colors.dart`: Material 3 color palette (light/dark)
- `app_text_styles.dart`: Typography system
- `app_button.dart`: Reusable button with variants
- `app_card.dart`: Reusable card component
- `validators.dart`: Form validation utilities
- `extensions.dart`: Dart extensions for common operations

### Navigation
- `app_router.dart`: Route definitions with go_router
- `nav_scaffold.dart`: Bottom navigation bar wrapper

## 🎯 State Management

Using Riverpod with code generation:

```dart
// Define a notifier
class FeatureNotifier extends StateNotifier<FeatureState> {
  FeatureNotifier() : super(FeatureState.initial());
  
  Future<void> loadData() async {
    // Business logic
  }
}

// Create provider
final featureProvider = StateNotifierProvider<FeatureNotifier, FeatureState>((ref) {
  return FeatureNotifier();
});

// Use in UI
final state = ref.watch(featureProvider);
```

## 🎨 Theming

The app supports both light and dark themes using Material 3:

```dart
// Access theme-aware colors
AppColors.primary(brightness)
AppColors.textPrimary(brightness)

// Use text styles
AppTextStyles.titleLarge(context)
AppTextStyles.bodyMedium(context)
```

## 📱 Supported Platforms

- ✅ Android
- ✅ iOS
- ✅ Web
- ✅ macOS
- ✅ Windows
- ✅ Linux

## 🤝 Contributing

1. Follow the existing architecture and code style
2. Keep widgets small and composable
3. Use Freezed for all models and state classes
4. Write unit tests for business logic
5. Run code generation after changes
6. Ensure no lint errors before committing

---

## 🔑 Demo Accounts

### Cook Accounts (Full Meal Management)
- **Email**: `cook@canteen.com` | **Password**: `cook123456`
- **Email**: `chef@kitchen.com` | **Password**: `cook123456`

### Student Accounts (Read-Only Canteen)
- **Email**: `student@university.edu` | **Password**: `student123456`
- **Email**: `john.doe@university.edu` | **Password**: `student123456`

## 📚 Additional Documentation

- **[COOK_FEATURES.md](./COOK_FEATURES.md)** - Complete guide to cook meal management features
- **[FIREBASE_COOK_SETUP.md](./FIREBASE_COOK_SETUP.md)** - Firebase setup with security rules
- **[AUTH_IMPLEMENTATION.md](./AUTH_IMPLEMENTATION.md)** - Authentication system details
- **[FIREBASE_SETUP.md](./FIREBASE_SETUP.md)** - Initial Firebase configuration
- **[.cursorrules](./.cursorrules)** - AI development guidelines

## 🔧 Development

### Code Generation
After modifying files with annotations (`@freezed`, `@riverpod`, etc.):
```bash
# Watch mode (auto-regenerate)
dart run build_runner watch --delete-conflicting-outputs

# Single build
dart run build_runner build --delete-conflicting-outputs
```

### Testing
```bash
flutter test
```

## 🔥 Firebase Setup

See [FIREBASE_COOK_SETUP.md](./FIREBASE_COOK_SETUP.md) for complete instructions.

**Quick checklist:**
- ✅ Enable Firestore Database
- ✅ Configure Firestore security rules
- ✅ Enable Firebase Storage
- ✅ Configure Storage security rules
- ✅ Enable Email/Password authentication
- ✅ Add demo accounts

---

**Note**: This project demonstrates Clean Architecture, role-based auth, and real-time Firebase integration with Flutter best practices.

