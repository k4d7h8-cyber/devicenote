import 'package:intl/intl.dart';

class DateUtilsX {
  /// Adds [months] to [base] while keeping calculations in UTC.
  static DateTime addMonths(DateTime base, int months) {
    final baseUtc = base.toUtc();
    final y = baseUtc.year + ((baseUtc.month - 1 + months) ~/ 12);
    final m = ((baseUtc.month - 1 + months) % 12) + 1;
    final d = baseUtc.day;
    final lastDay = _lastDayOfMonth(y, m);
    final day = d > lastDay ? lastDay : d;
    return DateTime.utc(
      y,
      m,
      day,
      baseUtc.hour,
      baseUtc.minute,
      baseUtc.second,
      baseUtc.millisecond,
      baseUtc.microsecond,
    );
  }

  static int _lastDayOfMonth(int year, int month) {
    final next = month == 12
        ? DateTime.utc(year + 1, 1, 1)
        : DateTime.utc(year, month + 1, 1);
    return next.subtract(const Duration(days: 1)).day;
  }

  /// Returns the day difference keeping both endpoints normalised in UTC.
  static int daysLeft(DateTime from, DateTime to) {
    final fromUtc = DateTime.utc(
      from.toUtc().year,
      from.toUtc().month,
      from.toUtc().day,
    );
    final toUtc = DateTime.utc(
      to.toUtc().year,
      to.toUtc().month,
      to.toUtc().day,
    );
    return toUtc.difference(fromUtc).inDays;
  }

  /// Normalises a calendar date to midnight in UTC.
  static DateTime normalizeToUtcDate(DateTime value) {
    final local = value.toLocal();
    return DateTime.utc(local.year, local.month, local.day);
  }

  /// Formats [value] using the current or provided locale.
  static String formatForLocale(DateTime value, {String? locale}) {
    return DateFormat.yMd(locale).format(value.toLocal());
  }
}
