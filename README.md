# ShopEase — Flutter E-Commerce App

A modern, cross-platform e-commerce mobile application built with Flutter. Features Firebase authentication, a local shopping cart powered by Isar, real-time weather integration, and a clean UI with glass-morphism effects.

---

## Table of Contents

- [Features](#features)
- [Tech Stack](#tech-stack)
- [Architecture](#architecture)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
  - [Firebase Setup](#firebase-setup)
- [Configuration](#configuration)
- [Project Structure](#project-structure)
- [Available Scripts](#available-scripts)
- [Dependencies](#dependencies)
- [Data Models](#data-models)
- [Roadmap](#roadmap)

---

## Features

### Authentication
- Email & password sign-in and sign-up via Firebase Auth
- Smart auth flow: auto-registers new users, auto-signs in existing ones
- Real-time form validation (email format, strong password, birthday, username)
- User profiles stored securely in Cloud Firestore

### Shopping
- **For You** tab — curated product recommendations
- **Explore** tab — browse trending brands
- Persistent search bar with glass-morphism effect
- Product cards with images, titles, and descriptions
- Brand/vendor tiles with logo and name

### Shopping Cart
- Fully offline-capable cart powered by **Isar** local database
- Add, remove, and adjust item quantities
- Real-time reactive UI updates via streams
- Cart persists across app restarts
- Cart is cleared on sign-out

### Weather Widget
- Integrated OpenWeatherMap API
- Displays temperature, humidity, wind speed, and weather condition
- Shown contextually on the Cart screen

### User Profile
- View authenticated user details (username, email, birthday)
- Sign out with one tap

---

## Tech Stack

| Category | Technology |
|---|---|
| Framework | Flutter (Dart ^3.10.3) |
| State Management | Flutter Riverpod ^3.2.1 |
| Routing | GoRouter ^17.1.0 |
| Authentication | Firebase Auth ^6.2.0 |
| Cloud Database | Cloud Firestore ^6.1.3 |
| Local Database | Isar ^3.1.0+1 |
| HTTP Client | Dio ^5.9.2 |
| UI Extras | Flutter SVG, Staggered Grid View, EasyLoading |
| Fonts | Poppins, DM Sans, SF Pro |

---

## Architecture

The project follows an **MVC-inspired, layered architecture** with Riverpod for reactive state management:

```
lib/
├── configs/        # App-wide constants, themes, routes, asset paths
├── data/           # Data layer: API clients, Isar local DB, network config
├── res/
│   ├── models/     # Pure Dart data models (User, Product, Weather, Cart)
│   └── components/ # Shared/reusable widgets
└── view/           # UI layer
    ├── auth/       # Sign in / Sign up screens + Riverpod notifiers
    ├── home/       # Product browsing screens + providers
    ├── cart/       # Cart management screens + providers
    ├── profile/    # User profile screen + providers
    └── layout/     # Bottom navigation shell
```

**Key patterns:**
- `NotifierProvider` — mutable state (auth, cart operations)
- `FutureProvider` — async one-shot data (user profile, weather)
- `StreamProvider` — real-time reactive data (cart item stream from Isar)
- Service classes (`AuthService`, `LocalDbService`, `WeatherApis`) injected via providers

---

## Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (stable channel)
- Dart SDK `^3.10.3` (bundled with Flutter)
- **Android:** Android Studio + Android SDK
- **iOS:** macOS + Xcode 14+
- A [Firebase](https://console.firebase.google.com/) project
- An [OpenWeatherMap](https://openweathermap.org/api) API key (free tier works)

### Installation

```bash
# 1. Clone the repository
git clone https://github.com/haiderm372/ecommerce-sss.git
cd ecommerce

# 2. Install Flutter dependencies
flutter pub get

# 3. Generate Isar database schema and other generated files
flutter pub run build_runner build --delete-conflicting-outputs

# 4. Run the app (ensure a device/emulator is connected)
flutter run
```

### Firebase Setup

This app requires a Firebase project. If you are setting up your own instance:

1. Create a project at [Firebase Console](https://console.firebase.google.com)
2. Enable **Email/Password** under Authentication → Sign-in methods
3. Create a **Firestore** database (start in test mode for development)
4. Install the FlutterFire CLI and run:

```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

This regenerates `lib/firebase_options.dart` with your project credentials.

> **Note:** The repository ships with pre-configured Firebase credentials for the demo project. For production, replace these with your own credentials and apply proper Firestore security rules.

---

## Configuration

### Weather API

The weather feature uses the [OpenWeatherMap Current Weather API](https://openweathermap.org/current).

1. Register for a free API key at openweathermap.org
2. Open `lib/configs/keys/keys.dart`
3. Replace the placeholder key with your own:

```dart
// lib/configs/keys/keys.dart
const String weatherApiKey = 'YOUR_API_KEY_HERE';
```

The default coordinates are set to **Bahawalpur, Pakistan** (`30.205°N, 71.534°E`). Update these in `lib/data/apis/weather_apis.dart` to match your target location.

### Android Release Signing

To build a signed release APK, create `android/app/key.properties`:

```properties
storePassword=<your-keystore-password>
keyPassword=<your-key-password>
keyAlias=<your-key-alias>
storeFile=<path-to-your.keystore>
```

> This file should be excluded from version control.

---

## Project Structure

```
ecommerce/
├── lib/
│   ├── main.dart                    # App entry point & Riverpod root
│   ├── firebase_options.dart        # Auto-generated Firebase config
│   ├── configs/
│   │   ├── routes/                  # GoRouter route definitions & auth guards
│   │   ├── themes/                  # Color palette, text styles, settings
│   │   ├── keys/                    # API key constants
│   │   ├── assets/                  # Asset path constants
│   │   └── global/                  # Global navigator key / context helpers
│   ├── data/
│   │   ├── apis/                    # WeatherApis (Dio HTTP client)
│   │   ├── configs/                 # Dio base configuration
│   │   └── local_db/                # Isar CartItem schema + LocalDbService
│   ├── res/
│   │   ├── models/                  # UserModel, ForYouModel, CustomerModel, WeatherModel
│   │   └── components/              # SnackbarHelper and other shared widgets
│   └── view/
│       ├── auth/                    # AuthScreen, AuthNotifier, AuthService
│       ├── home/                    # HomeScreen, HomeData (product/brand data)
│       ├── cart/                    # CartScreen, CartNotifier, CartProvider
│       ├── profile/                 # ProfileScreen, ProfileProvider
│       └── layout/                  # MainLayout, BottomNavBar
├── assets/
│   ├── images/                      # Product & person images (PNG/JPG)
│   ├── icons/                       # UI icons (SVG)
│   └── fonts/                       # Poppins, DM Sans, SF Pro typefaces
├── android/                         # Android native project
├── ios/                             # iOS Xcode project
├── pubspec.yaml                     # Dependencies, assets, fonts
├── analysis_options.yaml            # Flutter linting rules
└── firebase.json                    # Firebase project mapping
```

---

## Available Scripts

```bash
# Run in debug mode
flutter run

# Static analysis
flutter analyze

# Format all Dart code
dart format lib/

# Run tests
flutter test

# Regenerate Isar schema and other generated code
flutter pub run build_runner build --delete-conflicting-outputs

# Build Android APK (debug)
flutter build apk

# Build Android APK (release — requires key.properties)
flutter build apk --release

# Build iOS (release — requires Xcode signing)
flutter build ios --release

# Clean build artifacts
flutter clean && flutter pub get
```

---

## Dependencies

### Production

| Package | Version | Purpose |
|---|---|---|
| `flutter_riverpod` | ^3.2.1 | State management |
| `go_router` | ^17.1.0 | Declarative routing |
| `firebase_core` | ^4.5.0 | Firebase initialization |
| `firebase_auth` | ^6.2.0 | User authentication |
| `cloud_firestore` | ^6.1.3 | User profile storage |
| `isar` | ^3.1.0+1 | Local NoSQL cart database |
| `isar_flutter_libs` | ^3.1.0+1 | Isar native bindings |
| `path_provider` | ^2.1.5 | File system paths for Isar |
| `dio` | ^5.9.2 | HTTP client for Weather API |
| `flutter_svg` | ^2.2.4 | SVG icon rendering |
| `flutter_staggered_grid_view` | ^0.7.0 | Staggered product grid layout |
| `flutter_easyloading` | ^3.0.5 | Loading overlays |
| `mask_text_input_formatter` | ^2.9.0 | Date input masking |
| `intl` | ^0.20.2 | Internationalization |

### Dev

| Package | Purpose |
|---|---|
| `build_runner` | Code generation runner |
| `isar_generator` | Generates Isar collection adapters |
| `flutter_lints` | Recommended Flutter lint rules |

---

## Data Models

### Firestore — `users/{uid}`

| Field | Type | Notes |
|---|---|---|
| `email` | String | User's email address |
| `username` | String | Display name (min 3 chars) |
| `birthday` | String | Format: `DD/MM/YYYY` |

### Isar — `CartItem` (local)

| Field | Type | Notes |
|---|---|---|
| `id` | int | Auto-increment primary key |
| `title` | String | Unique product identifier |
| `image` | String | Asset path |
| `description` | String | Short product description |
| `count` | int | Quantity in cart |

---

## Roadmap

- [ ] Product detail screen
- [ ] Checkout & payment integration
- [ ] Push notifications via Firebase Cloud Messaging
- [ ] Dynamic product catalog from Firestore
- [ ] Order history screen
- [ ] Dark mode support
- [ ] Location permission for automatic weather coordinates

---

## License

This project is for personal and educational use. Feel free to fork and build upon it.
