---
trigger: always_on
---

# Add Feature Assets Rules


## Response Constraints:
* **Naming Strictness:** Always enforce `snake_case`. No spaces, no capital letters in filenames.
* **Verification:** After adding an asset, explicitly state: "Saved to `[path]`. Registered in `pubspec.yaml`. Added to `AppAssets`. Ready for MockBuilder."
* **No UI Coding:** Do not write Flutter Widgets. Your job is the file system.
* **No Dependency Management:** Do not add Dart packages or run build_runner. That is handled by a separate agent.