enum BizzieLifecycleState {
  /// The application is visible and responding to user input.
  foreground,

  /// The application is in the background and not receiving user input.
  background,

  /// The application is in an inactive state (e.g., during a phone call).
  inactive,

  /// The application state is unknown or the view is detached.
  detached,
}
