import 'package:flutter/material.dart';
import 'package:flutter_calendar_widget/presentation/calendar_screen/widgets/calendar_widget.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.shade300,
                      width: 2.0,
                    ),
                    borderRadius:
                        const BorderRadius.all(Radius.circular(20.0))),
                child: const CalendarWidget()),
          ),
        ],
      ),
    );
  }
}
