# 🚀 Cosmic App

Cosmic App is a Flutter application with a modern space-themed UI.  
It provides interactive content about the solar system with smooth navigation, authentication, and data management.  
The project follows **Clean Architecture** with clear separation between `features` and `core`.

---

## ✨ Features
- Responsive design (mobile & tablet support).
- Clean Architecture with Cubit (Bloc) state management.
- Splash and Onboarding screens.
- User authentication (signup, login, logout).
- CRUD operations for managing favourites.
- Home screen with planets list and details.
- Profile screen with personal progress.


---

## 📂 Project Structure

lib/
│
├── core/ # Shared resources
│ ├── theme/
│ │ ├── app_theme.dart # Global theme data
│ │ ├── app_colors.dart # App color palette
│ │ ├── app_text_styles.dart# Global text styles
│ └── extensions/
│ └── context_extensions.dart # Context shortcuts
│
├── features/ # Each feature is independent
│ ├── splash/ # Splash Screen
│ ├── onboarding/ # Onboarding Screens
│ ├── auth/ # Authentication (login, signup, logout)
│ ├── home/ # Home screen with planets
│ ├── favourites/ # CRUD for favourite planets
│ └── profile/ # User profile & progress
│
└── main.dart # App entry point
