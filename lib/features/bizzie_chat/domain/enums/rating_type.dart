enum RatingType {
  positive,
  negative;

  static RatingType fromString(String value) {
    return switch (value) {
      'positive' => RatingType.positive,
      'negative' => RatingType.negative,
      _ => RatingType.positive,
    };
  }
}
