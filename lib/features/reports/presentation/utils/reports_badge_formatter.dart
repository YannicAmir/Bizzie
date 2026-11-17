class ReportsBadgeFormatter {
  static const int _maxBadgeCount = 9;

  static String formatUnreadCount(int unreadCount) {
    return unreadCount > _maxBadgeCount
        ? '$_maxBadgeCount+'
        : unreadCount.toString();
  }
}
