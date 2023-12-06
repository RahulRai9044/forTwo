extension DateTimeAddCalendarDays on DateTime {
  /// Adds a specified number of days to this [DateTime].
  ///
  /// Unlike `DateTime.add(Duration(days: numberOfDays))`, this adds "days"
  /// and not 24-hour increments, and therefore it leaves the time of day
  /// unchanged if a DST change would occur during the time interval.
  DateTime addCalendarDays(int numDays) => copyWith(day: day + numDays);
}