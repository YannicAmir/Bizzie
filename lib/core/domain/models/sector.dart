enum Sector {
  energy,
  materials,
  industrials,
  consumerDiscretionary,
  consumerStaples,
  healthCare,
  financials,
  informationTechnology,
  communicationServices,
  utilities,
  realEstate;

  const Sector();

  static Sector? fromString(String value) {
    try {
      final normalizedValue = value
          .toLowerCase()
          .replaceAll(' ', '')
          .replaceAll('_', '');
      return Sector.values.firstWhere(
        (e) => e.name.toLowerCase() == normalizedValue || e.name == value,
      );
    } catch (_) {
      return null;
    }
  }
}
