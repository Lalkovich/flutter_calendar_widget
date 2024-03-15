import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

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

  BoxDecoration _buildDecoration(DateTime day, DateTime start, DateTime? end) {
    // Визначення, чи є день частиною одноденної подорожі
    bool isOneDayTrip = end != null && isSameDay(start, end);

    if (end == null || isOneDayTrip) {
      // Якщо кінцева дата не встановлена або це одноденна поїздка, використовувати коло
      return BoxDecoration(
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Month and Year
              Text(
                DateFormat.yMMMM().format(_focusedDay),
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Chevron icons
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
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
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
              margin: const EdgeInsets.all(6.0),
              alignment: Alignment.center,
              decoration: _buildDecoration(date, _rangeStart!, _rangeEnd),
              child: Text(
                '${date.day}',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            rangeEndBuilder: (context, date, _) => Container(
              margin: const EdgeInsets.all(6.0),
              alignment: Alignment.center,
              decoration: _buildDecoration(date, _rangeStart!, _rangeEnd),
              child: Text(
                '${date.day}',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            todayBuilder: (context, day, focusedDay) {
              return Container(
                margin: const EdgeInsets.all(4.0),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: 1,
                      top: 1,
                      child: Container(
                        width: 6,
                        height: 6,
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
              margin: const EdgeInsets.all(8.0),
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
            if (_rangeStart == null ||
                (_rangeStart != null && _rangeEnd != null)) {
              // Якщо початкова дата не вибрана, або якщо вже вибрані і початкова, і кінцева дати,
              // встановити вибрану дату як нову початкову дату і скинути кінцеву дату.
              setState(() {
                _rangeStart = selectedDay;
                _rangeEnd = null;
                _focusedDay = focusedDay;
              });
            } else if (selectedDay.isBefore(_rangeStart!)) {
              // Якщо вибрана дата перед початковою, зробити її новою початковою датою.
              setState(() {
                _rangeStart = selectedDay;
                _focusedDay = focusedDay;
              });
            } else if (selectedDay.isAfter(_rangeStart!)) {
              // Якщо вибрана дата після початкової, зробити її кінцевою датою.
              setState(() {
                _rangeEnd = selectedDay;
                _focusedDay = focusedDay;
              });
            } else {
              // Якщо вибрана дата співпадає з початковою, встановити її як кінцеву дату,
              // створюючи таким чином одноденний діапазон.
              setState(() {
                _rangeEnd = selectedDay;
                _focusedDay = focusedDay;
              });
            }
          },
          onFormatChanged: (format) {
            if (_calendarFormat != format) {
              setState(() {
                _calendarFormat = format;
              });
            }
          },
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
          },
        ),
      ],
    );
  }
}
