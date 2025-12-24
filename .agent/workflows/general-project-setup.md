---
description: General set of instructions to start a new Flutter app
---

# Flutter Project Setup Guide

This document details the setup process for the **[App Name]** Flutter project, including the initial agent instructions, the step-by-step execution, and the resulting code structure.

## 1. Initial Prompt Instructions

**Role:** ProjectSetup (Infrastructure & Environment Initializer)
**Objective:** Initialize a new, empty Flutter project with a robust, scalable foundation.

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
Initialize the git repository and committed the base project structure:
```bash
git init
git add .
git commit -m "Initial project setup"
```

### Step 2: Directory Structure
**Commands:**
```bash
rm lib/main.dart
mkdir -p lib/l10n lib/app/themes lib/bootstrap lib/core/enums lib/core/error lib/core/usecase lib/core/network lib/di lib/services lib/features lib/shared/widgets lib/shared/utils lib/shared/constants lib/env
```

### Step 3: Core Files & Entry Points

**`lib/core/enums/environment.dart`**
```dart
enum Environment { dev, qa, prod }
```

**`lib/bootstrap/bootstrap.dart`**
```dart
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:bizzie/app/app.dart';
import 'package:bizzie/core/enums/environment.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';


Future<void> bootstrap(Environment environment) async {
  BizzieLogger.init(dev: !kReleaseMode);
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
*   [iOS Setup](.agent/info/ios_setup_info.md)
*   [Android Setup](.agent/info/android_setup_info.md)


## 3. Next Steps from Here

Instruct the user on the following manual steps to follow outlined in .agent/info/github_push_instructions_info.md, .agent/info/ios_setup_info.md, and .agent/info/android_setup_info.md -- however execute any tasks within these files that you can automatically handle and let the user only handle the manual steps.