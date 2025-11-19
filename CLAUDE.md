# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

CLOZii is a community-based local marketplace mobile application, similar to Karrot Market (당근마켓). The platform provides neighborhood-focused services including:
- **Used Item Trading**: Buy and sell second-hand goods within local communities
- **Free Sharing**: Share items for free with neighbors
- **Currency Exchange**: Local currency exchange services
- **Community Services**: Additional neighborhood-based utilities

**Technical Stack**:
- Flutter mobile application (iOS/Android)
- Firebase backend (Authentication, Firestore)
- Target market: Philippines (+63 country code for phone authentication)
- Authentication: Phone number-based SMS OTP

## Build & Development Commands

### Code Generation
```bash
# Generate freezed and riverpod files (required after modifying state classes or providers)
dart run build_runner build --delete-conflicting-outputs

# Watch mode for continuous generation during development
dart run build_runner watch --delete-conflicting-outputs
```

### Running the App
```bash
# Run on connected device/emulator
flutter run

# Run with specific flavor/mode
flutter run --debug
flutter run --release
```

### Dependencies
```bash
# Get dependencies
flutter pub get

# Upgrade dependencies
flutter pub upgrade
```

## Architecture & Code Organization

### Clean Architecture with Feature-First Structure

The codebase follows Clean Architecture principles organized by features:

```
lib/
├── core/                           # Shared utilities, widgets, theme
│   ├── constants/                 # App-wide constants
│   ├── theme/                     # Theme configuration
│   ├── utils/                     # Utility functions
│   └── widgets/                   # Reusable widgets
├── features/                      # Feature modules
│   ├── auth/                      # Authentication feature
│   │   ├── core/                  # Feature-specific core (enums, errors)
│   │   ├── data/                  # Data layer (repositories implementation)
│   │   ├── domain/                # Domain layer (entities, repositories, usecases)
│   │   └── presentation/          # Presentation layer (screens, widgets, providers)
│   ├── home/
│   ├── post/
│   └── search/
└── main.dart                      # App entry point
```

### State Management: Riverpod with Code Generation

- **Pattern**: `riverpod_annotation` + `freezed` for immutable state
- **Provider Location**: Each feature has `providers/` directory containing state management
- **Generated Files**: `.g.dart` (riverpod), `.freezed.dart` (freezed) - never edit manually

### Auth Feature Architecture (Reference Implementation)

The auth feature demonstrates the full Clean Architecture implementation:

**Domain Layer** (`domain/`):
- **Entities**: Core business objects (`User`, `AuthResult`)
- **Repositories**: Abstract interfaces (`AuthRepository`)
- **UseCases**: Single-responsibility business logic
  - `SendVerification`: Send SMS verification code
  - `VerifyOtpCode`: Sign up flow (OTP verification + Firestore save)
  - `VerifySignInOtp`: Sign in flow (OTP verification + Firestore fetch)

**Data Layer** (`data/`):
- **Repository Implementations**: `AuthRepositoryImpl` with Firebase integration
- Handles Firebase Auth and Firestore operations

**Presentation Layer** (`presentation/`):
- **Providers**: State management separated by concern
  - `sign_up/sign_up_provider.dart`: Sign up form state
  - `sign_in/sign_in_provider.dart`: Sign in form state
  - `verification/verification_provider.dart`: Shared OTP verification logic
  - `providers/auth_providers.dart`: Dependency injection for domain layer
- **Screens**: Full-page UI components
- **Widgets**: Reusable UI components (forms, fields)

**Mode-Based Screen Sharing**:
- `VerificationScreen` supports both sign up and sign in via `VerificationMode` enum
- Provider distinguishes behavior based on mode parameter

### Firebase Integration

**Authentication**:
- Phone number authentication with SMS OTP (+63 prefix for Philippines)
- Session persistence handled automatically by Firebase SDK
- Token management is automatic (ID tokens refresh every 1 hour using refresh tokens)

**Firestore**:
- User data stored in `users/{uid}` collection
- Sign up: Creates user in Firebase Auth → Saves to Firestore (with rollback on failure)
- Sign in: Verifies OTP → Fetches user from Firestore
- Security rules must allow authenticated users to read/write their own documents

**Critical Flow**: If Firestore save fails during sign up, the Firebase Auth user is deleted to maintain data consistency.

## Key Patterns & Conventions

### Provider Naming
- State classes: `{Feature}State` (e.g., `SignUpState`)
- Provider classes: `{Feature}` (e.g., `SignUp`)
- Provider instances: `{feature}Provider` (e.g., `signUpProvider`)

### Error Handling
- Custom failure classes in `core/errors/`
- Type-based error handling using `is` checks (not string matching)
- Critical errors (e.g., `FirestoreSaveFailure`) trigger special UI flows (modals, rollbacks)

### Korean Language Comments
- Korean comments are used throughout the codebase for developer notes
- UI text is in English for end users

### Phone Number Formatting
- Input format: `0900-000-0000` (with mask)
- Stored format: `+639000000000` (E.164 standard)
- Transformation handled in state properties (`formattedPhoneNumber`)

## Important Files to Check

- `TODO.md`: Project TODO list and improvement backlog
- `lib/features/auth/`: Complete reference implementation of Clean Architecture
- `lib/core/`: Shared utilities and components

## Development Workflow

1. **State Changes**: Modify provider → Run `build_runner` → Check generated files
2. **New Features**: Follow auth feature structure as template
3. **Firebase Changes**: Update security rules separately (not in codebase)
4. **Commits**: Use conventional commits with Korean descriptions (feat:, fix:, refactor:, etc.)
5. **Code Generation**: Always run before committing if state/providers were modified

## Firebase Auth Token Management

- **Automatic**: No manual token handling required
- **Storage**: Tokens stored securely in platform keystores
- **Expiration**: ID tokens expire after 1 hour, automatically refreshed
- **Session**: Persists indefinitely until explicit sign out
- **Security**: Never log or expose tokens in code
