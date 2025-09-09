import 'package:intl/intl.dart';

class DateUtilsX {
  /// 개월 더하기(윤년/말일 보정)
  static DateTime addMonths(DateTime base, int months) {
    final y = base.year + ((base.month - 1 + months) ~/ 12);
    final m = ((base.month - 1 + months) % 12) + 1;
    final d = base.day;
    final lastDay = _lastDayOfMonth(y, m);
    return DateTime(
      y, m, d > lastDay ? lastDay : d,
      base.hour, base.minute, base.second, base.millisecond, base.microsecond,
    );
  }

  static int _lastDayOfMonth(int year, int month) {
    final next = (month == 12) ? DateTime(year + 1, 1, 1) : DateTime(year, month + 1, 1);
    return next.subtract(const Duration(days: 1)).day;
  }

  /// 남은 일수(자정 기준 단순 계산)
  static int daysLeft(DateTime from, DateTime to) {
    return DateTime(to.year, to.month, to.day)
        .difference(DateTime(from.year, from.month, from.day))
        .inDays;
  }

  static String formatYMD(DateTime dt) => DateFormat('yyyy-MM-dd').format(dt);
}
