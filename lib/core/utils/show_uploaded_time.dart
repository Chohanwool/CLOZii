String showUploadedTime(DateTime createdAt) {
  final now = DateTime.now().millisecondsSinceEpoch;
  final diff = now - createdAt.millisecondsSinceEpoch;
  final duration = Duration(milliseconds: diff);

  if (diff < Duration.millisecondsPerMinute) {
    final s = duration.inSeconds;
    return '$s sec${s == 1 ? '' : 's'}';
  }
  if (diff < Duration.millisecondsPerHour) {
    final m = duration.inMinutes;
    return '$m min${m == 1 ? '' : 's'}';
  }
  if (diff < Duration.millisecondsPerDay) {
    final h = duration.inHours;
    return '$h hr${h == 1 ? '' : 's'}';
  }
  // 하루 이상
  final d = duration.inDays;
  return '$d day${d == 1 ? '' : 's'}';
}
