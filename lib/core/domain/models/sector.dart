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

  String get displayName => switch (this) {
    Sector.energy => 'Energy',
    Sector.materials => 'Materials',
    Sector.industrials => 'Industrials',
    Sector.consumerDiscretionary => 'Consumer Discretionary',
    Sector.consumerStaples => 'Consumer Staples',
    Sector.healthCare => 'Health Care',
    Sector.financials => 'Financials',
    Sector.informationTechnology => 'Information Technology',
    Sector.communicationServices => 'Communication Services',
    Sector.utilities => 'Utilities',
    Sector.realEstate => 'Real Estate',
  };

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
