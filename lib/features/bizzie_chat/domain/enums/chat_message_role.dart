/// The role of a participant in a Bizzie chat conversation.
enum ChatMessageRole {
  user,
  assistant;

  /// Maps the raw Firestore string value to a [ChatMessageRole].
  /// Unrecognised values default to [assistant] to avoid silent failures.
  static ChatMessageRole fromString(String value) {
    return switch (value) {
      'user' => ChatMessageRole.user,
      'assistant' => ChatMessageRole.assistant,
      _ => ChatMessageRole.assistant,
    };
  }
}
