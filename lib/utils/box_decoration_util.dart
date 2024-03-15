import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

BoxDecoration buildDecoration(DateTime day, DateTime start, DateTime? end) {
  bool isOneDayTrip = end != null && isSameDay(start, end);

  if (end == null || isOneDayTrip) {
    return const BoxDecoration(
      color: Colors.deepOrange,
      shape: BoxShape.circle,
    );
  } else {
    // Range selection
    bool isStart = isSameDay(day, start);
    bool isEnd = isSameDay(day, end);
    BorderRadiusGeometry radius = BorderRadius.zero;

    if (isStart) {
      radius = const BorderRadius.horizontal(left: Radius.circular(20.0));
    } else if (isEnd) {
      radius = const BorderRadius.horizontal(right: Radius.circular(20.0));
    }

    return BoxDecoration(
      color: isStart || isEnd ? Colors.deepOrange : Colors.grey[200],
      borderRadius: radius,
    );
  }
}
