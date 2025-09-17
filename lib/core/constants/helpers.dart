class Helper {
  static String getFormattedDate() {
    final now = DateTime.now();
    final day = now.day;
    final month = _getMonthName(now.month);
    return '$day $month';
  }

  static String getDayTypeFromDate(String dateString) {
    final date = DateTime.parse(dateString);
    return _getShortDayName(date.weekday);
  }

  static String _getShortDayName(int weekday) {
    const shortDayNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return shortDayNames[weekday - 1];
  }

  static String _getMonthName(int month) {
    const monthNames = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return monthNames[month - 1];
  }

  static String getFormattedDateWithShortMonth({int offsetDays = 0}) {
    final now = DateTime.now().add(Duration(days: offsetDays));
    final day = now.day;
    final month = _getShortMonthName(now.month);
    return '$month, $day';
  }

  static String _getShortMonthName(int month) {
    const shortMonthNames = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return shortMonthNames[month - 1];
  }

  static double scaleToPercentageNum(int value, int min, int max) {
    if (value < min || value > max) {
      throw ArgumentError('Value must be within the range [$min, $max]');
    }
    return 100 - ((value - min) / (max - min) * 100);
  }

  static String getState(String location) {
    return location.split(", ")[1];
  }

  static String getCity(String location) {
    return location.split(", ")[0];
  }

  static String getCountry(String location) {
    return location.split(", ")[2];
  }

  static String getTodayDateFormatted() {
    final now = DateTime.now();
    final year = now.year;
    final month = now.month.toString().padLeft(2, '0');
    final day = now.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }

  static double calculateAverage(List<num?> values) {
    final nonNullValues = values
        .whereType<num>()
        .map((value) => value.toDouble())
        .toList();
    if (nonNullValues.isEmpty) return 0.0;
    final average =
        nonNullValues.reduce((a, b) => a + b) / nonNullValues.length;
    return double.parse(average.toStringAsFixed(1));
  }

  static double calculateAverageGround(List<num?> values) {
    final nonNullValues = values
        .whereType<num>()
        .map((value) => value.toDouble())
        .toList();
    if (nonNullValues.isEmpty) return 0.0;
    return nonNullValues.reduce((a, b) => a + b) / nonNullValues.length;
  }

  static String getFirstDateOfLastWeek() {
    final now = DateTime.now();
    final lastMonday = now.subtract(Duration(days: now.weekday + 6));
    final year = lastMonday.year;
    final month = lastMonday.month.toString().padLeft(2, '0');
    final day = lastMonday.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }

  static String getFirstDateOfLastTwoWeeks() {
    final now = DateTime.now();
    final lastTwoWeeksMonday = now.subtract(Duration(days: now.weekday + 13));
    final year = lastTwoWeeksMonday.year;
    final month = lastTwoWeeksMonday.month.toString().padLeft(2, '0');
    final day = lastTwoWeeksMonday.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }

  static String getFirstDateOfLastThreeWeeks() {
    final now = DateTime.now();
    final lastThreeWeeksMonday = now.subtract(Duration(days: now.weekday + 20));
    final year = lastThreeWeeksMonday.year;
    final month = lastThreeWeeksMonday.month.toString().padLeft(2, '0');
    final day = lastThreeWeeksMonday.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }

  static List<String> getPassedDaysOfCurrentWeek() {
    final now = DateTime.now();
    final firstDayOfWeek = now.subtract(Duration(days: now.weekday - 1));

    return List.generate(now.weekday, (index) {
      final currentDate = firstDayOfWeek.add(Duration(days: index));
      final year = currentDate.year;
      final month = currentDate.month.toString().padLeft(2, '0');
      final day = currentDate.day.toString().padLeft(2, '0');
      return '$year-$month-$day';
    });
  }

  static String getTwoWeeksBeforeIdentifier() {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday + 13));
    final endOfWeek = startOfWeek.add(const Duration(days: 6));
    final startDay = startOfWeek.day;
    final endDay = endOfWeek.day;
    final startMonth = _getMonthName(startOfWeek.month);
    final endMonth = _getMonthName(endOfWeek.month);
    final startYear = startOfWeek.year;
    final endYear = endOfWeek.year;

    if (startMonth == endMonth && startYear == endYear) {
      return '$startDay-$endDay $startMonth $startYear';
    } else {
      return '$startDay $startMonth $startYear - $endDay $endMonth $endYear';
    }
  }

  static String getThreeWeeksBeforeIdentifier() {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday + 20));
    final endOfWeek = startOfWeek.add(const Duration(days: 6));
    final startDay = startOfWeek.day;
    final endDay = endOfWeek.day;
    final startMonth = _getMonthName(startOfWeek.month);
    final endMonth = _getMonthName(endOfWeek.month);
    final startYear = startOfWeek.year;
    final endYear = endOfWeek.year;

    if (startMonth == endMonth && startYear == endYear) {
      return '$startDay-$endDay $startMonth $startYear';
    } else {
      return '$startDay $startMonth $startYear - $endDay $endMonth $endYear';
    }
  }

  static List<String> getDatesOfWeek(String dateString) {
    final date = DateTime.parse(dateString);
    final firstDayOfWeek = date.subtract(Duration(days: date.weekday - 1));
    return List.generate(7, (index) {
      final currentDate = firstDayOfWeek.add(Duration(days: index));
      final year = currentDate.year;
      final month = currentDate.month.toString().padLeft(2, '0');
      final day = currentDate.day.toString().padLeft(2, '0');
      return '$year-$month-$day';
    });
  }

  static bool isDateInCurrentWeek(String dateString) {
    final inputDate = DateTime.parse(dateString);
    final now = DateTime.now();
    final firstDayOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final lastDayOfWeek = firstDayOfWeek.add(const Duration(days: 6));

    return inputDate.isAfter(
          firstDayOfWeek.subtract(const Duration(days: 1)),
        ) &&
        inputDate.isBefore(lastDayOfWeek.add(const Duration(days: 1)));
  }

  static String getFormattedDateWithDay(String dateString) {
    final inputDate = DateTime.parse(dateString);
    final now = DateTime.now();
    final dayName = _getShortDayName(inputDate.weekday);
    final day = inputDate.day;
    final month = _getShortMonthName(inputDate.month);
    final year = inputDate.year;

    if (inputDate.year == now.year &&
        inputDate.month == now.month &&
        inputDate.day == now.day) {
      return 'Today, $day $month $year';
    } else {
      return '$dayName, $day $month $year';
    }
  }

  static int getIndexOfDateInWeek(String dateString) {
    final date = DateTime.parse(dateString);

    // Start of the week (Monday)
    final firstDayOfWeek = date.subtract(Duration(days: date.weekday - 1));

    // Calculate the index of the date within the week
    return date.difference(firstDayOfWeek).inDays;
  }
}
