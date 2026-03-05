/// Represents the source of truth for a data request.
/// Used for analytics to track performance and cache effectiveness.
enum CompanyProfileDataOrigin {
  /// Fresh data fetched directly from the remote API.
  api,

  /// Data retrieved from local persistent storage (e.g., Firestore, SQLite).
  db,

  /// Data retrieved from an in-memory or temporary local cache.
  cache,
}
