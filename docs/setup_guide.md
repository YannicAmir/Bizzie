# Flutter Project Setup Guide

This document details the setup process for the **Bizzie** Flutter project, including the initial agent instructions, the step-by-step execution, and the resulting code structure.

## 1. Initial Prompt Instructions

**Role:** ProjectSetup (Infrastructure & Environment Initializer)
**Objective:** Initialize a new, empty Flutter project with a robust, scalable foundation.

**Responsibilities:**
1.  **Initialize Project:** `flutter create` and `.gitignore` setup.
2.  **Directory Structure:** Clean up defaults and enforce `lib/` structure:
    *   `l10n/`, `app/`, `bootstrap/`, `core/`, `di/`, `services/`, `features/`, `shared/`
    *   Entry points: `main_dev.dart`, `main_qa.dart`, `main_prod.dart`
3.  **Environment Configuration:** Generate `bootstrap.dart` and entry point logic.
4.  **IDE Configuration:** `launch.json` for VS Code.
5.  **Secrets Setup:** `envied` pattern in `lib/env/`.

---

## 2. Setup Process & Execution

### Step 1: Initialize Project
```bash
flutter create --org io.getbizzie --project-name bizzie .
```

**`.gitignore` additions:**
```gitignore
# Environment variables
.env
.env.*
!.env.example

# Envied generated files
# lib/env/env.g.dart 
```

### Step 1.5: Git Initialization
Initialized the git repository and committed the base project structure:
```bash
git init
git add .
git commit -m "Initial project setup"
```

### Step 2: Directory Structure
**Commands:**
```bash
rm lib/main.dart test/widget_test.dart
mkdir -p lib/l10n lib/app lib/bootstrap lib/core/enums lib/di lib/services lib/features lib/shared lib/env
```

### Step 3: Core Files & Entry Points

**`lib/core/enums/environment.dart`**
```dart
enum Environment { dev, qa, prod }
```

**`lib/bootstrap/bootstrap.dart`**
```dart
import 'dart:async';
import 'dart:developer';
import 'package:flutter/widgets.dart';
import 'package:bizzie/app/app.dart';
import 'package:bizzie/core/enums/environment.dart';

Future<void> bootstrap(Environment environment) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };
  runApp(const App());
}
```

**Entry Points (e.g., `lib/main_dev.dart`)**
```dart
import 'package:bizzie/bootstrap/bootstrap.dart';
import 'package:bizzie/core/enums/environment.dart';

void main() {
  bootstrap(Environment.dev);
}
```

### Step 4: Secrets (Envied)
**Dependencies:**
```bash
flutter pub add envied
flutter pub add --dev envied_generator build_runner
```

**`lib/env/env.dart`**
```dart
import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'FMP_API_KEY', obfuscate: true)
  static final String fmpApiKey = _Env.fmpApiKey;
}
```

**Generate secrets:**
```bash
dart run build_runner build --delete-conflicting-outputs
```

### Step 5: Platform-Specific Configuration
For platform-specific flavor configurations, please refer to:
*   [Android Setup](android_setup.md)
*   [iOS Setup](ios_setup.md)

### Step 6: IDE Configuration (VS Code)

**`.vscode/launch.json`**
```json
{
    "version": "0.2.0",
    "configurations": [
        // ... (Dev, QA, Prod configurations)
    ]
}
```

## 3. Next Steps from Here

Now that the project structure and environment are set up, please refer to the following documentation for architecture guidelines and development standards:

*   **[Pushing to GitHub](github_push_instructions.md)**: Easy steps to publish your local repository to GitHub using GitHub Desktop.
*   **[Architecture Instructions](architecture_instructions.md)**: Detailed guide on the project's layered architecture, state management, and coding standards.


