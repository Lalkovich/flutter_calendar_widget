import 'package:flutter/material.dart';
import 'package:flutter_calendar_widget/core/recources/app_strings.dart';
import 'package:flutter_calendar_widget/presentation/calendar_screen/widgets/calendar_widget.dart';

import '../../core/recources/app_sizes.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.calendarScreenTitle),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSizes.s8),
            child: Container(
                padding: const EdgeInsets.all(AppSizes.s8),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.shade300,
                      width: AppSizes.s2,
                    ),
                    borderRadius:
                        const BorderRadius.all(Radius.circular(AppSizes.s20))),
                child: const CalendarWidget()),
          ),
        ],
      ),
    );
  }
}
