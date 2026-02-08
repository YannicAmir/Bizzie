String normalizeSectorKey(String input) {
  return input.toLowerCase().replaceAll(' ', '').replaceAll('_', '').trim();
}
