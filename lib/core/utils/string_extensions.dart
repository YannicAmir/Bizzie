extension StringCaseExtension on String {
  String toTitleCase() {
    if (isEmpty) {
      return this;
    }

    return split('_')
        .map(
          (word) => word.isNotEmpty
              ? '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}'
              : '',
        )
        .join(' ');
  }
}
