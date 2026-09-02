<div align="center">

# 🌸 Flower Store — Flutter + Firebase E-Commerce App

### A production-grade flower shop app built on Provider + Firebase (Auth, Firestore, Storage)

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=flat-square&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=flat-square&logo=dart&logoColor=white)
![Provider](https://img.shields.io/badge/State-Provider-13B9FD?style=flat-square)
![Firebase Auth](https://img.shields.io/badge/Auth-Firebase-FFCA28?style=flat-square&logo=firebase&logoColor=black)
![Google Sign-In](https://img.shields.io/badge/OAuth-Google_Sign--In-4285F4?style=flat-square&logo=google&logoColor=white)
![Firestore](https://img.shields.io/badge/Database-Firestore-FFCA28?style=flat-square&logo=firebase&logoColor=black)
![Storage](https://img.shields.io/badge/Storage-Firebase-FFCA28?style=flat-square&logo=firebase&logoColor=black)
![CI](https://github.com/HeshamMoYoussef/Flower_Store/actions/workflows/ci.yml/badge.svg)
![License](https://img.shields.io/badge/License-MIT-green?style=flat-square)

</div>

---

## 📖 Overview

**Flower Store** is a catalog + cart + checkout e-commerce reference app with email/password and Google Sign-In auth, a Firestore-backed user profile, and Firebase Storage for profile images. Like the [Instagram Clone](https://github.com/HeshamMoYoussef/instagram_app), it uses a **pragmatic Provider-based structure** rather than full Clean Architecture layering — documented here as it actually is.

---

## 🏗 Architecture

```
lib/
├── pages/                    # Top-level screens (login, register, home, details, checkout, profile)
├── provider/                 # ChangeNotifier state — the app's real state-management layer
│   ├── cart_provider.dart          # Cart — selected items, running total
│   ├── registered_user_provider.dart   # Email/password auth + Firestore profile writes
│   └── google_sign_in_provider.dart     # Google OAuth sign-in flow
├── shared/                   # Cross-cutting widgets — appbar, drawer, item card, Firestore-backed profile views
├── data/                     # Static/reference data (user_data.dart)
└── utils/                    # Small stateless helpers
```

### Why Provider (not BLoC/Riverpod) here?

Three independent `ChangeNotifier`s (`Cart`, `RegisteredUserProvider`, `GoogleSignInProvider`) each own one narrow slice of state, consumed by whichever widget subtree needs it via `context.watch`/`Provider.of`. There's no cross-feature event choreography the way the Movies app's BLoC needs (multiple concurrent async fetches feeding one screen) — each notifier here is triggered directly by a single user action (add to cart, sign in, sign up) and broadcasts one resulting state change. Provider's minimal ceremony is the right fit for that shape; introducing BLoC's event/state pattern for three independently-triggered notifiers would add boilerplate without adding clarity.

### Data Flow — Cart

```
┌───────────────┐   Provider.of<Cart>   ┌───────────────┐
│  DetailsScreen│──────────────────────▶│  Cart          │  ChangeNotifier
│  "Add to Cart"│   .add(item)          │ (provider/)    │  price, selectedProducts
└───────────────┘                       └───────┬────────┘
                                                 │ notifyListeners()
                                                 ▼
                                        ┌────────────────┐
                                        │  CheckoutScreen │  rebuilds via Consumer<Cart>
                                        └────────────────┘
```

### Data Flow — Registration & Profile

```
┌──────────────┐  newRegisterUser()  ┌──────────────────────┐
│ RegisterPage │────────────────────▶│RegisteredUserProvider│
└──────────────┘                     └──────────┬───────────┘
                                                 │
                          ┌──────────────────────┼──────────────────────┐
                          ▼                      ▼                      ▼
                 ┌─────────────────┐   ┌──────────────────┐   ┌──────────────────┐
                 │  Firebase Auth   │   │Firebase Storage    │   │Firestore write    │
                 │(credential store)│   │(profile image blob) │   │userS/{uid}         │
                 └─────────────────┘   └──────────────────┘   │{username,email,…} │
                                                                └──────────────────┘
```

Google Sign-In (`GoogleSignInProvider`) follows the same shape via `GoogleAuthProvider.credential()` → `FirebaseAuth.instance.signInWithCredential()`, bypassing the Firestore profile-write path since Google already supplies verified identity.

| Layer | Responsibility |
|---|---|
| **pages/** | Screen composition, user interaction |
| **provider/** | `ChangeNotifier` state — cart, auth session, OAuth flow |
| **shared/** | Firestore-backed display widgets, reusable UI |

---

## 🔒 Security Notes (fixed during this audit)

Three real issues were found and corrected, not just documented:

1. **Plaintext password persisted to Firestore.** `newRegisterUser()` wrote the user's raw password into the `userS` collection's `"pass"` field — and a profile screen (`data_from_firestore.dart`) displayed it back in plain text. **Fixed:** the field is no longer written, and the display row has been removed entirely. Firebase Auth remains the sole credential store.
2. **OAuth tokens logged to console.** `GoogleSignInProvider.signInWithGoogle()` `debugPrint`'d the Google access token and ID token after every sign-in. **Fixed:** removed — access/ID tokens should never hit application logs.
3. **No Firestore security rules existed in the repo.** The Firebase project had no `firestore.rules` committed, meaning the actual access policy lived only in the Firebase console, invisible to code review. **Fixed:** added ownership-scoped rules — a signed-in user may only create/update/delete their own `userS` document; all else denied by default.
4. **Vulnerable transitive dependency.** `flutter_launcher_icons` was unconstrained and pulled `archive 3.3.7`, affected by two published security advisories (path traversal, filename spoofing). **Fixed:** pinned to `^0.14.4`, resolving `archive` to the patched `4.2.0`.

If you fork this project, treat these as the security baseline, not the ceiling.

---

## 🚀 Installation & Production Setup

### Prerequisites

- Flutter SDK `>=3.0.6 <4.0.0` (stable channel)
- A Firebase project with Auth (Email/Password + Google), Firestore, and Storage enabled
- [FlutterFire CLI](https://firebase.google.com/docs/flutter/setup) for regenerating `firebase_options.dart` against your own project

### Environment Configuration

```bash
cp .env.example .env       # placeholder for any future non-Firebase secrets
flutterfire configure       # regenerates firebase_options.dart against YOUR Firebase project
```

### Local Development

```bash
git clone https://github.com/HeshamMoYoussef/Flower_Store.git
cd Flower_Store

flutter pub get
flutter run
```

### Deploying Firestore Rules

```bash
firebase deploy --only firestore:rules
```

### Quality Gates (run before every commit)

```bash
dart format --output=none --set-exit-if-changed .
flutter analyze
flutter test
```

### Production Builds

```bash
# Android — release APK
flutter build apk --release --obfuscate --split-debug-info=build/debug-info

# Web — static release bundle
flutter build web --release
```

### Containerized Deployment (Web)

```bash
docker build -t flower-store .
docker run --rm -p 8080:80 flower-store
# → http://localhost:8080
```

---

## 🔁 DevOps & Automation

| Concern | Tooling | Location |
|---|---|---|
| **Continuous Integration** | GitHub Actions | `.github/workflows/ci.yml` |
| **Format Gate** | `dart format --set-exit-if-changed` | CI, pre-commit |
| **Static Analysis** | `flutter analyze` + `flutter_lints` (zero warnings) | CI, `analysis_options.yaml` |
| **Automated Tests** | `flutter test` | CI |
| **Web Deployment Artifact** | `flutter build web --release` | CI artifact |
| **Containerized Runtime** | Docker multi-stage build → Nginx | `Dockerfile` |
| **Dependency Security** | Pinned `flutter_launcher_icons` (resolves `archive` off its advisory-affected version) | `pubspec.yaml` |
| **Release Artifacts** | Android release APK + Web bundle, uploaded per CI run | CI workflow artifacts |

CI pipeline (`ci.yml`) runs on every push/PR to `main`/`master`:

1. **`analyze-and-test`** — install deps → verify formatting → static analysis → unit/widget tests
2. **`build-web`** / **`build-android`** *(both gated on job 1, run in parallel)* — release artifacts

---

## 📦 Tech Stack

| Concern | Package |
|---|---|
| State Management | `provider` |
| Auth | `firebase_auth`, `google_sign_in` |
| Database / Storage | `cloud_firestore`, `firebase_storage` |
| Image Handling | `image_picker` |
| Validation | `email_validator`, `flutter_pw_validator` |
| App Icons | `flutter_launcher_icons` |

---

## 🛰 Modernization Roadmap

- **Introduce a repository/interface seam** between `provider/` and Firebase SDK calls — the same dependency-inversion pattern used in the Books/Posts/Movies apps — so Firestore/Auth could be mocked in widget tests without touching UI code.
- **Move order/checkout persistence to a proper `orders` collection** with server-side validation (Cloud Function) rather than only client-side cart state, so a completed order survives app restarts and isn't purely ephemeral.
- **Field-level Firestore validation** (`request.resource.data.keys().hasOnly([...])`, type checks) layered onto the ownership rules already in place.
- **CI-integrated dependency-audit step** (`flutter pub outdated` / `dart pub deps` piped through an advisory check) so a regression like the pinned `archive` CVE is caught automatically in future PRs, not only during a manual audit.

---

## 📂 Project Structure Philosophy

This repo is a **teaching reference** for a Provider-based e-commerce flow. It demonstrates:

1. How **narrow, single-purpose `ChangeNotifier`s** keep state management simple when there's no cross-feature async choreography to justify BLoC.
2. Why **credential and security hygiene** (no plaintext passwords, no token logging, explicit Firestore rules) belongs in every project regardless of its architectural sophistication.
3. How **CI automation** enforces the same formatting/lint/test bar a production team would hold, independent of which state-management pattern a given app uses.

---

<div align="center">

Made with 💙 by [Hesham Mohamed Youssef](https://github.com/HeshamMoYoussef) — Firebase-backed apps built with production security discipline.

</div>
