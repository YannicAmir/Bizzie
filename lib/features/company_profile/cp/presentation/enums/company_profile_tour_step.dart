enum CompanyProfileTourStep {
  companyOverview,
  tabs,
  revenueTab,
  revenueGrowth,
  stayUpdated;

  int get number => index + 1;

  CompanyProfileTourStep? get next =>
      this == values.last ? null : values[index + 1];

  CompanyProfileTourStep? get previous => switch (this) {
    CompanyProfileTourStep.companyOverview ||
    CompanyProfileTourStep.revenueGrowth => null,
    CompanyProfileTourStep.tabs ||
    CompanyProfileTourStep.revenueTab ||
    CompanyProfileTourStep.stayUpdated => values[index - 1],
  };
}
