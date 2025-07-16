class CountdownService {
  // Generic countdown
  static String showHowLong(DateTime targetDate) {
    final now = DateTime.now();

    if (targetDate.isBefore(now)) {
      return "The day has already passed 🎊";
    }

    int years = targetDate.year - now.year;
    int months = targetDate.month - now.month;
    int days = targetDate.day - now.day;

    if (days < 0) {
      months -= 1;
      final prevMonth = DateTime(targetDate.year, targetDate.month, 0);
      days += prevMonth.day;
    }

    if (months < 0) {
      years -= 1;
      months += 12;
    }

    String timeLeft = [
      if (years > 0) "$years years",
      if (months > 0) "$months months",
      if (days > 0) "$days days",
    ].join(', ');

    // Replace last comma with 'and' if there are at least two items
    int lastComma = timeLeft.lastIndexOf(',');
    if (lastComma != -1) {
      timeLeft =
          '${timeLeft.substring(0, lastComma)} and${timeLeft.substring(lastComma + 1)}';
    }

    return "Only $timeLeft left 🎉";
  }
}

// RETIREMENT CALCULATOR
class RetirementCalculator {
  static int retirementAge = 67;

  static DateTime getRetirementDate(DateTime dob) {
    return DateTime(dob.year + retirementAge, dob.month, dob.day);
  }

  static String showRetirementCountdown(DateTime dob) {
    final retirementDate = DateTime(
      dob.year + retirementAge,
      dob.month,
      dob.day,
    );
    return CountdownService.showHowLong(retirementDate);
  }
}
