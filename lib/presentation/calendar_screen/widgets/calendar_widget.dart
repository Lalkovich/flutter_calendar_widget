import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../core/recources/app_sizes.dart';
import '../../../utils/box_decoration_util.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  void onHeaderTapped(DateTime focusedDay) {
    final earliestDate = DateTime(2020);
    final latestDate = DateTime(2030);
    if (focusedDay.isBefore(earliestDate)) {
      setState(() {
        _focusedDay = earliestDate;
      });
    } else if (focusedDay.isAfter(latestDate)) {
      setState(() {
        _focusedDay = latestDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.s8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat.yMMMM().format(_focusedDay),
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left),
                    onPressed: () {
                      setState(() {
                        _focusedDay = DateTime(
                          _focusedDay.year,
                          _focusedDay.month - 1,
                          _focusedDay.day,
                        );
                        onHeaderTapped(_focusedDay);
                      });
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.chevron_right),
                    onPressed: () {
                      setState(() {
                        _focusedDay = DateTime(
                          _focusedDay.year,
                          _focusedDay.month + 1,
                          _focusedDay.day,
                        );
                        onHeaderTapped(_focusedDay);
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSizes.s8),
        TableCalendar(
          headerVisible: false,
          firstDay: DateTime.utc(2020, 1, 1),
          lastDay: DateTime.utc(2030, 12, 31),
          focusedDay: _focusedDay,
          calendarFormat: _calendarFormat,
          rangeStartDay: _rangeStart,
          rangeEndDay: _rangeEnd,
          calendarStyle: CalendarStyle(
            rangeHighlightColor: Colors.grey[100] ?? Colors.grey,
            outsideDaysVisible: false,
            rangeStartDecoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            rangeEndDecoration: const BoxDecoration(
              color: Colors.transparent,
            ),
          ),
          calendarBuilders: CalendarBuilders(
            rangeStartBuilder: (context, date, _) => Container(
              margin: const EdgeInsets.all(AppSizes.s6),
              alignment: Alignment.center,
              decoration: buildDecoration(date, _rangeStart!, _rangeEnd),
              child: Text(
                '${date.day}',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            rangeEndBuilder: (context, date, _) => Container(
              margin: const EdgeInsets.all(AppSizes.s6),
              alignment: Alignment.center,
              decoration: buildDecoration(date, _rangeStart!, _rangeEnd),
              child: Text(
                '${date.day}',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            todayBuilder: (context, day, focusedDay) {
              return Container(
                margin: const EdgeInsets.all(AppSizes.s4),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        width: AppSizes.s6,
                        height: AppSizes.s6,
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        '${day.day}',
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              );
            },
            withinRangeBuilder: (context, date, _) => Container(
              margin: const EdgeInsets.all(AppSizes.s8),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.zero,
              ),
              child: Text(
                '${date.day}',
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ),
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              if (_rangeStart == null ||
                  _rangeEnd != null ||
                  selectedDay.isBefore(_rangeStart!)) {
                _rangeStart = selectedDay;
                _rangeEnd = null;
              } else {
                _rangeEnd = selectedDay;
              }
              _focusedDay = focusedDay;
            });
          },
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
          },
        ),
      ],
    );
  }
}
