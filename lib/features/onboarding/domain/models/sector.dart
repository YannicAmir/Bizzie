enum Sector {
  informationTechnology('Information Technology'),
  financials('Financials'),
  communicationServices('Communication Services'),
  consumerDiscretionary('Consumer Discretionary'),
  healthCare('Healthcare'),
  industrials('Industrials'),
  consumerStaples('Consumer Staples'),
  energy('Energy'),
  utilities('Utilities'),
  materials('Materials'),
  realEstate('Real Estate');

  final String displayName;
  const Sector(this.displayName);

  static Sector? fromString(String value) {
    try {
      return Sector.values.firstWhere(
        (e) =>
            e.displayName.toLowerCase() == value.toLowerCase() ||
            e.name.toLowerCase() == value.replaceAll('_', '').toLowerCase() ||
            e.name == value,
      );
    } catch (_) {
      return null;
    }
  }
}
